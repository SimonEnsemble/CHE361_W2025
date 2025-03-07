### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# ╔═╡ 75eebb20-bdef-11ed-1d40-1f6907086c82
begin
	import Pkg; Pkg.activate()
	using Roots, Controlz, PlutoUI
	using ForwardDiff: gradient
	using CairoMakie

	Controlz.update_theme!(Controlz.cool_theme)
	TableOfContents()
end

# ╔═╡ 6364b356-47e5-4f54-97c9-36989bf3bbd1
md"
### learning objectives

* practice linearization
* numerically solve a nonlinear algebraic equation
* numerically differentiate a function
* derive a transfer function from a linearized model
* simulate and analyze the step response of a first-order system
* recognize the limitations of a linearized model

# linearization of a model for the CPU cooling system

the central processing unit (CPU) of a computer is cooled via a fan blowing air across it. 

the temperature of the air, $\theta_a$ [°C], is constant. the fan speed dictates the velocity of air, $v(t)$ [m/min]. 

computations release heat into the CPU at a constant rate $q$ [J/min]. 


a dynamic model for the CPU temperature $\theta(t)$ [°C] in response to these two inputs is:
```math
	C \frac{d\theta}{dt}=U_0\left( 1 + \alpha \sqrt{v(t)}\right)A \left(\theta_a - \theta(t)\right) + q.
```

the heat capacity of the CPU is $C$ [J/°C]. the surface area of the CPU in contact with the air is $A$ [cm$^2$]. the heat transfer coefficient depends on the air velocity: $U_0$ [J/(cm$^2\cdot$°C$\cdot$min)] is the heat transfer coefficient when the fan is off, and $\alpha$ [min$^{1/2}$/m$^{1/2}$] describes its dependence on the velocity of air blown across the CPU.

_input_: $v(t)$

_output_: $\theta(t)$

_nominal steady-state values of input and output_: $\bar{v}, \bar{\theta}$
"

# ╔═╡ f8ca9b91-d0eb-4ae9-a247-7a636308fd1f
html"<img src=\"https://raw.githubusercontent.com/SimonEnsemble/CHE361_W2025/refs/heads/main/drawings/CPU_cooling_linearization.png\" width=600>"

# ╔═╡ ef1adbd3-0efb-4bbb-8e51-44f76b65fc48
md"parameters and steady-state values for the inputs are below."

# ╔═╡ e8474cd3-9a50-42f6-b4b6-f963e05dd053
begin
    #=
    🦩 steady state value of the input
    =#
	# steady-state air velocity
	v̄ = 120.0 # m/min

    #=
    🦩 model parameters
    =#
	# indoor temperature
    θₐ = 25.0 # °C

	# heat generation rate
    q = 1.2 * 60.0 # J / min
	
    # mass of the CPU
    m = 50.0 # g

    # specific heat capacity of the CPU
    cₚ = 0.71 # J / (g ⋅ °C)

    # surface area of CPU in contact with air
    A = 1.5 # cm²

    # heat transfer coefficient when v = 0
    U₀ = 25.0 * 60.0 / 100 ^ 2 # J / (min ⋅ cm² ⋅ °C)

	# dependence of heat transfer coefficient on velocity
	α = 24.0 / sqrt(300.0) # 1 / sqrt(m/min)

	nothing
end

# ╔═╡ c24c8390-a006-4605-baaf-9d369bf246f9
md"🦩 

✏✏✏✏✏

to practice for the final, *on pencil-and-paper*, derive in terms of the variables (_not_ the values):
1. the _linearized_ [approximate] ODE model for how the output $\theta^*(t)$ is affected by the input $v^*(t)$
2. the corresponding transfer function model governing how the output $\Theta^*(s):=\mathcal{L}[\theta^*(t)]$ responds to the input $V^*(s):=\mathcal{L}[v^*(t)]$.
(as usual, the deviation variable e.g. $v^*(t):=v(t)-\bar{v}$.)

!!! hint
	you should obtain a first-order differential equation and first-order transfer function.
✏✏✏✏✏
"

# ╔═╡ 9a840c6e-3f6e-4c4a-999b-dd518f525b8c
md"🦩 use `find_zero` from `Roots.jl` (see [docs](https://github.com/JuliaMath/Roots.jl)) to solve for the steady-state value of the CPU temperature, θ̄ [°C]."

# ╔═╡ 8b26b6ac-0665-4145-af38-dc5f6a88bcae


# ╔═╡ 37b5c960-8e98-4d0e-9477-5cafc0867b3c


# ╔═╡ 565cfc10-b0d4-4b46-875d-d731247df697


# ╔═╡ 25b7aefd-2665-4fdc-a3b8-72f664e83129
# check

# ╔═╡ 39319123-b715-4f8b-8884-dd79c9a235c1
md"🦩 use `gradient` from `ForwardDiff.jl` (see [docs](https://github.com/JuliaDiff/ForwardDiff.jl)) to calculate the appropriate partial derivatives for linearizing the model. assign the two partial derivatives as variables to be used below to define your transfer function."

# ╔═╡ 0cf067d5-4ace-4717-a009-3d638424c915


# ╔═╡ f436cd9b-ad28-4445-a0cc-d3909922b0a1


# ╔═╡ 7ee346e9-a70c-4793-917a-8f2403bd765f
md"🦩 pick one of the derivatives and verify with your pencil-and-paper math."

# ╔═╡ 9a55009f-0b32-462f-881e-531789ed7a28


# ╔═╡ 3d50b237-394d-41db-bd05-7a473f46a561


# ╔═╡ db0c9dc3-a778-4e98-9047-af810105d5f8
md"🦩
define the transfer function $\Theta^*(s)/V^*(s)$ for `Controlz.jl` as a variable `G` below. use the numbers you obtained from `gradient`.
"

# ╔═╡ 4e91887e-3f90-4191-9b8a-e1a86c419b1a


# ╔═╡ 416ac49e-b417-44e0-9a20-a3dd851548f0


# ╔═╡ 42e4e695-7766-41a0-925c-6724c5191f0b


# ╔═╡ c1be81c2-fb98-4281-b07d-ed9f115aa269
md"🦩suppose the fan speed is adjusted such that the velocity of the air blown across the CPU is increased suddenly, at time $t=0$, to 200 m/min.
use `Controlz.jl` to simulate and visualize the response of the CPU temperature $\theta^*(t)$ to this step change then plot $\theta (t)$ (_not_ in deviation form) for $t\in[0, 90]$ min. label your x- and y-axes with what they represent and the appropriate units.
"

# ╔═╡ e8b4c3fe-c19b-4e52-9eab-774e9b4663b0
v_new = 200.0 # m/min

# ╔═╡ 668ac78d-04ef-436b-9615-80fc39113e1e


# ╔═╡ a741c356-ffde-4eac-b2ca-b3fe9ae6ad2d


# ╔═╡ 4da4d170-be7a-4a50-8630-ae00ab4ecf5c


# ╔═╡ 159d286d-0aed-410b-8c70-2f1ec97c1dc6


# ╔═╡ b436581c-d1c9-4180-b512-8dbc35f31f3b
md"🦩does the response match your physical intuition?

[... YOUR ANSWER HERE...]
"

# ╔═╡ f5c936ec-0719-47e6-bc4d-2112fda39ac1
md"🦩what is the new steady-state temperature of the CPU, as a result of the increased fan speed?"

# ╔═╡ e00317ac-9323-4185-9a15-d23658eac791


# ╔═╡ 69d0cfcf-b08c-4eed-8a3a-df58fb7b87de
md"🦩at approximately what time does the CPU temperature reach 40°C?"

# ╔═╡ 00c49642-26e0-48e4-9de7-8566934a4e6b


# ╔═╡ 6983750d-038e-4831-8c13-92471023ad3d
md"
!!! warning
	the ODE model, based on Newton's law of cooling, is nonlinear. the linearized version is only valid for relatively small step changes.

🦩 to observe the linearized model break down, _temporarily_ change `v_new = 1000.0` m/min. does the response make any physical sense?

⚠ change back to `v_new = 200.0` m/min before you turn in your studio!

[... YOUR ANSWER HERE...]
"

# ╔═╡ Cell order:
# ╠═75eebb20-bdef-11ed-1d40-1f6907086c82
# ╟─6364b356-47e5-4f54-97c9-36989bf3bbd1
# ╟─f8ca9b91-d0eb-4ae9-a247-7a636308fd1f
# ╟─ef1adbd3-0efb-4bbb-8e51-44f76b65fc48
# ╠═e8474cd3-9a50-42f6-b4b6-f963e05dd053
# ╟─c24c8390-a006-4605-baaf-9d369bf246f9
# ╟─9a840c6e-3f6e-4c4a-999b-dd518f525b8c
# ╠═8b26b6ac-0665-4145-af38-dc5f6a88bcae
# ╠═37b5c960-8e98-4d0e-9477-5cafc0867b3c
# ╠═565cfc10-b0d4-4b46-875d-d731247df697
# ╠═25b7aefd-2665-4fdc-a3b8-72f664e83129
# ╟─39319123-b715-4f8b-8884-dd79c9a235c1
# ╠═0cf067d5-4ace-4717-a009-3d638424c915
# ╠═f436cd9b-ad28-4445-a0cc-d3909922b0a1
# ╟─7ee346e9-a70c-4793-917a-8f2403bd765f
# ╠═9a55009f-0b32-462f-881e-531789ed7a28
# ╠═3d50b237-394d-41db-bd05-7a473f46a561
# ╟─db0c9dc3-a778-4e98-9047-af810105d5f8
# ╠═4e91887e-3f90-4191-9b8a-e1a86c419b1a
# ╠═416ac49e-b417-44e0-9a20-a3dd851548f0
# ╠═42e4e695-7766-41a0-925c-6724c5191f0b
# ╟─c1be81c2-fb98-4281-b07d-ed9f115aa269
# ╠═e8b4c3fe-c19b-4e52-9eab-774e9b4663b0
# ╠═668ac78d-04ef-436b-9615-80fc39113e1e
# ╠═a741c356-ffde-4eac-b2ca-b3fe9ae6ad2d
# ╠═4da4d170-be7a-4a50-8630-ae00ab4ecf5c
# ╠═159d286d-0aed-410b-8c70-2f1ec97c1dc6
# ╠═b436581c-d1c9-4180-b512-8dbc35f31f3b
# ╟─f5c936ec-0719-47e6-bc4d-2112fda39ac1
# ╠═e00317ac-9323-4185-9a15-d23658eac791
# ╟─69d0cfcf-b08c-4eed-8a3a-df58fb7b87de
# ╠═00c49642-26e0-48e4-9de7-8566934a4e6b
# ╟─6983750d-038e-4831-8c13-92471023ad3d
