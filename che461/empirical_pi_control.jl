### A Pluto.jl notebook ###
# v0.20.5

using Markdown
using InteractiveUtils

# ╔═╡ 35c82a7a-0bfc-11ef-0258-8d88fde37b4c
begin
	import Pkg; Pkg.activate()
	using Controlz, CairoMakie, MultivariateStats, PlutoUI, DataFrames, CSV, Statistics, Dates, Optim
end

# ╔═╡ d444dfab-4d78-4821-8d7e-3ec5628c39ea
md"# empirical PI controller tuning contest

📖 learning objectives
* fit process models to process response time series data from an experiment via (a) designing a loss function that quantifies the distance between the data and the model with given parameters and (b) an algorithm that minimizes the loss to find the paramaters of best fit.
* apply empirical PI controller tuning rules to arrive at good, data-driven estimates of good PI controller params for a process, with a specific objective (e.g., set point change, or, disturbance rejection)

🤝 **teams**: form a team of 2-3 to collaborate closely with for this assignment. this is a competition for the best PI controller. still, turn in your own studio with your own independent code.
"

# ╔═╡ c0105efb-8389-4ea2-bf10-3618c06db3bb
update_theme!(fontsize=20, size=(400, 400), linewidth=3)

# ╔═╡ b42875d5-6a2a-40eb-bd39-448c409e6ed4
TableOfContents()

# ╔═╡ 846ed565-06d5-4f2b-83f1-abe42fc35fe8
md"## the process

liquid flows into the first tank of three tanks arranged in series. flow out of each tank is autonomous, driven by hydrostatic pressure.
* input: $q(t)$ [L/min] - the flow rate into the first tank
* output: $h_m(t)$ [m] - the measured liquid level in the third tank

our goal is to outfit this process with a PI controller to control the liquid level $h(t)$ in the _third_ tank by manipulating the flow rate $q(t)$ into the _first_ tank.

however, the dynamics of the process are unknown, precluding a model-based design of the PI controller. 
"

# ╔═╡ 138827b1-8767-4a00-b826-9dc1cb795772
html"<img src=\"https://raw.githubusercontent.com/SimonEnsemble/CHE361_W2025/refs/heads/main/drawings/three_tanks_series.png\" width=700>"

# ╔═╡ 85b3dbb7-b7fd-470b-8613-727a2156c26c
md"## the experiment

to gather information about the dynamics of the process, we conduct an experiment that produces process response data. the date of the experiment is April 23, 2025. the process begins at steady-state conditions; then, at time 4:03 AM, we suddenly dump $\Delta q =25$ L of liquid into the first tank and measure the liquid level in the third tank over time, in response.

"

# ╔═╡ c42ec9b3-f281-443f-9903-ec1ff49f01ce
Δq = 25.0 # L

# ╔═╡ 384bd252-e139-47ff-a884-7975b4c5eca6
md"🦫 what is the input $q^*(t)$? write a mathematical expression for it in $\LaTeX$."

# ╔═╡ b4c2b805-5308-479e-b7a8-e93ad53c3706
md"
```math
q^*(t) = ({\color{red} x^3 + 2 \text{ your answer here}})
```
"

# ╔═╡ eec0a022-7972-4da8-a9b0-e13d9d688c0b
md"🦫 `process_data.csv` contains time series data characterizing the response of the process. read in this data as a `DataFrame`."

# ╔═╡ 290aff1c-594d-4359-9a60-916a827b8986


# ╔═╡ 4b7f7b46-3a34-491d-8540-3e98bc8e6488
md"
🦫 append a new column to the data frame, \"t [min]\" that lists the time in minutes, such that $t=0$ corresponds with the input at 4:03 AM (for fitting a model to the process data later, it is necessary to know the time $t$ in minutes after the input.)

!!! note
	see [the docs](https://docs.julialang.org/en/v1/stdlib/Dates/#Dates) for the `Dates` module in Julia.
"

# ╔═╡ 50a8c83f-8c49-445e-b09d-b745852aa593


# ╔═╡ c4188d01-5039-4a29-9e72-ecd0ec509d2b


# ╔═╡ 89fe3095-1588-44d9-aaad-f35475c01e4f
md"🦫 plot the time series data characterizing the response $h_m(t)$ with $t$ in minutes. include x- and y-axis labels with units indicated. make the minimum y-axis limit zero so we have perspective for when the tank is empty.
"

# ╔═╡ 2cb8376b-e1b1-4d5b-af9c-795c3986e9f1


# ╔═╡ 52a2ba6a-021d-4f8d-9614-33e55f60af68
md"## approximate FOPTD model

🦫 compute a good estimate of $\bar{h}$, the nominal steady-state value of the liquid level, via taking the average of the measured liquid level for $t<0$.
"

# ╔═╡ 40717750-7398-49d0-9ab5-0a0f832a2f94


# ╔═╡ 6e7f1f85-71ca-4195-bfde-c6de5c4b2230


# ╔═╡ 075cd5f6-3344-4348-97c7-46089180a7b9
md"🦫 estimate the gain $K$, time constant $\tau$, and time delay $\theta$ of a FOPTD model that best approximates the process response, based on this process response data. specifically, code-up:
1. a function `hₘ(t, K, τ, θ)` that predicts the response $h_m(t)$ given FOPTD params.
2. a loss function `loss(β::Vector{Float64})` that returns the sum of square residuals between the model $h_m(t)$ with params `K, τ, θ = β` and the time series data $\{(t_i, h_{m,i})\}$.
then minimize the loss with respect to $K$, $\tau$, and $\theta$ using the Nelder-Mead algo, to find the FOPTD params that best fit the process response curve. **display the optimal parameters.**

💡 the FOPTD model here is:
```math
\frac{H_m^*(s)}{Q^*(s)} = \frac{Ke^{-\theta s}}{\tau s+1}
```

!!! hint
	see the [Optim.jl docs](https://julianlsolvers.github.io/Optim.jl/stable/user/minimization/).
"

# ╔═╡ b77cd185-8bef-4104-bade-14d761d17858


# ╔═╡ 9a3c608f-6857-4628-b8fd-5826e771fe15


# ╔═╡ 2175ee99-b1ab-4264-a7cd-6777c1fe7f13


# ╔═╡ 9b2b8359-85c9-41c2-b41f-2967f4826c9a


# ╔═╡ 40385198-1aef-4e3d-817f-dbfe3ada45c3


# ╔═╡ 8c997ce2-9534-4400-9e23-79b00533bc3f
begin
	println("best-fit FOPTD model:")
	println("\tK = ", round(K, digits=3))
	println("\tτ = ", round(τ, digits=3))
	println("\tθ = ", round(θ, digits=3))
end

# ╔═╡ 2f68a1f0-948e-4311-a667-1a103d15b6ac
md"## check the fit of your FOPTD model
🦫 simulate the response of your approximate FOPTD model of the process to the same input $q^*(t)$ in the experiment. plot the simulated response on top of the actual process response data. is the fit reasonable for determining PI control parameters? if not, adjust accordingly.

!!! note
	the students who won the competition last year did some post-optimization adjustments... but this is not needed for full credit on the studio.

!!! hint
	see the [Controlz.jl docs](https://simonensemble.github.io/Controlz.jl/dev/sim/#response-of-a-first-order-plus-time-delay-system-to-a-unit-step-input).
"

# ╔═╡ 3cc17724-3684-4fad-bbab-3cb2ec288472


# ╔═╡ 487917c5-13e7-4fa3-92d8-2a0b548ae43e


# ╔═╡ b041a229-43fc-4801-aaaf-25e0ef4b96ee


# ╔═╡ 27e8bffc-48de-4043-ae8d-8ac95cbb65a5
md"## PI controller tuning
now, we outfit the process with a PI controller.
"

# ╔═╡ 7f94789e-69a5-425f-a24d-540de890a8f5
html"<img src=\"https://raw.githubusercontent.com/SimonEnsemble/CHE361_W2025/refs/heads/main/drawings/three_tanks_series_w_control.png\" width=700>"

# ╔═╡ 439ada08-39f7-42e8-a29e-02bd46b3ef1e
md"
🦫 apply empirical tuning rules (see notes on PID controller design) to determine good PI controller settings **tailored to making set point changes**. include units for both $K_c$ and $\tau_I$. this constitues your controller design. print your choice of $K_c$ and $\tau_I$ below.

here, the PI control law specifies the inlet flow rate to the first tank $q^*(t)$ [L/min] in response to the error signal:
```math
 q^*(t) = K_c\left[e(t)+\frac{1}{\tau_I}\int_0^t e(\xi)d\xi\right]
```
with $e(t):=h_{sp}(t)-h_m(t)$ [m].


!!! note
	we're simplifying a bit, since, *in practice*, the communication out of the controller would be an *electrical* signal that propagates through a current-to-pressure transducer then pneumatic control valve before it affects $q^*$.
"

# ╔═╡ beddbabd-5dc5-4fb4-a648-c283d7aada49


# ╔═╡ 7e49d811-62e7-48e6-9fb1-96637e184c6d


# ╔═╡ fd9b768c-ed5c-4134-bec6-0f78412f68aa
begin
	println("I think the PI control params should be:")
	println("\tKc = ", round(Kc, digits=3))
	println("\tτ_I = ", round(τ_I, digits=3))
end

# ╔═╡ a364dc7a-8c41-4839-8154-42293ee277cf
md"🏆 we will judge your $K_c$ and $\tau_I$ by the integral of the time-weighted absolute error during a set point change of +1.0 m. (we have the *true* and *secret* process model 😉.)

**teams**: submit your $K_c$ and $\tau_I$ for the competition on [this Google Form](https://docs.google.com/forms/d/1Vh5VesM4dhpQ1LpR2-G13MXp7U8kRUAUfjwhK04GDr0/edit?ts=680abba3).
"

# ╔═╡ Cell order:
# ╟─d444dfab-4d78-4821-8d7e-3ec5628c39ea
# ╠═35c82a7a-0bfc-11ef-0258-8d88fde37b4c
# ╠═c0105efb-8389-4ea2-bf10-3618c06db3bb
# ╠═b42875d5-6a2a-40eb-bd39-448c409e6ed4
# ╟─846ed565-06d5-4f2b-83f1-abe42fc35fe8
# ╟─138827b1-8767-4a00-b826-9dc1cb795772
# ╟─85b3dbb7-b7fd-470b-8613-727a2156c26c
# ╠═c42ec9b3-f281-443f-9903-ec1ff49f01ce
# ╟─384bd252-e139-47ff-a884-7975b4c5eca6
# ╠═b4c2b805-5308-479e-b7a8-e93ad53c3706
# ╟─eec0a022-7972-4da8-a9b0-e13d9d688c0b
# ╠═290aff1c-594d-4359-9a60-916a827b8986
# ╟─4b7f7b46-3a34-491d-8540-3e98bc8e6488
# ╠═50a8c83f-8c49-445e-b09d-b745852aa593
# ╠═c4188d01-5039-4a29-9e72-ecd0ec509d2b
# ╟─89fe3095-1588-44d9-aaad-f35475c01e4f
# ╠═2cb8376b-e1b1-4d5b-af9c-795c3986e9f1
# ╟─52a2ba6a-021d-4f8d-9614-33e55f60af68
# ╠═40717750-7398-49d0-9ab5-0a0f832a2f94
# ╠═6e7f1f85-71ca-4195-bfde-c6de5c4b2230
# ╟─075cd5f6-3344-4348-97c7-46089180a7b9
# ╠═b77cd185-8bef-4104-bade-14d761d17858
# ╠═9a3c608f-6857-4628-b8fd-5826e771fe15
# ╠═2175ee99-b1ab-4264-a7cd-6777c1fe7f13
# ╠═9b2b8359-85c9-41c2-b41f-2967f4826c9a
# ╠═40385198-1aef-4e3d-817f-dbfe3ada45c3
# ╟─8c997ce2-9534-4400-9e23-79b00533bc3f
# ╟─2f68a1f0-948e-4311-a667-1a103d15b6ac
# ╠═3cc17724-3684-4fad-bbab-3cb2ec288472
# ╠═487917c5-13e7-4fa3-92d8-2a0b548ae43e
# ╠═b041a229-43fc-4801-aaaf-25e0ef4b96ee
# ╟─27e8bffc-48de-4043-ae8d-8ac95cbb65a5
# ╟─7f94789e-69a5-425f-a24d-540de890a8f5
# ╟─439ada08-39f7-42e8-a29e-02bd46b3ef1e
# ╠═beddbabd-5dc5-4fb4-a648-c283d7aada49
# ╠═7e49d811-62e7-48e6-9fb1-96637e184c6d
# ╟─fd9b768c-ed5c-4134-bec6-0f78412f68aa
# ╟─a364dc7a-8c41-4839-8154-42293ee277cf
