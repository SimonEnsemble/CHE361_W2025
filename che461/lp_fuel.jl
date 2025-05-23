### A Pluto.jl notebook ###
# v0.20.8

using Markdown
using InteractiveUtils

# ╔═╡ 2403b80a-224a-11ee-2a78-110b41bca561
begin
	import Pkg; Pkg.activate()
	using CairoMakie, PlutoUI, JuMP, DataFrames
	import HiGHS

	update_theme!(fontsize=18, linewidth=3)
end

# ╔═╡ de06b2ff-d26c-4aec-9b42-68a8c43d2d6b
TableOfContents()

# ╔═╡ 0b4a5add-c41b-4762-97b6-cf8c44a81b05
md"# designing a cold-weather fuel using linear programming

!!! note
	this assignment comes from \"CBE 30338 Data Analytics, Optimization, and Control\" by J. Kantor and A. Dowling ([link here](https://ndcbe.github.io/controls/notebooks/5/Design-of-a-Cold-Weather-Fuel.html))---with some modifications.

to motivate this problem, Kantor and Dowling state:
> The venerable alcohol stove has been invaluable camping accessory for generations. They are simple, reliable, and in a pinch, can be made from aluminum soda cans.

> Alcohol stoves are typically fueled with denatured alcohol. Denatured alcohol, sometimes called methylated spirits, is a generally a mixture of ethanol and other alcohols and compounds designed to make it unfit for human consumption. An MSDS description of one manufacturer’s product describes a roughly fifity/fifty mixture of ethanol and methanol.

> The problem with alcohol stoves is they can be difficult to light in below freezing weather. The purpose of this notebook is to design of an alternative cold weather fuel that could be mixed from other materials commonly available from hardware or home improvement stores.

let $\mathcal{C}:=(1, ..., C)$ be the list of compounds that could generally comprise our cold-weather fuel and $x_c$ be the mole fraction of component $c \in \mathcal{C}$ comprising the cold-weather fuel (a mixture).

💡 the $x_c$'s are our _decision variables_.

⛺ the _cold-camping temperature_ is -12°C.

🦾 the _incumbent fuel_, denatured alochol, constitutes a 40%/60% mole fraction mixture of ethanol and methanol.
"

# ╔═╡ 91f39f78-6572-4e56-862f-22619480ce6e
T_camp = -12.0 # °C

# ╔═╡ 0171ef6f-d646-47ff-a270-c184c0b444dd
md"## vapor pressure model

the vapor pressure of a fuel quantifies how easy it will be for us to light the fuel. so, we need to model the vapor pressure of a mixture of compounds comprising our cold-weather fuel.

we model the vapor pressure of a _pure_ liquid of component $c \in \mathcal{C}$, $P_c^{\rm vap}$ [mm Hg], at temperature $T$ [°C] using [Antoine's equation](https://en.wikipedia.org/wiki/Antoine_equation):
```math
\log_{10}(P_c^{\rm vap}) = A_c - \dfrac{B_c}{T + C_c}
```

!!! warning
	Antoine's equation with a given parameter set is only valid for a specified range of temperatures. e.g. see the table [here](https://en.wikipedia.org/wiki/Antoine_equation#Example_parameters). 

using [Raoult’s law](https://en.wikipedia.org/wiki/Raoult%27s_law) for ideal mixtures, the vapor pressure of a fuel comprised of a mixture of the $C$ components at temperature $T$ is:
```math
\sum_{c=1}^{C} x_c P_c^{\rm vap}(T)
```
"

# ╔═╡ 459ceb21-c62f-4335-ae29-e31047c1a069
md"## data

the list of candidate compounds $\mathcal{C}$ for comprising the fuel are below, along with their Antoine coefficients. assume these parameters hold for $T \in [-15, 40]$ °C. note, the freezing points of these compounds are well below our cold-camping temperature, so the fuel freezing is not a concern.
"

# ╔═╡ e0675dc5-a493-4550-9b30-5c0e473d3e22
data = DataFrame(
    "compound" => [
		"ethanol", "methanol", "isopropyl alcohol", "acetone", "xylene", "toluene"
	],
    "A" => [8.04494, 7.89750, 8.11778, 7.02447, 6.99052, 6.95464],
    "B" => [1554.3, 1474.08, 1580.92, 1161.0, 1453.43, 1344.8],
    "C" => [222.65, 229.13, 219.61, 224.0, 215.31, 219.48]
)

# ╔═╡ ec01b9f5-b876-4b53-ba8a-d587945e57c2
md"🔥 write a function `vapor_pressure` with two arguments:
1. `T`: the temperature [°C]
2. `compound`: the name of the compound (e.g. \"methanol\")
that then looks up the Antoine parameters of `compound` in the data frame `data` and returns the vapor pressure [mm Hg] of that compound at temperature `T` according to Antoine's equation.
"

# ╔═╡ 2b81bab1-2630-41ca-8bb6-264bff7b1919


# ╔═╡ cfe23af6-300f-4573-ac82-86508997cf67
md"🔥 write a function `vapor_pressure_denatured_alcohol` that takes as an argument the temperature `T` [°C] and returns the vapor pressure of the incumbent camping fuel, denatured alcohol, at that temperature."

# ╔═╡ f3bd9652-c06d-469d-bfdd-32df59f8c2db


# ╔═╡ be9058dd-9593-4a7b-8dea-12df027af364
md"🔥 calculate the vapor pressure of denatured alcohol serving as the incumbent camping fuel, at 30°C, corresponding to a hot day. assign it as a variable for use later."

# ╔═╡ c31646b5-96b2-4b12-a692-fe7190bc7365
T_hot = 30.0 # °C

# ╔═╡ 627a00f7-67a3-4d6c-988c-e2ef9c5f705b


# ╔═╡ 6750725e-3c07-4359-973d-3e6b11a0d499
md"🔥 on a single panel, plot the vapor pressure of each compound as a function of temperature for $T\in[-15, 40]$°C. as always in life, include x- and y-axis labels and a legend to match the color of the curve with the species. and, please, use a `for` loop!

!!! hint
	your plot should look like the plot in 5.6.3 [here](https://ndcbe.github.io/controls/notebooks/5/Design-of-a-Cold-Weather-Fuel.html).
"

# ╔═╡ 8ae3e22e-5c5f-45a7-91a6-6ece14b35a7c


# ╔═╡ efcf7279-9d42-4fb6-a18d-e39de3e775fd
md"🔥 what species has the lowest vapor pressure [for all temperatures plotted]? the highest?"

# ╔═╡ 844c8c44-ddb7-470f-8378-3d19a4fc444c
md"

💬 
"

# ╔═╡ 27803acb-320d-4f23-b21c-c8ecdccd3855
md"## the optimization model

we wish for a cold-weather fuel, comprised of a mixture of the list of compounds $\mathcal{C}$ in the data frame `data`, that exhibits the _maximal_ vapor pressure (for easy lighting) on a cold-weather camping trip with a temperature of -12°C but _also_, for safe and normal operation of the stove on a hot day, exhibits a vapor pressure less than or equal to the incumbent fuel (denatured alcohol) at 30°C.

🔥 do:
* construct a `JuMP.jl` optimization model and attach the decision variables, objective function, and constraints. 
* numerically solve the optimization problem.
* print the optimal composition of the cold-weather fuel in terms of mole fractions of the components.

!!! note
	check out [the diet problem example](https://jump.dev/JuMP.jl/stable/tutorials/linear/diet/) in `JuMP.jl` for how to use `sum`'s and `for` loops when defining the objective function and constraints to avoid tedious hard-coding.

!!! hint
	there is an additional constraint here that is kind of obvious, but you need to specify to the computer.
"

# ╔═╡ 772cb20b-dd62-4eba-9804-ed08f641e33e
begin
	# initiate model
	model = Model(HiGHS.Optimizer)
	set_silent(model)
	
	# define decision variables

	# attach objective function

	# attach first constraint

	# attach second constraint

	# model

	# print the linear program so we can score it easily
	latex_formulation(model)
end

# ╔═╡ 2f05e379-8937-4120-bd92-f753aa13b96a
# better be true!
is_solved_and_feasible(model)

# ╔═╡ 8f1179f5-6a1b-4aa5-a2aa-f53355c78578
# loop thru compounds, print their mol fraction in the optimal mixture


# ╔═╡ 3d52c315-fc2f-4e54-88ac-c0d4cdd3883a
md"

## analyzing the optimal fuel

🔥 visualize the composition of the fuel, in terms of mole fraction vs. compound, via a bar plot with appropriate x- and y-axis labels and units indicated.

!!! hint
	see the [barplot](https://docs.makie.org/dev/reference/plots/barplot) function in `CairoMakie.jl`.
"

# ╔═╡ fba8204b-a19b-4125-a3f9-cde109cc941d


# ╔═╡ 0efaac29-1f44-4644-a292-4ca8df2e606e
md"🔥 what is the vapor pressure of the optimal fuel mixture at the cold-weather camping temperature of -12°C? for comparison, what is the vapor pressure of the incumbent camping fuel (denatured alcohol) at -12°C?"

# ╔═╡ 93406210-da63-4566-933b-0daac9ac8fb0


# ╔═╡ aebf8ac7-e195-4c80-8826-b0c3bb96012c


# ╔═╡ a2bbc9ea-0a3b-4dec-b4ca-f6462d7471d7
md"🔥 plot the vapor pressure of the (1) optimized fuel and (2) incument fuel (denatured alcohol), as a function of temperature. of course, include a legend and x- and y-axis labels."

# ╔═╡ 8b847fd7-1e01-42f6-bd44-6371e603f9dd


# ╔═╡ 089fda51-a3e5-44ab-ad8a-b059f322b7fa
md"

🚀 👏 fantastic, you designed a more temperature-versatile fuel for camping stoves!

🔥 suppose you are backpacking in Alaska, equipped with your new camping fuel. it's a cold, -12°C day. you cross a group of business majors who cannot light their camping stoves. you impress them by lighting yours easily. how would you, in the most *accurate* and *precise* way possible to these business majors, explain to them how you designed the fuel for your camping stove?

!!! note
	assume that these business majors are unfamiliar with the concept of \"vapor pressure\".

!!! note
	this may seem like a silly question. but, it's a valuable skill to explain your reasonings, justifications, calculations, methods, etc. to other folks who are not engineers but nonetheless make decisions or take actions based on your recommendations.

[💬 ]
"

# ╔═╡ Cell order:
# ╠═2403b80a-224a-11ee-2a78-110b41bca561
# ╠═de06b2ff-d26c-4aec-9b42-68a8c43d2d6b
# ╟─0b4a5add-c41b-4762-97b6-cf8c44a81b05
# ╠═91f39f78-6572-4e56-862f-22619480ce6e
# ╟─0171ef6f-d646-47ff-a270-c184c0b444dd
# ╟─459ceb21-c62f-4335-ae29-e31047c1a069
# ╠═e0675dc5-a493-4550-9b30-5c0e473d3e22
# ╟─ec01b9f5-b876-4b53-ba8a-d587945e57c2
# ╠═2b81bab1-2630-41ca-8bb6-264bff7b1919
# ╟─cfe23af6-300f-4573-ac82-86508997cf67
# ╠═f3bd9652-c06d-469d-bfdd-32df59f8c2db
# ╟─be9058dd-9593-4a7b-8dea-12df027af364
# ╠═c31646b5-96b2-4b12-a692-fe7190bc7365
# ╠═627a00f7-67a3-4d6c-988c-e2ef9c5f705b
# ╟─6750725e-3c07-4359-973d-3e6b11a0d499
# ╠═8ae3e22e-5c5f-45a7-91a6-6ece14b35a7c
# ╟─efcf7279-9d42-4fb6-a18d-e39de3e775fd
# ╠═844c8c44-ddb7-470f-8378-3d19a4fc444c
# ╟─27803acb-320d-4f23-b21c-c8ecdccd3855
# ╠═772cb20b-dd62-4eba-9804-ed08f641e33e
# ╠═2f05e379-8937-4120-bd92-f753aa13b96a
# ╠═8f1179f5-6a1b-4aa5-a2aa-f53355c78578
# ╟─3d52c315-fc2f-4e54-88ac-c0d4cdd3883a
# ╠═fba8204b-a19b-4125-a3f9-cde109cc941d
# ╟─0efaac29-1f44-4644-a292-4ca8df2e606e
# ╠═93406210-da63-4566-933b-0daac9ac8fb0
# ╠═aebf8ac7-e195-4c80-8826-b0c3bb96012c
# ╟─a2bbc9ea-0a3b-4dec-b4ca-f6462d7471d7
# ╠═8b847fd7-1e01-42f6-bd44-6371e603f9dd
# ╠═089fda51-a3e5-44ab-ad8a-b059f322b7fa
