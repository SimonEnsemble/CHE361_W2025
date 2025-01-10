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
	#  see here for other themes:
	#    https://makieorg.github.io/MakieThemes.jl/dev/themes/ggthemr/
	set_theme!(ggthemr(:flat))
	update_theme!(fontsize=20, linewidth=3)
end

# ╔═╡ edbcad9f-bbc8-44c9-9165-ce61ee6671c3
md"# Julia bootcamp

**learning objective:** 
* practice concepts in computational thinking
* familiarize with some capabilities of the Julia programming language and Pluto notebooks.
* practice browsing documentation to figure out syntax for programming tasks

> 🔥 computational skills--incl. application of numerical methods to engineering problems, wrangling with and visualizing data, and writing simple computer programs to automate analyses--are very valuable for the modern chemical engineer. -Cory

❓ how do I figure out how to code something up in Julia?
* Julia [docs](https://docs.julialang.org/en/v1/)
* package-specific docs
  * `CSV` package [docs](https://csv.juliadata.org/stable/index.html)
  * `CairoMakie` package [docs](https://makie.juliaplots.org/dev/)
  * `DataFrames` package [docs](https://dataframes.juliadata.org/stable/)
* Google-search \"how do I ... in Julia?\"
* ChatGPT

!!! note
	writing code to achieve a task is often more _computational thinking_ than _figuring out syntax of the specific language_ (Julia, here). many program languages are strikingly similar (`for` loops, `if` statements, `Array`s, etc.). so the computational skills you learn in this class generalize beyond Julia, as they are transferrable to other languages.

"

# ╔═╡ 10ef6326-b3c3-44aa-8496-9c6bedfde875
TableOfContents()

# ╔═╡ a9b9a51b-f129-4d45-8b5c-f427296a3660
md"
## computing a sum and plotting a function

🐸 the truncated (with only $N$ terms) power series approximation to the Bessel function of order 0, $b(x)$, is [[source](https://math.libretexts.org/Bookshelves/Differential_Equations/Partial_Differential_Equations_(Walet)/10%3A_Bessel_Functions_and_Two-Dimensional_Problems/10.02%3A_Bessel%E2%80%99s_Equation)]:

$$b(x)\approx \sum_{k=0}^{N-1}\frac{(-1)^k}{(k!)^2}\left(\dfrac{x}{2}\right)^{2k}.$$

write a function `b(x)` that returns the approximation of the value of the Bessel function at a point `x` in its domain for $N=12$ using a `for` loop. use this function to plot $b(x)$ over the domain $x\in[-5, 5]$.

💡Bessel functions are useful in chemical engineering for modeling heat transfer in cylindrical objects.

!!! example \"relevant docs\"
	* [functions](https://docs.julialang.org/en/v1/manual/functions/)
	* [loops and comprehensions](https://docs.julialang.org/en/v1/manual/variables-and-scoping/#Loops-and-Comprehensions)
	* [dot syntax](https://docs.julialang.org/en/v1/manual/functions/#man-vectorized)
	* [lines](https://docs.makie.org/stable/reference/plots/lines)
"

# ╔═╡ 04062259-b30a-47df-b6e7-b39b7ccff01d


# ╔═╡ 4412feba-08f4-479e-8649-331d87944100


# ╔═╡ f35d1257-0b5f-408d-809a-68bdab32a377


# ╔═╡ edcac259-402e-45ae-a0a3-c662f0bb842c
md"
## plotting multiple functions on the same panel

🐸 the Michaelis-Menton model specifies the rate at which some simple enzyme-catalyzed reactions occur in a batch bioreactor. specifically, the rate of production $\nu$ [mol/(L⋅s)] of the product P, via putting a substrate S in solution with an enzyme E (chemical reaction: S$\xrightarrow{E}$P), is:

$$\frac{ {\rm d}[P]}{ {\rm d} t}=:\nu([S])=\dfrac{V_m[S]}{K_m + [S]}$$

with $[P]$ [mol/L] the concentration of the product, $[S]$ [mol/L] the concentration of the substrate, and $V_m$ [1/s] and $K_m$ [mol/L] two parameters.

on the same panel, plot the ratio $\nu([S])/V_m$ against $[S] \in [0, 5]$ mol/L for three different $K_m$ values, $K_m\in \{0.1, 5.0, 10.0\}$ mol/L.
* use a `for` loop over the $K_m$ values
* make each curve a different color
* include x- and y-axis labels also indicating units
* include a legend that indicates which color corresponds to which $K_m$ value.

💡this allows us to visualize how the $K_m$ parameter affects the reaction kinetics.

!!! example \"relevant docs\"
	* [functions](https://docs.julialang.org/en/v1/manual/functions/)
	* [loops and comprehensions](https://docs.julialang.org/en/v1/manual/variables-and-scoping/#Loops-and-Comprehensions)
	* [dot syntax](https://docs.julialang.org/en/v1/manual/functions/#man-vectorized)
	* [lines](https://docs.makie.org/stable/reference/plots/lines)
	* [axislegend](https://docs.makie.org/stable/tutorials/getting-started#legend)
"

# ╔═╡ 24d52843-c256-4606-a4b5-f78c732c2a0e


# ╔═╡ d67377c8-c99c-43a4-a3b9-3f638ea9abf2
Kₘs = [0.1, 5.0, 10.0] # mol/L

# ╔═╡ 007576a5-3638-4ec7-bbeb-667bda0e88f8


# ╔═╡ 5f04bb82-5d64-435c-8d0d-e6c439639329


# ╔═╡ c0fd10de-0190-4efb-a5ef-89ee08d5fa6c
md"## reading in, plotting, filtering data

💡wrangling with and visualizing data is an incredibly important skill.

🐸 download the data set (CSV format) giving the monthly mean CO₂ concentration measured in Mauna Loa from the NOAA [here](https://gml.noaa.gov/ccgg/trends/data.html). read in the data as a `DataFrame` in Julia using the `CSV.read` function. plot the measured CO₂ concentration over time with a green line. include x- and y-axis labels with units.

!!! hint
	look at the raw `.csv` file. the first few lines are comments. use the `comment` keyword argument of the `CSV.read` function to ignore these lines when reading in the file.

!!! example \"relevant docs\"
	* [readdir](https://docs.julialang.org/en/v1/base/file/#Base.Filesystem.readdir)
	* [pwd](https://docs.julialang.org/en/v1/base/file/#Base.Filesystem.pwd)
	* [reading in a CSV](https://csv.juliadata.org/stable/reading.html#CSV.read)
	* [indexing columns of a DataFrame](https://dataframes.juliadata.org/stable/man/basics/#Indexing-Syntax)
	* [lines](https://docs.makie.org/stable/reference/plots/lines/)
	* [findfirst](https://docs.julialang.org/en/v1/base/strings/#Base.findfirst-Tuple%7BAbstractString,%20AbstractString%7D)
"

# ╔═╡ 08ab9417-f332-4599-a415-e8c710c1ff5b
# present working directory

# ╔═╡ 48b6c472-0001-40b2-a0a4-61f1aa906252
# read files in current directory

# ╔═╡ bafac1f9-537c-4c58-ab28-20784891ae8e


# ╔═╡ f5692d5e-e9cf-40e6-856c-1acfbf11ef28


# ╔═╡ 49592adc-ddc8-431d-a34d-05aedfaf18cc
md"🐸 create a new data frame that shows only the CO₂ concentrations in 1987.

!!! hint
	use boolean array slicing or the [filter](https://dataframes.juliadata.org/stable/lib/functions/#Base.filter) function.
"

# ╔═╡ 87b72c17-598d-48a0-87ae-cbb0bd0c5e26


# ╔═╡ c605a438-f29b-4986-96a6-aa152f28fd65


# ╔═╡ 91d2ee97-4118-402f-91d3-588cbbd02ab0


# ╔═╡ ca709f9c-69e5-409a-8bc5-7f7570559c9a
md"🐸 write a computer program to find the first time (year, month) that the CO₂ concentration surpassed 400 ppm.

!!! hint
	this could be a `for` loop, using the `findfirst` function, or using the `filter` function.
"

# ╔═╡ 7467bd02-1ef3-4c00-acfb-651053218bc0


# ╔═╡ 0631eb0e-7840-4644-99d6-d0e3736968a6


# ╔═╡ 6ef14719-48bb-4b5c-8625-6ea35b55b41e
md"## Newton's method to solve a nonlinear equation

📖 read on [Wikipedia](https://en.wikipedia.org/wiki/Newton%27s_method) about Newton's method to numerically solve for the roots of a function $g(x)$.

🐸 we want to use Newton's method to find the root of the cubic polynomial

$$g(x)= x ^ 3 - 3 x + 1$$

that lies in the interval $[-1, 1]$. 

set a suitable initial guess `x₀` for the root. then, write a `for` loop that does ten iterations of Newton's method. each iteration refines the previous iteration's guess for the root. inside the loop, print (a) the iteration number, (b) the current guess for the root, and (c) the associated function value at that guess for the root.

first, plot the function over the domain $[-2.5, 2.5]$ to (i) see there lies a root in $[-1, 1]$ and (ii) beware of inadvertently converging to two different roots if a decent starting guess is not used.

!!! hint
	code up both the function and its derivative so your code resembles the math. \"\prime\" then Tab gives a prime.

!!! example \"relevant docs\"
    * [println](https://docs.julialang.org/en/v1/base/io-network/#Base.println)
"

# ╔═╡ bb56d80b-c186-48f9-a83b-d97c363a68bb


# ╔═╡ 653a22ea-af1a-4853-a411-49661d09ce7f


# ╔═╡ a9dda2d5-36e4-4a6d-a00e-57ca4024995a


# ╔═╡ d12875fd-902d-49b1-ae78-ffe2b2e3105c


# ╔═╡ Cell order:
# ╟─edbcad9f-bbc8-44c9-9165-ce61ee6671c3
# ╠═64d5b078-6eb1-11ec-290d-99aa7b5ace54
# ╠═10ef6326-b3c3-44aa-8496-9c6bedfde875
# ╟─a9b9a51b-f129-4d45-8b5c-f427296a3660
# ╠═04062259-b30a-47df-b6e7-b39b7ccff01d
# ╠═4412feba-08f4-479e-8649-331d87944100
# ╠═f35d1257-0b5f-408d-809a-68bdab32a377
# ╟─edcac259-402e-45ae-a0a3-c662f0bb842c
# ╠═24d52843-c256-4606-a4b5-f78c732c2a0e
# ╠═d67377c8-c99c-43a4-a3b9-3f638ea9abf2
# ╠═007576a5-3638-4ec7-bbeb-667bda0e88f8
# ╠═5f04bb82-5d64-435c-8d0d-e6c439639329
# ╟─c0fd10de-0190-4efb-a5ef-89ee08d5fa6c
# ╠═08ab9417-f332-4599-a415-e8c710c1ff5b
# ╠═48b6c472-0001-40b2-a0a4-61f1aa906252
# ╠═bafac1f9-537c-4c58-ab28-20784891ae8e
# ╠═f5692d5e-e9cf-40e6-856c-1acfbf11ef28
# ╟─49592adc-ddc8-431d-a34d-05aedfaf18cc
# ╠═87b72c17-598d-48a0-87ae-cbb0bd0c5e26
# ╠═c605a438-f29b-4986-96a6-aa152f28fd65
# ╠═91d2ee97-4118-402f-91d3-588cbbd02ab0
# ╟─ca709f9c-69e5-409a-8bc5-7f7570559c9a
# ╠═7467bd02-1ef3-4c00-acfb-651053218bc0
# ╠═0631eb0e-7840-4644-99d6-d0e3736968a6
# ╟─6ef14719-48bb-4b5c-8625-6ea35b55b41e
# ╠═bb56d80b-c186-48f9-a83b-d97c363a68bb
# ╠═653a22ea-af1a-4853-a411-49661d09ce7f
# ╠═a9dda2d5-36e4-4a6d-a00e-57ca4024995a
# ╠═d12875fd-902d-49b1-ae78-ffe2b2e3105c
