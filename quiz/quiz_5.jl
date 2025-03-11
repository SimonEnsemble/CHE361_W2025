### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# ╔═╡ 9a36f800-fa13-11ef-1096-59f4f49e2bb1
begin
	import Pkg; Pkg.activate()
	using Controlz, CairoMakie, DataFrames, Optim, MakieThemes, Dates, CSV

	set_theme!(ggthemr(:fresh))
	update_theme!(fontsize=24, markersize=16, linewidth=3)
end

# ╔═╡ 525a6b54-1bb3-4102-ae81-393b29b774fe
md"
quiz \#5 (18 pts.)

_skills assessed_:
* developing a dynamic model of a physical system via a mass balance
* taking the Laplace transform a dynamic model and deriving a transfer function
* dealing with time delays
* fitting models to data
* approaching inverse problems
* writing code and computational thinking to solve an engineering problem

## an inverse problem of time reversal: inferring when and how much a factory polluted a river

a long river flows into lake \#1. a shorter river from lake \#1 flows into lake \#2. lake \#2 has an outgoing river, too. 

the volumetric flow rates of these rivers are identical and constant, $q$ [m³/hr]. consequently, the volumes of lake \#1 and \#2, $V_1$ [m³] and $V_2$ [m³], are constant. (neglect evaporation, rain, and seeping of water into the ground.)

initially at time $t=0$ [hr], the rivers and lakes were pristine and free of pollutant.
however, a factory upstream of the river flowing into lake \#1 releases a pollutant into the river at a rate $p(t)$ [kg/hr] for $t\geq 0$.

from experiments with a tracer, the water takes a time $\theta_{01}$ [hr] to travel from the factory to lake \#1 and a time $\theta_{12}$ [hr] to travel from lake \#1 to lake \#2. (assume plug flow.)

owing to natural forces, the lakes are well-mixed.

the pollutant is highly stable, so does not decay over the time scale of this problem.
"

# ╔═╡ 3a8490a1-ff2b-4ea2-859f-dc97c7ffa17e
html"<img src=\"https://raw.githubusercontent.com/SimonEnsemble/CHE361_W2025/refs/heads/main/drawings/pollution_two_lakes.png\" width=600>"

# ╔═╡ d283da4a-cc54-4bdf-811c-b806f7cf4389
md"

### ✏ deriving a dynamic model

!!! note
	feel free to use LaTeX in the markdown cells below, or just turn in your hand-written math. show all steps of the derivation.

!!! note
	the nominal steady-state values are $\bar{p}=\bar{c_1}=\bar{c_2}=0$.

!!! warning
	for all variables that are a function of time, explictly write them as so. e.g. $f(t)$ or $f(t-2)$ not just $f$.

!!! hint
	the equations should be linear and time-invariant and include a time delay.

🦩 (1 pt) write a pollutant balance on lake \#1 to arrive at an ordinary differential equation.

```math
? \frac{{\rm d} ?}{{\rm d} ?}=?
```
"

# ╔═╡ e874c5f7-d81b-4a17-bcda-cbec44195498
md"
🦩 (1 pt) write a pollutant balance on lake \#2 to arrive at an ordinary differential equation.

```math
? \frac{{\rm d} ?}{{\rm d} ?}=?
```
"

# ╔═╡ dec5aa11-bd89-4a2e-a442-d118c2601b32
md"
🦩 (1 pt) take the Laplace transform $\mathcal{L}[\cdot]$ of both differential equations to arrive at two coupled algebraic equations for $C_1(s):=\mathcal{L}[c_1(t)]$ and $C_2(s):=\mathcal{L}[c_2(t)]$.

```math
? C_1(s) = ?
```

```math
? C_2(s) = ?
```

"

# ╔═╡ 47fa61b0-2966-4c0e-b159-2d0994d679d5
md"🦩 (2 pt) via some algebra, derive the transfer function that governs the response of the pollutant concentration in lake \#2, $c_2(t)$, to the rate of pollution by the factory, $p(t)$.

```math
G(s) := \frac{C_2(s)}{P(s)}=??
```
"

# ╔═╡ 032d3ff5-e5cc-42cd-92d3-f895870f07cd
md"### 💻 visualizing the pollution time series data

a monitoring station at lake \#2 measures the concentration of the pollutant in the lake every two hours. the measurements by the concentration sensor are noisy. 

the CSV file `pollution_time_series.csv` contains time series data from March 1st to April 12th.

🤷 we do not know exactly:
1. when (the day nor hour) the factory polluted the river. 
2. how much pollutant the factory spilled into the river.

🎯 your job is to leverage the time series data to find out.

!!! warning 
	so, the first data point in `pollution_time_series.csv` is _not_ necessarily the time when the factory began polluting the river. 

upon interrogation, the factory admitted:
> in an isolated and fast event, we accidentally spilled somewhere between 1 kg and 1000 kg of pollutant into the river on some day in March.

🦩 (1/2 pt) read in the CSV file of the time series data as a `DataFrame`.
"

# ╔═╡ 14e33bef-20c1-491d-8448-71b556640f49


# ╔═╡ edc5319a-d369-4487-94e5-db84beec79c2
md"🦩 (1/2 pt) add a new column to the data frame, `time [hr]`, that lists the time since the first data point recorded (arbitrary assigned as time zero for the simulation).

!!! hint
	see [Julia's docs](https://docs.julialang.org/en/v1/stdlib/Dates/) for how to handle the `DataTime`'s in the `datetime` column.
"

# ╔═╡ 7d312e2a-43d6-476a-a20e-da9d639a1b49


# ╔═╡ d2a7bd14-ca42-43f3-b552-3c6953c1787c


# ╔═╡ 008695ad-8dc2-4ff1-8a96-dd6d40c4b3d1


# ╔═╡ 4965c053-7ee8-4efd-a830-7182657eec3d
md"🦩 (1.5 pt)
scatter-plot the time series data $\{(t_i, c_{2, {\rm obs},i})\}$.
* include proper x- and y-axis labels with units
* use square markers that are hollow and transparent on the inside and green on the outside.
* draw a horizontal, dashed line at the ecological limit for the pollutant, 0.1 mg/m³, set by a government agency. this line is meant to draw attention to the seriousness of this pollution event.
* though `CairoMakie` is capable of plotting the data in terms of the `DateTime`s and showing the actual dates and times, plot the data in terms of the \# of hours since recording data (your new column from above).
"

# ╔═╡ e836fd16-7137-4377-8c1c-518ac9720f35


# ╔═╡ 462686a6-cb52-4e18-80ea-2ac3fb7d0e18
md"### 💻 solving the inverse problem

🎯 our goal here is to use the time series data to identify/infer:
1. the mass $p^\star$ [kg] of pollutant that the factory suddenly injected into the river
2. the time $\Psi$ [hr] after the data began (`2025-03-01` at `15:14:00`), that the factory dumped the pollutant into the river.
3. the volumetric flow rates of the rivers, $q$

the known volumes of the lakes and time delays are  below.
"

# ╔═╡ 118a78c2-931b-49e8-81ba-99ae7cabe188
begin
	# volume of lakes
	V₁ = (325.0) ^ 3 # m³
	V₂ = (200.0) ^ 3 # m³

	# time for pollution to travel from factory to lake #1
	θ₀₁ = 72.0 # hour
	# time for pollution to travel from lake #1 to lake #2
	θ₁₂ = 5.0 # hour
end

# ╔═╡ daf4390d-cad2-4790-aea2-e5e370fa3d83
md"🦩 (2 pt) complete the function below that takes as arguments proposed values for the unknowns $p^\star$, $\Psi$, and $q$ and returns _simulated_ (by `Controlz.jl`) times series data of the pollutant concentration in lake \#2 under these proposed parameter/input values.

!!! hint
	pay attention to units for the pollution. pollution input $p^\star$ [kg] yet concentrations in lake $c_i$ [mg/m³].
"

# ╔═╡ 2551f861-c076-490c-bbb3-25abe41c04ba
function simulate_response(
	# mass of pollutant dumped into river by factory
	p★, # kg
	# duration after data begin, that the factory polluted the river
	Ψ,  # hr
	# volumetric flow rate of the rivers
	q,  # m³/hr
	# duration of the simulation
	tf=1500.0 # hr
)
	# define transfer function 
	#   G(s) = C₂(s) / P(s)
	#   under these parameter/input values

	# define input P

	# define output C₂(s)

	# use Controlz.jl to simulate the response c₂(t), giving a data frame

	# return simulated time series data
end

# ╔═╡ 73ec4694-17a8-4007-b303-271a1b4cf9b7
md"🦩 (3 pt) complete the least-squares loss/cost function below that takes are arguments proposed values for the unknowns in the form of a vector $\mathbf{x}:=[p^\star, \Psi, q]$ and returns the sum of square residuals between the recorded time series data and the simulated concentrations in the lake \#2 under those parameter/input values. this function should call the `simulate_response` function above.

!!! hint
	to get the predicted response at a specific time, use `interpolate` in `Controlz.jl`. see [here](https://simonensemble.github.io/Controlz.jl/dev/sim/#y(t)-at-an-arbitrary-time-\\Tau).
"

# ╔═╡ 7ef270c7-ce7f-4a43-8248-66612cb8cfe2
function loss(x)
	# unpack the vector of three values for the parameters/inputs
	p★, Ψ, q = x

	# simulate the response under these parameters/inputs

	# compute loss
	# initialization
    # loop over data
        # extract data point (tᵢ, c₂ᵢ) from data frame

		# compute predicted ĉ₂ᵢ

		# add sum of square residual to loss

	# return loss
end

# ╔═╡ 00bd4dbc-4a13-4040-a946-d97902896062
md"🦩 use your intuition to come up with three rough guesses/estimates for the unknowns $p^\star$, $\Psi$, and $q$."

# ╔═╡ d78040b7-e748-4090-9053-71a4cc274798


# ╔═╡ fcc13cd6-b450-4ce7-a1fb-9251ccda04b1


# ╔═╡ 0e656004-fd17-4d46-8520-512c0a145ed2


# ╔═╡ 07b21cb8-08b6-44ce-8a3e-ef4d76643144
md"🦩 (1 pt) use `Optim.jl`'s `optimize` function to tune the unknown parameters/inputs $p^\star$, $\Psi$, and $q$ to minimize the loss, i.e. to best-fit the time series data $\{(t_i, c_{2i, \rm obs})\}$. display the values of the minimizer."

# ╔═╡ de52b915-9bf6-46f5-b537-a61646ddc190


# ╔═╡ d0bd1b38-cce9-4cc2-bf03-43c01674e1c5


# ╔═╡ 65ae15cc-9a4a-4cc9-a6b4-2269404e1408
md"🦩 (1.5 pt) to ensure your inferred parameter values provide a model that well-fits the time series data, plot on top of the time series data $\{(t_i, c_{2, {\rm obs}, i})\}$ the simulated $c_2(t)$ curve under the inferred values of the inputs/parameters $p^*$, $\Psi$, and $q$. include a legend indicating the points are data and the line is the model."

# ╔═╡ 26e51d1e-f1fa-4e23-9b86-607b32560661


# ╔═╡ 0a3a9914-4d23-4fb4-b7d3-fc413ed090ca


# ╔═╡ bff1c4ae-fd47-4859-b337-5690a527d475
md"🦩 (3 pt) this is a practical inverse problem e.g. for a consulting firm that is enforcing environmental regulations. for a summary report, print below the inferred unknowns in the inverse problem:
1. how much [kg] pollutant you estimate the factory to have dumped into the river
2. your best estimate of the _real_ date and time (`DateTime`) that the factory dumped the pollutant into the river.

round to the nearest 1 kg and 1 hour, respectively, to avoid suggesting you can infer these values so accurately.
"

# ╔═╡ ecd0940b-611f-4d07-a683-59df8f2d7980
print(
	"by comparing the time series data with my mathematical model of the concentration of the pollutant in lake #2, I estimate that:\n\nthe factory polluted the river with ", 
	DateTime(2013, 7, 1, 2), # bogus
	" kg of pollutant\n\tat time ",
    round(1.1341, digits=1) # bogus
)

# ╔═╡ Cell order:
# ╠═9a36f800-fa13-11ef-1096-59f4f49e2bb1
# ╟─525a6b54-1bb3-4102-ae81-393b29b774fe
# ╟─3a8490a1-ff2b-4ea2-859f-dc97c7ffa17e
# ╟─d283da4a-cc54-4bdf-811c-b806f7cf4389
# ╟─e874c5f7-d81b-4a17-bcda-cbec44195498
# ╟─dec5aa11-bd89-4a2e-a442-d118c2601b32
# ╟─47fa61b0-2966-4c0e-b159-2d0994d679d5
# ╟─032d3ff5-e5cc-42cd-92d3-f895870f07cd
# ╠═14e33bef-20c1-491d-8448-71b556640f49
# ╟─edc5319a-d369-4487-94e5-db84beec79c2
# ╠═7d312e2a-43d6-476a-a20e-da9d639a1b49
# ╠═d2a7bd14-ca42-43f3-b552-3c6953c1787c
# ╠═008695ad-8dc2-4ff1-8a96-dd6d40c4b3d1
# ╟─4965c053-7ee8-4efd-a830-7182657eec3d
# ╠═e836fd16-7137-4377-8c1c-518ac9720f35
# ╟─462686a6-cb52-4e18-80ea-2ac3fb7d0e18
# ╠═118a78c2-931b-49e8-81ba-99ae7cabe188
# ╟─daf4390d-cad2-4790-aea2-e5e370fa3d83
# ╠═2551f861-c076-490c-bbb3-25abe41c04ba
# ╟─73ec4694-17a8-4007-b303-271a1b4cf9b7
# ╠═7ef270c7-ce7f-4a43-8248-66612cb8cfe2
# ╟─00bd4dbc-4a13-4040-a946-d97902896062
# ╠═d78040b7-e748-4090-9053-71a4cc274798
# ╠═fcc13cd6-b450-4ce7-a1fb-9251ccda04b1
# ╠═0e656004-fd17-4d46-8520-512c0a145ed2
# ╟─07b21cb8-08b6-44ce-8a3e-ef4d76643144
# ╠═de52b915-9bf6-46f5-b537-a61646ddc190
# ╠═d0bd1b38-cce9-4cc2-bf03-43c01674e1c5
# ╟─65ae15cc-9a4a-4cc9-a6b4-2269404e1408
# ╠═26e51d1e-f1fa-4e23-9b86-607b32560661
# ╠═0a3a9914-4d23-4fb4-b7d3-fc413ed090ca
# ╟─bff1c4ae-fd47-4859-b337-5690a527d475
# ╠═ecd0940b-611f-4d07-a683-59df8f2d7980
