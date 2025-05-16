### A Pluto.jl notebook ###
# v0.20.8

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    return quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ 35c82a7a-0bfc-11ef-0258-8d88fde37b4c
begin
	import Pkg; Pkg.activate()
	using Controlz, CairoMakie, PlutoUI, DataFrames, Printf, NumericalIntegration
end

# ╔═╡ c0105efb-8389-4ea2-bf10-3618c06db3bb
set_theme!(Controlz.cool_theme); update_theme!(fontsize=20, size=(400, 400), linewidth=3, axis=(; titlefont=:regular))

# ╔═╡ b42875d5-6a2a-40eb-bd39-448c409e6ed4
TableOfContents()

# ╔═╡ e817a7c0-d3e8-4548-a70d-268876e3e752
md"# D-action for set point changes: a Goldilocks problem

📗 learning objectives:
* understand how to eliminate derivative kick in response to set point changes
* practice block diagram algebra
* understand and explore the influence of D-action on the quality of the closed-loop response (key conclusion: adding D-action is a [Goldilocks problem](https://en.wikipedia.org/wiki/Goldilocks_principle).)
"

# ╔═╡ 85b3dbb7-b7fd-470b-8613-727a2156c26c
md"## the closed-loop level control system

liquid flows into the first tank of three tanks arranged in series. flow out of each tank is autonomous, driven by gravity (which causes hydrostatic pressure at the bottom of each tank to drive flow). 

a PID feedback controller (LC = level controller) is set up to maintain the liquid level in the _third_ tank, $h_3(t)$ [m], at a set point $h_{3,sp}^*(t)$ [m] by manipulating the flow rate $q(t)$ [L/min] into the _first_ tank.
"

# ╔═╡ e5f10301-7688-453d-afaa-4d51ef2bcccf
html"<img src=\"https://raw.githubusercontent.com/SimonEnsemble/CHE361_W2025/refs/heads/main/drawings/three_tanks_series_studio.png\" width=500>"

# ╔═╡ 9f7659bb-bcf7-4d17-989f-d5901098a0cd
md"a block diagram depicting the closed loop designed for set point changes is below. the D-action is based on the _measurement_ of the liquid level instead of the error, to avoid derivative kick in response to set point changes."

# ╔═╡ c89c567a-ba6a-40fc-bd2f-71f2f4220010
html"<img src=\"https://raw.githubusercontent.com/SimonEnsemble/CHE361_W2025/refs/heads/main/drawings/Dkick_closed_loop.png\" width=750>"

# ╔═╡ 20090772-a121-44e1-b05a-aba1ca57e362
md"at steady-state conditions:
* the flow rate into the first tank is $\bar{q}$ [L/min]
* the liquid level in the all three tanks is $\bar{h}$ [m], since the outlet pipes are all identical
(values below.)
"

# ╔═╡ 384bd252-e139-47ff-a884-7975b4c5eca6
begin
	q̄ = 1.2                  # [L/min]
	h̄ = h̄₁ = h̄₂ = h̄₃ = 5.0   # [m]
end

# ╔═╡ 6fdf4c0f-cc05-460f-8ad5-03dcddf178a6
md"## the process and sensor dynamics

the transfer function models for the process and sensor dynamics are below, with $s[=]$min.
```math
G_1(s)=\frac{2.4}{s+1}.
```
```math
G_2(s)=\frac{e^{-0.05s}}{2.5s+1}.
```
```math
G_3(s)=\frac{e^{-0.05s}}{3.3s+1}.
```
```math
G_s(s)=e^{-0.15s},
```

🍉 code up the transfer functions below for use later.
"

# ╔═╡ 648b635e-a358-4a9c-8702-c4ed107ad62a


# ╔═╡ 4e579ee3-f607-4deb-ba1b-7acde26b9956


# ╔═╡ ca3b4619-b1f3-420d-8da9-cae51d07b307


# ╔═╡ 0587077f-e29f-47d5-b496-7dedb5753af6


# ╔═╡ 7b2953f8-a299-498b-ac29-877da5212c9e
md"## the PID controller

the settings for the PID controller are below. while the controller gain $K_c$ [L/(min⋅m)] and integral time constant $\tau_I$ [min] are set, we have a slider bar for the derivative time constant $\tau_D \in [0, 3]$ [min] to explore its effect on the closed-loop response.
"

# ╔═╡ 6ab3d542-0796-4b24-a64e-8a124a229c8c
Kc = 0.75 # L/(min⋅m)

# ╔═╡ 0547b70d-4402-49e0-b6aa-23c66ddc5ce8
τᵢ = 6.0 # min

# ╔═╡ 481ec6bd-5c53-4c8d-8b67-41c4c461e3b1
md"derivative time constant $\tau_D$ [min]: $(@bind τd PlutoUI.Slider(0.0:1.0:3.0))"

# ╔═╡ 23aa6939-50be-4147-bb1e-c95a11e48a1e
τd # min

# ╔═╡ 23c64c35-5057-4c8d-a333-13dc05f5c83c
md"## a set point change in the liquid level

suppose we make a set point change of +8 m (i.e., a step) in the liquid level in the third tank at $t=0$.

🍉 code-up the set point `H₃ₛₚ★` below (in the frequency domain).
"

# ╔═╡ d8f43c46-2ea5-442b-8bc6-8a38565f1b22


# ╔═╡ ca6f47bc-842b-4fc2-b7ec-4205511db0dc
md"## the closed loop response of the liquid level to the set point change under PID control

🍉 simulate, for $t \in [0, 30.0]$ min the response of the closed-loop system to the set point change in the liquid level. particularly, simulate and plot in a two-panel plot (shared $t$-axis):
* top panel: the flow rate $q(t)$ [L/min] into the first tank, dictated by the PID controller
* bottom panel: the liquid level in each of the three tanks, $h_i(t)$ [m] for $i\in\{1, 2, 3\}$ and the set point $h_{3,sp}(t)$. include a legend to show correspondence between the color of the curve and the tank number.

!!! note
	_not_ in deviation form.

!!! hint
	you need to do block diagram algebra for each. two novelties: (1) the D-action operates on the measurement of the liquid level instead of the error. (2) you need to derive the closed-loop response of not just the output, but intermediate variables including the manipulated variable. you'll need to use the `ClosedLoopTransferFunction` data structure to handle the time delays. see [here](https://simonensemble.github.io/Controlz.jl/dev/controls/#feedback-loops-with-time-delays). 
"

# ╔═╡ bd98b53b-928c-44b1-ba9d-ef36674d4449
tf = 30.0 # min

# ╔═╡ d53f495b-4619-416f-9de6-b6fe4eab3352


# ╔═╡ 8aeca381-9d9d-43d9-bbb6-9b44add76991


# ╔═╡ 6e63ac2d-28a8-4d21-a008-be37c7a6a71d


# ╔═╡ 2bef3bc2-2d70-4780-ae04-7c0db551ecb2


# ╔═╡ 39cf38de-401e-41ec-8dd9-585824b23196


# ╔═╡ fc07a3b4-e132-43cd-8349-0cdebc9bef09


# ╔═╡ 94691b43-b4a5-4441-be81-1ee505114637


# ╔═╡ a5b194f1-c66d-4025-9414-ca649904bc6d


# ╔═╡ 1355ea50-0960-4d23-be22-fcda7ee6aab4
begin
	fig = Figure(size=(600, 600))
	axs = [Axis(fig[i, 1], titlefont=:regular) for i = 1:2]
	linkxaxes!(axs...)

	# top panel (manipulated variable)
	axs[1].ylabel = "q [L/min]"

	# bottom panel (hᵢ for i = 1,2,3 and h₃ₛₚ)
	axs[2].xlabel = "time [min]"
	axs[2].ylabel = "hᵢ(t) [m]"
	
	xlims!(-2, tf)
	ylims!(axs[2], 0, 25.0)
	fig
end

# ╔═╡ 1392fc72-1aaf-49ea-a024-652ef2381cd9
md"## calculating the ITAE performance metric

🍉 based on the simulated closed-loop response $h_3^*(t)$ [m], write code to compute the controller performance metric: the integral of the time-weighted absolute error (ITAE).

!!! hint
	for computing the ITAE, check out the `NumericalIntegration.jl` package [here](https://github.com/JuliaMath/NumericalIntegration.jl), which makes this exercise *much* easier. 😃
"

# ╔═╡ 7496301e-a611-4e3c-aa51-221322193b78


# ╔═╡ e86a92d7-bea0-4a78-aee3-30d8033347c2


# ╔═╡ 32dd054b-cb07-44ad-9e04-3f44546e394a
md"## tuning the D-action to achieve optimal performance

🍉 use the slider bar to change $\tau_D$ and fill out the table below.


| $\tau_D$ [min] | ITAE [m⋅min] |
| ---- | ---- |
| 0.0 |   |
| 1.0 |    |
| 2.0 |  |
| 3.0 |  |

!!! hint
	you should find that an *intermediate* value of $\tau_D$ is optimal...
"

# ╔═╡ 4a891418-4462-4d89-bc2a-6fe51a140b80
md"🍉 (based on the pattern of the data in your table) regarding the influence of D-action on the closed-loop response to set point changes, what do you conclude? what is the best value of $\tau_D$? what is the Goldilocks problem here?

[ 💬 if the D-action is too small, ...]

[ 💬 if the D-action is too large, ...]

[ 💬 if the D-action is just right, ...]

(describe the ITAE and closed-loop response $h_3(t)$ for each.)
"

# ╔═╡ Cell order:
# ╠═35c82a7a-0bfc-11ef-0258-8d88fde37b4c
# ╠═c0105efb-8389-4ea2-bf10-3618c06db3bb
# ╠═b42875d5-6a2a-40eb-bd39-448c409e6ed4
# ╟─e817a7c0-d3e8-4548-a70d-268876e3e752
# ╟─85b3dbb7-b7fd-470b-8613-727a2156c26c
# ╟─e5f10301-7688-453d-afaa-4d51ef2bcccf
# ╟─9f7659bb-bcf7-4d17-989f-d5901098a0cd
# ╟─c89c567a-ba6a-40fc-bd2f-71f2f4220010
# ╟─20090772-a121-44e1-b05a-aba1ca57e362
# ╠═384bd252-e139-47ff-a884-7975b4c5eca6
# ╟─6fdf4c0f-cc05-460f-8ad5-03dcddf178a6
# ╠═648b635e-a358-4a9c-8702-c4ed107ad62a
# ╠═4e579ee3-f607-4deb-ba1b-7acde26b9956
# ╠═ca3b4619-b1f3-420d-8da9-cae51d07b307
# ╠═0587077f-e29f-47d5-b496-7dedb5753af6
# ╟─7b2953f8-a299-498b-ac29-877da5212c9e
# ╠═6ab3d542-0796-4b24-a64e-8a124a229c8c
# ╠═0547b70d-4402-49e0-b6aa-23c66ddc5ce8
# ╟─481ec6bd-5c53-4c8d-8b67-41c4c461e3b1
# ╠═23aa6939-50be-4147-bb1e-c95a11e48a1e
# ╟─23c64c35-5057-4c8d-a333-13dc05f5c83c
# ╠═d8f43c46-2ea5-442b-8bc6-8a38565f1b22
# ╟─ca6f47bc-842b-4fc2-b7ec-4205511db0dc
# ╠═bd98b53b-928c-44b1-ba9d-ef36674d4449
# ╠═d53f495b-4619-416f-9de6-b6fe4eab3352
# ╠═8aeca381-9d9d-43d9-bbb6-9b44add76991
# ╠═6e63ac2d-28a8-4d21-a008-be37c7a6a71d
# ╠═2bef3bc2-2d70-4780-ae04-7c0db551ecb2
# ╠═39cf38de-401e-41ec-8dd9-585824b23196
# ╠═fc07a3b4-e132-43cd-8349-0cdebc9bef09
# ╠═94691b43-b4a5-4441-be81-1ee505114637
# ╠═a5b194f1-c66d-4025-9414-ca649904bc6d
# ╠═1355ea50-0960-4d23-be22-fcda7ee6aab4
# ╟─1392fc72-1aaf-49ea-a024-652ef2381cd9
# ╠═7496301e-a611-4e3c-aa51-221322193b78
# ╠═e86a92d7-bea0-4a78-aee3-30d8033347c2
# ╟─32dd054b-cb07-44ad-9e04-3f44546e394a
# ╠═4a891418-4462-4d89-bc2a-6fe51a140b80
