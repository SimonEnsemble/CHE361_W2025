### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# ╔═╡ a855718e-9078-11ed-2fd1-73a706483e34
begin
	import Pkg; Pkg.activate()
	using DifferentialEquations, CairoMakie, DataFrames, MakieThemes
	
	# modifying the plot scheme
	# see here for other themes
	#  https://makieorg.github.io/MakieThemes.jl/dev/themes/ggthemr/
	set_theme!(ggthemr(:earth))
	update_theme!(fontsize=20, linewidth=4)
end

# ╔═╡ 1febf009-e353-4fba-90fc-016d1f14e7ba
colors = MakieThemes.GGThemr.ColorTheme[:earth][:swatch]

# ╔═╡ a30a8abb-a625-4453-bf9e-71e3e041ba37
md"# the draining tank (simulation vs. experiment)


**experimental setup.**
we possess a tank with a small hole drilled in its side, at its bottom.
above the hole, the geometry is approximately an inverted, right truncated cone with a square base (neglect the rounded corners). let $L_t$ [cm] be the dimension of the top square base, $L_b$ [m] be the dimension of the bottom square base, and $H$ [m] the height of the tank.

we put water in the tank, filling to an initial liquid height $h(0)=h_0$ [cm].
then, at $t=0$, we allow water to drain through the orifice, driven by gravity that causes hydrostatic pressure in the water near the hole.

🎯 we wish to model $h(t)$ [cm], the height of liquid (above the hole) in our tank at time $t \geq 0$. 

👀 we observe the liquid level over time and collect time series data $\{(t_i, h_i)\}$. 

🤔 we compare the predicted liquid level $h(t)$ to the observed liquid level over time in the experiment.
"

# ╔═╡ 4cc4be51-cc72-4944-ae2e-4ce83d7bcc7b
html"<img src=\"https://github.com/SimonEnsemble/CHE361_W2025/blob/main/drawings/in_class_tank_expt.png?raw=true\" width=500px>"

# ╔═╡ c9e62bfc-738d-470c-8094-c66e180283df
md"## specify tank geometry"

# ╔═╡ 27efd7e0-24a9-4c14-b515-42c9cd7f521d
md"🦫 take length-measurements to characterize the geometry of the tank."

# ╔═╡ 444dd8bb-9c2a-43a1-9b01-3d4465085ef3
md"height of tank"

# ╔═╡ 42b4f36a-d164-411b-867d-849bf0b8da26


# ╔═╡ e6bbe642-f899-43ad-8015-097a65415fe4
md"top and bottom perimeter"

# ╔═╡ 29f37729-12c1-45de-a13b-a71793683c0b


# ╔═╡ aba01fa8-57dc-4373-b674-7cafd02ef22d


# ╔═╡ dd438ccc-343c-4421-95af-a17796dc95e8
md"top and bottom dimensions (approximate as a square)"

# ╔═╡ 29f5ce09-b4ab-4c46-bdfc-80f146ca3474


# ╔═╡ 151c5229-12bb-439e-8a35-1506184deaf3


# ╔═╡ a14f2f7e-8e8a-4751-868a-df4efc0f98e4
md"area of top and bottom bases (squares)"

# ╔═╡ bbae97d5-71a3-4a96-912d-16e56ab19449


# ╔═╡ 8aa9b532-bfe0-407e-8f58-0869bf88b2b6


# ╔═╡ ee537c0a-7cab-4bc2-89bd-3db590b51172
md"area of liquid, from a helicopter view, as a function of liquid level"

# ╔═╡ eeffeefd-5d09-487d-8c62-d5c06fc5355c


# ╔═╡ 3815c34f-60b5-4b03-8959-0cc8e822481a
md"## parameter identification
our dynamic model is:

$$A(h)\dfrac{dh}{dt}=-c\sqrt{h(t)}$$

with the initial condition $h(t)=h_0$.

conduct a quick experiment to identify the $c$ parameter.
"

# ╔═╡ 22c9bf73-68fa-4b2c-8d7a-e3c63e084e10


# ╔═╡ 988b38f2-56be-4ab7-8e96-6c89ef523c33


# ╔═╡ c01e7bd2-9d31-4adc-95bb-75b64608e9df


# ╔═╡ 7dd762b9-8505-4349-9c21-89b3d6117f60


# ╔═╡ 03b5e719-ecff-47fc-8d6e-6c257cce898c
# mean height during this experiment

# ╔═╡ 34a53346-101c-4ed8-b0aa-63a5088f8622


# ╔═╡ bcba0331-ae6b-493b-8a9c-763eb4b07426
md"
## prediction 

predict the trajectory of the liquid level $h(t)$ using the model.

for `DifferentialEquations.jl`, we view the model as:

```math
\begin{equation}
\frac{dh}{dt}=f(h, \mathbf{p}, t) = -c \sqrt{h} / A(h)
\end{equation}
```
where $\mathbf{p}$ is an optional vector of parameters we do not use here.


!!! note
	we use `DifferentialEquations.jl` (documentation [here](https://docs.sciml.ai/DiffEqDocs/stable/)) to numerically solve (well, approximate the solution to) nonlinear differential equations.
"

# ╔═╡ a1bd034e-b160-4687-8bea-fe7bf8b44c12


# ╔═╡ 4abecf6e-9404-4672-bdac-234e735ee817


# ╔═╡ 2ba54ac2-6b75-4e59-9ad5-5997d1b7555c


# ╔═╡ bc95d069-698e-4587-a03e-04c5ea27a9d7
# DifferentialEquations.jl syntax

# ╔═╡ c5d7269b-ba22-4596-a0e6-e2266ad2ccc3
# solve ODE, return data frame

# ╔═╡ 43389dd2-9237-4812-bfe5-a6570f552073
md"🦫 viz the solution.
"

# ╔═╡ 5c1d708e-1442-4a53-941c-5b2013dc34c7
begin
	fig = Figure()
	ax = Axis(
		fig[1, 1],
		xlabel="time, t [s]",
		ylabel="liquid height, h(t) [m]"
	)
	fig
end

# ╔═╡ 0124ddb7-1bb6-44cd-a496-a02ada7b7131
md"## comparison to experiment

🦫 measure time series data $\{(t_i, h_i)\}$ and plot against the simulation.

> The Unreasonable Effectiveness of Mathematics in the Natural Sciences
"

# ╔═╡ 5e6d8bd0-3a2a-4b3c-b44e-7c6a2f8b9f4a


# ╔═╡ e48cc019-a9e5-4a39-85df-81742d0fbb81


# ╔═╡ ca687109-e558-4329-9ba9-5045fc5ee455
exp_data = DataFrame(
	"h [cm]" => [],
	"t [s]" => []
)

# ╔═╡ ee3cf773-0615-4d8e-a9b1-30c22efb0bad
begin
	fig
end

# ╔═╡ Cell order:
# ╠═a855718e-9078-11ed-2fd1-73a706483e34
# ╠═1febf009-e353-4fba-90fc-016d1f14e7ba
# ╟─a30a8abb-a625-4453-bf9e-71e3e041ba37
# ╟─4cc4be51-cc72-4944-ae2e-4ce83d7bcc7b
# ╟─c9e62bfc-738d-470c-8094-c66e180283df
# ╟─27efd7e0-24a9-4c14-b515-42c9cd7f521d
# ╟─444dd8bb-9c2a-43a1-9b01-3d4465085ef3
# ╠═42b4f36a-d164-411b-867d-849bf0b8da26
# ╟─e6bbe642-f899-43ad-8015-097a65415fe4
# ╠═29f37729-12c1-45de-a13b-a71793683c0b
# ╠═aba01fa8-57dc-4373-b674-7cafd02ef22d
# ╟─dd438ccc-343c-4421-95af-a17796dc95e8
# ╠═29f5ce09-b4ab-4c46-bdfc-80f146ca3474
# ╠═151c5229-12bb-439e-8a35-1506184deaf3
# ╟─a14f2f7e-8e8a-4751-868a-df4efc0f98e4
# ╠═bbae97d5-71a3-4a96-912d-16e56ab19449
# ╠═8aa9b532-bfe0-407e-8f58-0869bf88b2b6
# ╟─ee537c0a-7cab-4bc2-89bd-3db590b51172
# ╠═eeffeefd-5d09-487d-8c62-d5c06fc5355c
# ╟─3815c34f-60b5-4b03-8959-0cc8e822481a
# ╠═22c9bf73-68fa-4b2c-8d7a-e3c63e084e10
# ╠═988b38f2-56be-4ab7-8e96-6c89ef523c33
# ╠═c01e7bd2-9d31-4adc-95bb-75b64608e9df
# ╠═7dd762b9-8505-4349-9c21-89b3d6117f60
# ╠═03b5e719-ecff-47fc-8d6e-6c257cce898c
# ╠═34a53346-101c-4ed8-b0aa-63a5088f8622
# ╟─bcba0331-ae6b-493b-8a9c-763eb4b07426
# ╠═a1bd034e-b160-4687-8bea-fe7bf8b44c12
# ╠═4abecf6e-9404-4672-bdac-234e735ee817
# ╠═2ba54ac2-6b75-4e59-9ad5-5997d1b7555c
# ╠═bc95d069-698e-4587-a03e-04c5ea27a9d7
# ╠═c5d7269b-ba22-4596-a0e6-e2266ad2ccc3
# ╟─43389dd2-9237-4812-bfe5-a6570f552073
# ╠═5c1d708e-1442-4a53-941c-5b2013dc34c7
# ╟─0124ddb7-1bb6-44cd-a496-a02ada7b7131
# ╠═5e6d8bd0-3a2a-4b3c-b44e-7c6a2f8b9f4a
# ╠═e48cc019-a9e5-4a39-85df-81742d0fbb81
# ╠═ca687109-e558-4329-9ba9-5045fc5ee455
# ╠═ee3cf773-0615-4d8e-a9b1-30c22efb0bad
