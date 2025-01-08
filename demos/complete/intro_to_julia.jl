### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# ╔═╡ 64d5b078-6eb1-11ec-290d-99aa7b5ace54
begin
	# to use your global package installations, instead of specific to this notebook
	import Pkg; Pkg.activate() 
	
	# packages we'll use here.
	using CairoMakie, DataFrames, ColorSchemes, Colors, PlutoUI, MakieThemes
	import CSV.read
	
	# modifying the plot scheme
	# see here for other themes
	#  https://makieorg.github.io/MakieThemes.jl/dev/themes/ggthemr/
	set_theme!(ggthemr(:dust))
	update_theme!(fontsize=20)
end

# ╔═╡ edbcad9f-bbc8-44c9-9165-ce61ee6671c3
md"# Julia bootcamp

**learning objective:** 
* familiarize with some capabilities of the Julia programming language and Pluto notebooks.

> 🔥 computational skills, incl. application of numerical methods to engineering problems, wrangling with and visualizing data, and writing simple computer programs to automate analyses, are very valuable for the modern chemical engineer. -Cory

❓ how do I figure out how to code something up in Julia?
* Julia [docs](https://docs.julialang.org/en/v1/)
* package-specific docs
  * `CSV` package [docs](https://csv.juliadata.org/stable/index.html)
  * `CairoMakie` package [docs](https://makie.juliaplots.org/dev/)
  * `DataFrames` package [docs](https://dataframes.juliadata.org/stable/)
* Google-search \"how do I ... in Julia?\"
* ChatGPT
"

# ╔═╡ 10ef6326-b3c3-44aa-8496-9c6bedfde875
TableOfContents()

# ╔═╡ a9b9a51b-f129-4d45-8b5c-f427296a3660
md"
## Fibonacci sequence

🐸 construct a vector (one-dimensional array) that lists the first 35 numbers of the [Fibonacci sequence](https://en.wikipedia.org/wiki/Fibonacci_number). 

!!! hint
	write a `for` loop.

!!! example \"relevant docs\"
	* [arrays](https://docs.julialang.org/en/v1/manual/arrays/)
	* [for loops](https://docs.julialang.org/en/v1/manual/control-flow/#man-loops)
"

# ╔═╡ 04062259-b30a-47df-b6e7-b39b7ccff01d
begin
	fib_seq = zeros(Int, 35)
	
	fib_seq[1] = 0
	fib_seq[2] = 1
	
	for n = 3:length(fib_seq)
		fib_seq[n] = fib_seq[n - 1] + fib_seq[n - 2]
	end
	
	fib_seq
end

# ╔═╡ edcac259-402e-45ae-a0a3-c662f0bb842c
md"
## plotting a function

🐸 plot (as two curves) the functions:

$y(t)=e^{-t}\sin(10 t)$ 

$y(t)=e^{-2t}\sin(5 t)$ 

over the domain $t\in[0, 6]$. include an x- label on your plot and a legend to indicate which function is which. 

!!! example \"relevant docs\"
	* [line plot](https://docs.makie.org/stable/tutorials/basic-tutorial/#adding_a_plot_to_an_axis)
	* [range constructor](https://docs.julialang.org/en/v1/base/math/#Base.range)
	* [sine function](https://docs.julialang.org/en/v1/base/math/#Base.sin-Tuple{Number})
	* [dot syntax](https://docs.julialang.org/en/v1/manual/functions/#man-vectorized) or [comprehensions](https://docs.julialang.org/en/v1/manual/arrays/#man-comprehensions)
	* [functions](https://docs.julialang.org/en/v1/manual/functions/)
	* [axislegend](https://docs.makie.org/dev/reference/blocks/legend)
"

# ╔═╡ 5f04bb82-5d64-435c-8d0d-e6c439639329
begin
	y(t) = exp(-t) * sin(10 * t)
	z(t) = exp(-2 * t) * sin(5 * t)

	t = range(0.0, 6.0, length=200)
	
	local fig = Figure()
	local ax  = Axis(
		fig[1, 1], 
		xlabel="t"
	)
	lines!(t, y.(t), linewidth=3, label="y(t)")
	lines!(t, z.(t), linewidth=3, label="z(t)", color=Cycled(3))
	axislegend()
	fig
end

# ╔═╡ c0fd10de-0190-4efb-a5ef-89ee08d5fa6c
md"## reading in, plotting data

🐸 download the data set (CSV format) giving the monthly mean CO₂ concentration measured in Mauna Loa from the NOAA [here](https://gml.noaa.gov/ccgg/trends/data.html). read in the data as a `DataFrame` in Julia using the `CSV.read` function. plot the measured CO₂ concentration over time with a green line. include x- and y-axis labels with units.

!!! hint
	look at the raw `.csv` file. the first few lines are comments. use the `comment` keyword argument of the `CSV.read` function to ignore these lines when reading in the file.

!!! example \"relevant docs\"
	* [readdir](https://docs.julialang.org/en/v1/base/file/#Base.Filesystem.readdir)
	* [pwd](https://docs.julialang.org/en/v1/base/file/#Base.Filesystem.pwd)
	* [reading in a CSV](https://csv.juliadata.org/stable/reading.html#CSV.read)
	* [indexing columns of a DataFrame](https://dataframes.juliadata.org/stable/man/basics/#Indexing-Syntax)
	* [line plot](https://docs.makie.org/stable/reference/plots/lines/)
"

# ╔═╡ 08ab9417-f332-4599-a415-e8c710c1ff5b
pwd()

# ╔═╡ 48b6c472-0001-40b2-a0a4-61f1aa906252
readdir()

# ╔═╡ bafac1f9-537c-4c58-ab28-20784891ae8e
data = read("co2_mm_mlo.csv", DataFrame, comment="#")

# ╔═╡ f5692d5e-e9cf-40e6-856c-1acfbf11ef28
begin
	local fig = Figure()
	local ax = Axis(
		fig[1, 1],
		xlabel="year",
		ylabel="CO₂ concentration [ppm]"
	)
	lines!(data[:, "decimal date"], data[:, "average"], color="green")
	ylims!(0, nothing)
	fig
end

# ╔═╡ dbee0556-c275-47df-85a5-1a3899b91002
md"_ambitious Beavers_: what causes the oscillations with a period of one year?"

# ╔═╡ 49592adc-ddc8-431d-a34d-05aedfaf18cc
md"🐸 list the CO₂ concentrations in 1987."

# ╔═╡ c605a438-f29b-4986-96a6-aa152f28fd65
data[data[:, "year"] .== 1987, :]

# ╔═╡ d18ec2aa-ca32-49f9-9a5a-470214d995f5
md"## writing a custom function

🐸 write a function `water_vap_press(T)` that computes then returns the vapor pressure of water [mm Hg] at temperature `T` [°C] using [Antoine's equation](https://en.wikipedia.org/wiki/Antoine_equation). the function should work for temperatures between 1°C and 100°C.

!!! example \"relevant docs\"
	* [functions](https://docs.julialang.org/en/v1/manual/functions/)
"

# ╔═╡ 00f0b5c6-bd5d-435d-932d-926769f14293
function water_vap_press(T)
	if T < 1.0 || T > 100.0
		error("invalid temperature")
	end
	
	# constants for water (source: Wikipedia)
	A = 8.07131
	B = 1730.63
	C = 233.426

	# apply Antoine's equation
	p = 10.0 ^ (A - B / (C + T))
	
	return p
end

# ╔═╡ e1e9c3b8-57a9-4b7f-9622-48ab2ba731b5
md"
🐸 use the function to compute the vapor pressure of water at 25 °C.
"

# ╔═╡ 3506584d-5ade-4d73-84f4-a1cbc6632890
water_vap_press(25.0)

# ╔═╡ d2dd321c-37d3-4809-9cb3-6011918b5283
md"🐸 ensure the function fails with an error message e.g. when trying to compute the vapor pressure at 120°C."

# ╔═╡ 562f9db3-60d9-44ef-93fb-fd3ab9f95ecc
water_vap_press(120.0) # appropriately get an error.

# ╔═╡ 8b58f120-dcdf-40f7-9966-93733c7ed3c2
md"🐸 plot the vapor pressure of water from 1 to 100°C."

# ╔═╡ 88a54f3c-1c97-4b08-8248-921cd65d7c09
# range of temperatures
Ts = range(1.0, 100.0, length=100)

# ╔═╡ 01d4446c-2cc3-4c5b-ab8e-6e9df25294c7
# corresponding vapor pressures
ps = water_vap_press.(Ts)

# ╔═╡ 4cddd124-0eae-45c7-96f3-23e3e53a0613
begin
	# viz
	local fig = Figure()
	local ax = Axis(
		fig[1, 1],
		xlabel="temperature [°C]",
		ylabel="vapor pressure of water [mm Hg]"
	)

	lines!(Ts, ps, linewidth=4)
	hlines!(760.0, linestyle=:dash)
	
	xlims!(0, 100)
	ylims!(0, nothing)
	
	fig
end

# ╔═╡ 6ef14719-48bb-4b5c-8625-6ea35b55b41e
md"## a bar plot

🐸 use a bar plot to depict the prominence of the six most promint mountains in Oregon.
"

# ╔═╡ cc02f51e-c4f0-4ada-9448-6c5c273cd331
mt_data = DataFrame(
	"mountain" => ["Mount Hood", "Sacajawea Peak", "Mount Jefferson", "South Sister", "Rock Creek Butte", "Mount McLoughlin"],
	"prominence [m]" => [2349, 1949, 1767, 1705, 1364, 1364]
)

# ╔═╡ 608c4c9a-dbff-48eb-95af-c924f7ef5d73
begin
	local fig = Figure()
	local ax = Axis(
		fig[1, 1], 
		ylabel="prominence [m]", 
		xticks=(1:nrow(mt_data), mt_data[:, "mountain"]),
		xticklabelrotation=π/2,
		title="prominent mountains in Oregon"
	)
	barplot!(1:nrow(mt_data), mt_data[:, "prominence [m]"])
	ylims!(0, nothing)
	fig
end

# ╔═╡ Cell order:
# ╟─edbcad9f-bbc8-44c9-9165-ce61ee6671c3
# ╠═64d5b078-6eb1-11ec-290d-99aa7b5ace54
# ╠═10ef6326-b3c3-44aa-8496-9c6bedfde875
# ╟─a9b9a51b-f129-4d45-8b5c-f427296a3660
# ╠═04062259-b30a-47df-b6e7-b39b7ccff01d
# ╟─edcac259-402e-45ae-a0a3-c662f0bb842c
# ╠═5f04bb82-5d64-435c-8d0d-e6c439639329
# ╟─c0fd10de-0190-4efb-a5ef-89ee08d5fa6c
# ╠═08ab9417-f332-4599-a415-e8c710c1ff5b
# ╠═48b6c472-0001-40b2-a0a4-61f1aa906252
# ╠═bafac1f9-537c-4c58-ab28-20784891ae8e
# ╠═f5692d5e-e9cf-40e6-856c-1acfbf11ef28
# ╟─dbee0556-c275-47df-85a5-1a3899b91002
# ╠═49592adc-ddc8-431d-a34d-05aedfaf18cc
# ╠═c605a438-f29b-4986-96a6-aa152f28fd65
# ╟─d18ec2aa-ca32-49f9-9a5a-470214d995f5
# ╠═00f0b5c6-bd5d-435d-932d-926769f14293
# ╟─e1e9c3b8-57a9-4b7f-9622-48ab2ba731b5
# ╠═3506584d-5ade-4d73-84f4-a1cbc6632890
# ╟─d2dd321c-37d3-4809-9cb3-6011918b5283
# ╠═562f9db3-60d9-44ef-93fb-fd3ab9f95ecc
# ╟─8b58f120-dcdf-40f7-9966-93733c7ed3c2
# ╠═88a54f3c-1c97-4b08-8248-921cd65d7c09
# ╠═01d4446c-2cc3-4c5b-ab8e-6e9df25294c7
# ╠═4cddd124-0eae-45c7-96f3-23e3e53a0613
# ╟─6ef14719-48bb-4b5c-8625-6ea35b55b41e
# ╠═cc02f51e-c4f0-4ada-9448-6c5c273cd331
# ╠═608c4c9a-dbff-48eb-95af-c924f7ef5d73
