### A Pluto.jl notebook ###
# v0.20.5

using Markdown
using InteractiveUtils

# ╔═╡ e548009a-faa1-11ee-1600-05d467db87e3
begin
	import Pkg; Pkg.activate()
	using Controlz, CairoMakie, Optim, DataFrames, PlutoUI, Dates
end

# ╔═╡ 229b3d17-90fc-4db9-824d-4fe02c20a1ef
update_theme!(size=(400, 400), linewidth=3, fontsize=20)

# ╔═╡ e87ce324-2e2b-4eb4-bec4-c6ccf9263076
TableOfContents()

# ╔═╡ ba41cfed-bd8a-4b63-be06-af041ded8f5f
now() # keep this here.

# ╔═╡ 7b7476b8-598e-4d07-b576-a7438213d653
md"
🤓 the *learning objectives* are:
* observe how I-action eliminates steady state offset error that otherwise, with P-control, persists
* recognize the value of process models for evaluating and choosing between different proposed PI controller settings
* score the quality of PI controller parameters based on a simulated closed loop response with e.g. time-weighted integral of the absolute error.
* practice numerical integration of data

# evaluating PI controller parameters via simulations of the closed-loop response

our task is to evaluate different PI controller parameters for the closed loop below. we have:
* a model for the dynamics of the sensor, through $G_s(s)$
* a model for the dynamics of the output of the process $Y(s)$ in response to changes in
  * the manipulated variable $U^*(s)$, through $G_u(s)$
  * the disturbance variable $D^*(s)$, through $G_d(s)$

units of $s$: min$^{-1}$
"

# ╔═╡ 4a6bc087-bddf-44e2-b54e-6b70e0229355
html"<img src=\"https://raw.githubusercontent.com/SimonEnsemble/CHE461_S2024/main/images/closed_loop.jpg\" width=650>"

# ╔═╡ 502bde1d-e3e2-46ab-829d-8be29f6185d9
# how does the manipulated variable u affect the output y?
Gu = 4 * exp(-0.04 * s) / (3.25 * s + 1)

# ╔═╡ 6a513f76-5153-46eb-af06-437c647610ad
# how does the disturbance variable d affect the output y?
Gd = -1.8 / (5 * s + 1)

# ╔═╡ 0b58b6ed-1adf-4131-bb69-1b4f5563b087
# dynamics of the sensor measuring the output
Gs = exp(-0.2 * s) / (0.1 * s + 1)

# ╔═╡ b889c062-18d1-4a1a-a0d1-2196e2cb4fd2
md"
## predicting the closed-loop response under given controller settings

💡 with this process model, we can predict the closed-loop response to a disturbance under various PI controller parameters---and choose the best ones as a good starting point for the PI controller for the _real_ process.

!!! note
	🎛️ \"tuning\" a PI controller constitutes finding values of the controller gain $K_c$ and integral time constant $\tau_I$ that tend to yield a \"good\" (judged by some metric) closed-loop response to disturbances and/or set points.

🍕 write a function `sim_closed_loop(K_c, τ_I)` that:
* simulates the closed-loop response to a unit step input in the disturbance variable $D^*(s)$ for $t\in[0, 25]$ min with
  * `K_c`: PI-controller gain
  * `τ_I`: integral time constant [min]
* returns time series data characterizing the output $y^*(t)$.


!!! note
	owing to the time delays, you _must_ use the `ClosedLoopTransferFunction` data structure to construct the closed-loop transfer function. see the `Controlz.jl` docs [here](https://simonensemble.github.io/Controlz.jl/dev/tfs/#closed-loop-transfer-functions) and [here](https://simonensemble.github.io/Controlz.jl/dev/controls/#feedback-loops-with-time-delays). 
"

# ╔═╡ 4bee5ec0-3ca1-40df-aa72-65b9aefb2556
function sim_closed_loop(K_c, τ_I)
	# define the unit step in the disturbance
	
	# define the PI controller transfer function

	# define the closed-loop transfer function for the response to a disturbance

	# define the closed loop response (i.e. the output)

	# simulate the closed-loop response

	# return the time series data of the output
end

# ╔═╡ 1a10f575-a836-4c2a-907e-93dec355bd40
md"🍕 simulate the closed-loop response for the following controller settings:
* no control ($K_c=0$)
*  $K_c=0.2$, $\tau_I=1.0$ min
*  $K_c=0.2$, $\tau_I=0.3$ min
*  $K_c=1.0$, $\tau_I=0.4$ min
*  $K_c=1.75$, $\tau_I=0.4$ min
and plot the closed-loop responses $y^*(t)$ in the same panel (different colors) for facile comparison. include a legend (that doesn't overlap with the curves) to indicate which controller setting belongs to which colored curve.
"

# ╔═╡ 26a9bd47-fe31-44d5-8c62-0e5cecc321f4
PI_controller_params = [
	# no control
	(; K_c=0.0, τ_I=1.0),
	
	# weaker controller
	(; K_c=0.2, τ_I=1.0), # smaller I-action
	(; K_c=0.2, τ_I=0.3), # bigger I-action
	
	# stronger controller
	(; K_c=1.0, τ_I=0.4),
	
	# quite aggressive controller
	(; K_c=1.75, τ_I=0.4),
]

# ╔═╡ d7835cdb-fcc5-4b70-89a3-2203d7ace1d7
typeof(PI_controller_params[1]) # each entry of the vector is a NamedTuple.

# ╔═╡ cf0303df-d0f9-411b-8844-6f17dd580b13
PI_controller_params[2].K_c # to see how to grab data from a NamedTuple.

# ╔═╡ 57c3d685-5a7a-4464-9414-0374dc561b1f
# [optional to use] to help you out with formatting a nice label :)
function params_to_label(p::NamedTuple)
	return rich("K", subscript("C"), "=$(p.K_c), τ", subscript("I"), "=$(p.τ_I)")
end

# ╔═╡ 55d91b4d-25a5-40fe-a221-4a8280e4cf8c
begin
	fig = Figure(size=(500, 800))

	# axis for disturbance
	ax_d = Axis(
		fig[1, 1], xlabel="t [min]", ylabel="d*(t)"
	)
	hidexdecorations!(ax_d, grid=false)
	rowsize!(fig.layout, 1, Relative(0.2))
	lines!(ax_d, [-5, -eps(), eps(), 25], [0, 0, 1, 1], color="black")

	# axis for output
	ax_y = Axis(
		fig[2, 1], xlabel="t [min]", ylabel="y*(t)"
	)
	
	linkxaxes!(ax_d, ax_y)

	# your code here

	xlims!(-1, 25)
	fig
end

# ╔═╡ cc14d57a-e2b7-4d01-898d-b50ef265ba4c
md"

!!! warning
	since I-action is $\frac{K_c}{\tau_I} \int_0^t e(\theta)d\theta$, larger $\tau_I$ actually implies _less_ emphasis on the integral term. an interpretation of $\tau_I$: the time taken for I-action to equate P-action when the error is constant and non-zero.

🍕 for the two settings with the same controller gain $K_c=0.2$, which setting (the one with the higher value of $\tau_I$ or lower value of $\tau_I$?):
* produced oscillations that took longer to decay (precisely, have a smaller decay ratio, which is the ratio of successive peak heights) and were higher frequency?
* after the disturbance, _first_ brought the controlled variable back to its set point?
* gave the minimal value of the maximum absolute error in the closed loop response due to the disturbance?

🍕 over all settings, which controller setting brings, after the disturbance, the controlled variable back to the set point _first_?

   [🎤 ... ]

🍕 for this controller setting, how does the [settling time](https://en.wikipedia.org/wiki/Settling_time) of the closed-loop response compare with the other settings?

   [🎤 ... ]

🍕 which controller setting exhibits the minimal value of the maximum absolute error in the closed loop response due to the disturbance?

   [🎤 ... ]

💡 there are many aspects/features of a closed-loop response. likely, there will be tradeoffs involved in choosing PI controller parameters (e.g. a large setting time may be traded for a small max absolute error). the ITAE metric below looks at errors over the whole time interval... 
"

# ╔═╡ 7a8e8f7d-a72e-4e28-ac44-8dcb3dd3200c
md"
## scoring the quality of the closed-loop response under a particular controller setting with ITAE

let's score the performance of a particular PI-controller setting for the closed-loop response to a disturbance with the ITAE (integral of time-weighted absolute error):
```math
{\rm ITAE} := \int_{0\, {\rm min}}^{25\, {\rm min}} t \lvert e(t) \rvert dt
```
we wish for the lowest ITAE possible; minimizing the ITAE penalizes non-zero errors, with errors at larger times penalized more (loosely, linking to the notion of a settling time). n.b., ITAE is a function of (a) the PI controller parameters $K_c$ and $\tau_I$ and (b) the input to the closed-loop system (a step disturbance, an impulse disturbance, a set point change, etc.).

🍕 write a function `ITAE(K_c, τ_I)` that:
1. calls `sim_closed_loop` to simulate the closed-loop response to a step disturbance with those values of PI-controller params
2. computes the ITAE metric numerically from the time series data using the [Trapezoidal rule](https://en.wikipedia.org/wiki/Trapezoidal_rule).
"

# ╔═╡ e9e3c57e-4a7c-4443-a560-b9ce593a88a9
function ITAE(K_c::Float64, τ_I::Float64)
end

# ╔═╡ 010eeaf1-6841-4d7d-bc6b-8871c82cea91
md"🍕 for numerical integration to well-approximate the true integral, the spacing $\Delta t$ needs to be small. pass `nb_time_points=400` into your `simulate()` call in `sim_closed_loop` to ensure you have high resolution."

# ╔═╡ bbd4de84-4f94-480e-a32a-3fae0648b513
md"🍕 compute the ITAE for each PI-controller setting above. according to the ITAE, which controller setting is the best?"

# ╔═╡ dd17e6f3-26fb-4566-89ea-97163b054a85


# ╔═╡ 9172ae0d-0955-41f3-9b2c-2283ddb09aa8
for (i, p) in enumerate(PI_controller_params)
	println("K_c=", p.K_c, "  τ_i=", p.τ_I)
	println("\tITAE=", 0.0) # put ur ITAE here
end

# ╔═╡ 156ee5f0-0cfc-42cb-b3e3-d3e25d6826ff


# ╔═╡ 9315052d-7aa2-4f1f-8d0e-7f1ec1d21ce0
md"🍕 does your judgement of which PI controller settings are best agree with what the ITAE tells us?

   [🎤 ... ]
"

# ╔═╡ Cell order:
# ╠═e548009a-faa1-11ee-1600-05d467db87e3
# ╠═229b3d17-90fc-4db9-824d-4fe02c20a1ef
# ╠═e87ce324-2e2b-4eb4-bec4-c6ccf9263076
# ╠═ba41cfed-bd8a-4b63-be06-af041ded8f5f
# ╟─7b7476b8-598e-4d07-b576-a7438213d653
# ╟─4a6bc087-bddf-44e2-b54e-6b70e0229355
# ╠═502bde1d-e3e2-46ab-829d-8be29f6185d9
# ╠═6a513f76-5153-46eb-af06-437c647610ad
# ╠═0b58b6ed-1adf-4131-bb69-1b4f5563b087
# ╟─b889c062-18d1-4a1a-a0d1-2196e2cb4fd2
# ╠═4bee5ec0-3ca1-40df-aa72-65b9aefb2556
# ╟─1a10f575-a836-4c2a-907e-93dec355bd40
# ╠═26a9bd47-fe31-44d5-8c62-0e5cecc321f4
# ╠═d7835cdb-fcc5-4b70-89a3-2203d7ace1d7
# ╠═cf0303df-d0f9-411b-8844-6f17dd580b13
# ╠═57c3d685-5a7a-4464-9414-0374dc561b1f
# ╠═55d91b4d-25a5-40fe-a221-4a8280e4cf8c
# ╟─cc14d57a-e2b7-4d01-898d-b50ef265ba4c
# ╟─7a8e8f7d-a72e-4e28-ac44-8dcb3dd3200c
# ╠═e9e3c57e-4a7c-4443-a560-b9ce593a88a9
# ╟─010eeaf1-6841-4d7d-bc6b-8871c82cea91
# ╟─bbd4de84-4f94-480e-a32a-3fae0648b513
# ╠═dd17e6f3-26fb-4566-89ea-97163b054a85
# ╠═9172ae0d-0955-41f3-9b2c-2283ddb09aa8
# ╠═156ee5f0-0cfc-42cb-b3e3-d3e25d6826ff
# ╟─9315052d-7aa2-4f1f-8d0e-7f1ec1d21ce0
