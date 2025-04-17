### A Pluto.jl notebook ###
# v0.20.5

using Markdown
using InteractiveUtils

# ╔═╡ 3a533ad0-1a74-11f0-0897-3d14b3343193
begin
	import Pkg; Pkg.activate()
	using CairoMakie, Controlz, PlutoUI
end

# ╔═╡ 9611698c-012d-4a9f-8427-726284eff480
begin
	update_theme!(Controlz.cool_theme)
	update_theme!(fontsize=25)
end

# ╔═╡ f246b1b9-2674-4712-b958-ed66ad78a249
md"# simulation of the closed-loop response to a set point change under PI control"

# ╔═╡ 65b89b03-c8b1-4ce8-bb37-519ff27226e7
html"<img src=\"https://raw.githubusercontent.com/SimonEnsemble/CHE461_S2024/refs/heads/main/images/closed_loop.jpg\" width=650>"

# ╔═╡ 346a5ab9-2f4b-471d-a799-eec6d0b19a8d
md"🎈dynamic model for the process and sensor."

# ╔═╡ 8646766a-ad6c-46d2-939e-c8ad1e82392d


# ╔═╡ 496dc011-8149-4ffe-83d0-fbd71865c1c8
md"🎈 slider for controller settings."

# ╔═╡ e2e98bcb-2a9d-4da3-a378-f1460b941c2f


# ╔═╡ ebc814df-65f5-491c-bc9c-d63e96c7c4f1
md"🎈 define the input to the closed-loop (a set point change)."

# ╔═╡ e943f653-4282-4c84-ac06-a999f3297f20


# ╔═╡ 71bdbfea-44d8-44de-a699-f03c429ebb7c
md"🎈build the measured output and controller action."

# ╔═╡ 9d01fd44-18ba-4884-8a2d-10502f9b543e


# ╔═╡ b2cb48bc-6743-490f-b29c-9b600afbfe7f
md"🎈simulate the measured output and controller action in response to the input to the closed-loop."

# ╔═╡ 525721e4-1061-4b8c-83e4-eb6a7419f4ba


# ╔═╡ 2438d081-ddc8-4d3e-9c86-12a4e9115056
md"🎈visualize."

# ╔═╡ a1b565f4-99c4-4892-86f4-f45aaac18bb3


# ╔═╡ Cell order:
# ╠═3a533ad0-1a74-11f0-0897-3d14b3343193
# ╠═9611698c-012d-4a9f-8427-726284eff480
# ╟─f246b1b9-2674-4712-b958-ed66ad78a249
# ╟─65b89b03-c8b1-4ce8-bb37-519ff27226e7
# ╟─346a5ab9-2f4b-471d-a799-eec6d0b19a8d
# ╠═8646766a-ad6c-46d2-939e-c8ad1e82392d
# ╟─496dc011-8149-4ffe-83d0-fbd71865c1c8
# ╠═e2e98bcb-2a9d-4da3-a378-f1460b941c2f
# ╟─ebc814df-65f5-491c-bc9c-d63e96c7c4f1
# ╠═e943f653-4282-4c84-ac06-a999f3297f20
# ╟─71bdbfea-44d8-44de-a699-f03c429ebb7c
# ╠═9d01fd44-18ba-4884-8a2d-10502f9b543e
# ╟─b2cb48bc-6743-490f-b29c-9b600afbfe7f
# ╠═525721e4-1061-4b8c-83e4-eb6a7419f4ba
# ╟─2438d081-ddc8-4d3e-9c86-12a4e9115056
# ╠═a1b565f4-99c4-4892-86f4-f45aaac18bb3
