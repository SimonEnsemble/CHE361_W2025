### A Pluto.jl notebook ###
# v0.20.8

using Markdown
using InteractiveUtils

# ╔═╡ 7a733b92-35a6-11f0-0323-f9de5de91771
begin
    import Pkg; Pkg.activate()
    using CairoMakie, PlutoUI, JuMP, DataFrames
    import HiGHS

    update_theme!(fontsize=18, linewidth=3)
end

# ╔═╡ 0972fa30-a86b-47ec-b5e4-f91ebe98dd09
md"# optimal wine blending"

# ╔═╡ 837796eb-0f64-4e3d-8e45-fdf5ff3a358b
html"<img src=\"https://raw.githubusercontent.com/SimonEnsemble/CHE361_W2025/refs/heads/main/drawings/wine_blending.png\" width=400>"

# ╔═╡ a8e05ad9-6817-4c0e-8dca-7434dbc86fc6
md"
🍷 suppose we own a winery and have produced two large vats of wine. one, pure Syrah. the other, pure Grenache. data regarding our costs to produce and the alcohol and acid content of each variety of wine are in the table below.

| wine variety | cost   | alcohol content   | acid content |
|--------------|--------|-------------------|--------------|
| Syrah        | \$4.5/L | 11% by volume     | 0.38 g/L     |
| Grenache     | \$6.5/L | 13% by volume     | 0.31 g/L     |

we wish to blend some of our Syrah and some of our Grenache to obtain a wine meeting the following specifications: 
1. at least 11.5\% alcohol by volume
2. less than 0.36 g/L acid. 
we must deliver 5\,000 L of our Syrah/Grenache blend to a customer who pays \$8/L.

to maximize our profit, what volume of Grenache and what volume of Syrah should we blend together for the customer?

!!! note \"reference\"
	this is a modified version of the problem presented in:
	> D. Putler. \"Getting to Know Optimization: Linear Programming\". Alteryx Blog. 2020. [link](https://community.alteryx.com/t5/Data-Science/Getting-to-Know-Optimization-Linear-Programming/ba-p/513793)
"

# ╔═╡ f030c170-4f8c-4e70-86b1-0944935d550b
md"🍷 below, we put the data regarding the wine into a data frame for convenience."

# ╔═╡ 711f0fb2-3a27-470e-ba4a-66b9f0ead816
data = Dict(
	"cost"    => Dict("Grenache" => 6.5, "Syrah" => 4.5),   # $/L
	"acid"    => Dict("Grenache" => 0.31, "Syrah" => 0.38), # g/L
	"alcohol" => Dict("Grenache" => 13.0, "Syrah" => 11.0), # vol %
	"V"       => 5000.0                                     # total volume, L
)

# ╔═╡ a1ca6688-ed64-4758-9828-c9dc8734f9a4
md"we formulate our problem as a linear program.

the two _decision variables_ are the volume of Syrah and volume of Grenache to blend together for the customer.

the _objective_ is to maximize profit.

the _constraints_ are on the alcohol content and acid content of the wine blend and the total volume of wine we deliver to the customer. not to mention, the non-negative constraints that are obvious to us but not a computer.

🍷 [2 pt] write `JuMP.jl` code below to numerically solve the linear program.
"

# ╔═╡ 643a18d3-69fc-4560-8d17-51f861b6e9fc
begin
	# initialize optimization model
	model = Model(HiGHS.Optimizer)
	set_silent(model)

	# decision variables

	# attach objective function

	#=
	attach constraints
	=#

	# numerically solve the linear program

	# print the linear program
	latex_formulation(model) # keep this so we can score
end

# ╔═╡ 604fe9ed-cfd0-4475-b3a5-e8095ea2f9af
is_solved_and_feasible(model)

# ╔═╡ b7a0fedb-08e6-4556-9d50-52c163f5c451
md"🍷 [1 pt] print the optimal volume of Syrah and volume of Grenache to include in the blend."

# ╔═╡ a437bbba-d0c8-4e85-9f5c-67ce6ee4c79b


# ╔═╡ f8d24f48-f907-4d7c-9166-9b97831cec30
md"🍷 [2 pt] visualize the optimal wine blend with a bar plot. include x- and y-axis labels with units and color the bars `darkred` for a wine theme."

# ╔═╡ 94bb6e34-6e2c-48b1-8d71-7748a732c824


# ╔═╡ a1b38b52-84f2-4c13-b2cf-d63e48aee2df
md"🍷 [1 pt] what is the maximal profit we make from this optimal wine blend?"

# ╔═╡ 4fb28ce0-d26b-4efb-88ba-4d0eab6d38fd


# ╔═╡ e12baa22-e32b-4fda-bd9a-3df2afb402ef
md"🍷 [2 pt] since our design space is two dimensional, we can visualize this linear program. draw in `CairoMakie.jl` the 2D design space, the three constraint lines, and the optimal solution (as a point). include a legend. what is the _feasible set_ of designs here?

!!! hint
	see Cory's previous [blog post on linear programming](https://simonensemble.github.io/pluto_nbs/linear_programming.html).
"

# ╔═╡ 9a0bd383-3358-4100-850b-5b2511310bc8


# ╔═╡ Cell order:
# ╠═7a733b92-35a6-11f0-0323-f9de5de91771
# ╟─0972fa30-a86b-47ec-b5e4-f91ebe98dd09
# ╟─837796eb-0f64-4e3d-8e45-fdf5ff3a358b
# ╟─a8e05ad9-6817-4c0e-8dca-7434dbc86fc6
# ╟─f030c170-4f8c-4e70-86b1-0944935d550b
# ╠═711f0fb2-3a27-470e-ba4a-66b9f0ead816
# ╟─a1ca6688-ed64-4758-9828-c9dc8734f9a4
# ╠═643a18d3-69fc-4560-8d17-51f861b6e9fc
# ╠═604fe9ed-cfd0-4475-b3a5-e8095ea2f9af
# ╟─b7a0fedb-08e6-4556-9d50-52c163f5c451
# ╠═a437bbba-d0c8-4e85-9f5c-67ce6ee4c79b
# ╟─f8d24f48-f907-4d7c-9166-9b97831cec30
# ╠═94bb6e34-6e2c-48b1-8d71-7748a732c824
# ╟─a1b38b52-84f2-4c13-b2cf-d63e48aee2df
# ╠═4fb28ce0-d26b-4efb-88ba-4d0eab6d38fd
# ╟─e12baa22-e32b-4fda-bd9a-3df2afb402ef
# ╠═9a0bd383-3358-4100-850b-5b2511310bc8
