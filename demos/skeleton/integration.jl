### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# ╔═╡ a6b951c0-d3ca-11ef-07ef-71fa25946bd6
begin
    import Pkg; Pkg.activate()
    using Cubature, CairoMakie, DataFrames, MakieThemes

    # modifying the plot scheme
    # see here for other themes
    #  https://makieorg.github.io/MakieThemes.jl/dev/themes/ggthemr/
    set_theme!(ggthemr(:earth))
    update_theme!(fontsize=20, linewidth=4)
end

# ╔═╡ be2a1c59-4c4b-41e1-9778-2ee5558f05fb
md"# programmed flow out of a tank

we input liquid into an initially-empty, cylindrical tank with radius $r$ [m] and height $H$ [m] at a rate $q_i(t)$ [m³/min] (with time $t$ [min]):

$q_i(t)= \begin{cases} 0 & t \leq 0, t\geq 18 \\ 2t & 0 < t \leq 4 \\ 8 & 4 < t < 10  \\ 8 - (t -10) & 10 < t < 18  \end{cases}$

predict $h(t)$ for $t\in[0, 20]$.

does the tank overflow?
"

# ╔═╡ 3f4f07cd-89a7-487d-a9ea-68deb858a430
r = 2.0 # m

# ╔═╡ fadff80b-93c9-4962-9a00-91503daa4a7b
H = 10.0 # m

# ╔═╡ 477022bd-7c0a-45c1-86d9-4b91c2df93f6

# ╔═╡ bbdfe717-17f0-44f4-96ec-23e698c09313
md"👽 program a function `qᵢ(t)`."

# ╔═╡ 8fff4b92-8b7e-4362-b443-a616cf52ec43

# ╔═╡ 8839c6af-c52f-4eaf-a9ca-43f3f56a815d
md"👽visualize $q_i(t)$."

# ╔═╡ a0bed237-a5b4-45e1-ace6-7fedbca0cd94

# ╔═╡ c8ea6f71-a6f3-472e-b7b4-37b18ceac1d7

# ╔═╡ 6765cea4-5d1a-4f4b-b72f-f0fe26ee2c5f
md"👽 program a function `h(t)` and visualize $h(t)$."

# ╔═╡ 3de62059-07ab-4199-9b79-221710f183b0

# ╔═╡ 59eb6eaf-08ca-4557-b009-de302d8a70b7

# ╔═╡ Cell order:
# ╠═a6b951c0-d3ca-11ef-07ef-71fa25946bd6
# ╟─be2a1c59-4c4b-41e1-9778-2ee5558f05fb
# ╠═3f4f07cd-89a7-487d-a9ea-68deb858a430
# ╠═fadff80b-93c9-4962-9a00-91503daa4a7b
# ╠═477022bd-7c0a-45c1-86d9-4b91c2df93f6
# ╟─bbdfe717-17f0-44f4-96ec-23e698c09313
# ╠═8fff4b92-8b7e-4362-b443-a616cf52ec43
# ╟─8839c6af-c52f-4eaf-a9ca-43f3f56a815d
# ╠═a0bed237-a5b4-45e1-ace6-7fedbca0cd94
# ╠═c8ea6f71-a6f3-472e-b7b4-37b18ceac1d7
# ╟─6765cea4-5d1a-4f4b-b72f-f0fe26ee2c5f
# ╠═3de62059-07ab-4199-9b79-221710f183b0
# ╠═59eb6eaf-08ca-4557-b009-de302d8a70b7
