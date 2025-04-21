### A Pluto.jl notebook ###
# v0.20.5

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
G_u = -3 * exp(-0.1 * s) / (4 * s + 1)

# ╔═╡ f392ab2f-17ea-4a2e-9ba3-37e133f97bd9
G_s = exp(-0.1 * s)

# ╔═╡ 496dc011-8149-4ffe-83d0-fbd71865c1c8
md"🎈 PI controller settings."

# ╔═╡ 0c0ea047-1fff-4e0d-9095-9f3cb243a5cc
md"controller gain $K_c$: $(@bind K_c PlutoUI.Slider(-3.0:0.1:2.0))"

# ╔═╡ e96b2368-94a3-4116-af37-2674a44bf03f
md"integral time constant $\tau_I$: $(@bind τ_I PlutoUI.Slider(0.5:0.5:10.0))"

# ╔═╡ 8ff00eeb-30a2-43be-b460-aedc9592fc35
println("controller gain K_c = ", K_c, "\nintegral time constant τ_I = ", τ_I)

# ╔═╡ 305152b1-3b41-426d-8d9e-4b2caa653c3b
G_c = TransferFunction(PIController(K_c, τ_I))

# ╔═╡ ebc814df-65f5-491c-bc9c-d63e96c7c4f1
md"🎈 define the input to the closed-loop (a set point change)."

# ╔═╡ 07a80716-d8ca-45ca-b49b-9dd3c479be2d
Δy_sp = 2.0

# ╔═╡ e943f653-4282-4c84-ac06-a999f3297f20
Y_sp★ = Δy_sp / s

# ╔═╡ 71bdbfea-44d8-44de-a699-f03c429ebb7c
md"🎈build the measured output and controller action."

# ╔═╡ 9d01fd44-18ba-4884-8a2d-10502f9b543e
Y★ = ClosedLoopTransferFunction(G_u * G_c, G_u * G_c * G_s) * Y_sp★

# ╔═╡ 999ba021-0d0d-46ca-a74d-7a8629d08cae
U★ = ClosedLoopTransferFunction(G_c, G_u * G_c * G_s) * Y_sp★

# ╔═╡ b2cb48bc-6743-490f-b29c-9b600afbfe7f
md"🎈simulate the measured output and controller action in response to the input to the closed-loop."

# ╔═╡ 46ad1e68-317c-4a7d-b1a7-06e42f9b0699
final_time = 20.0

# ╔═╡ 525721e4-1061-4b8c-83e4-eb6a7419f4ba
data_y = simulate(Y★, final_time)

# ╔═╡ 1bf43b30-e364-49ce-8cfa-43cee58fe22b
data_u = simulate(U★, final_time)

# ╔═╡ 2438d081-ddc8-4d3e-9c86-12a4e9115056
md"🎈visualize."

# ╔═╡ a1b565f4-99c4-4892-86f4-f45aaac18bb3
begin
	fig = Figure(size=(600, 700))
	ax_u = Axis(
		fig[1, 1], ylabel="manipulated var.\nu*(t)", title="controller action"
	)
	ax_y = Axis(
		fig[2, 1], ylabel="controlled var.\ny*(t)", xlabel="time, t",
		title="closed-loop response"
	)
	hidexdecorations!(ax_u, grid=false)

	# manipulated variable
	lines!(ax_u, data_u.t, data_u.output)

	# controlled variable
	lines!(
		ax_y,
		[-1, -eps(), eps(), final_time], [0, 0, Δy_sp, Δy_sp], 
		linestyle=:dash, color=Cycled(2)
	) # set point
	lines!(ax_y, data_y.t, data_y.output, color=Cycled(3))
	fig
end

# ╔═╡ Cell order:
# ╠═3a533ad0-1a74-11f0-0897-3d14b3343193
# ╠═9611698c-012d-4a9f-8427-726284eff480
# ╟─f246b1b9-2674-4712-b958-ed66ad78a249
# ╟─65b89b03-c8b1-4ce8-bb37-519ff27226e7
# ╟─346a5ab9-2f4b-471d-a799-eec6d0b19a8d
# ╠═8646766a-ad6c-46d2-939e-c8ad1e82392d
# ╠═f392ab2f-17ea-4a2e-9ba3-37e133f97bd9
# ╟─496dc011-8149-4ffe-83d0-fbd71865c1c8
# ╠═305152b1-3b41-426d-8d9e-4b2caa653c3b
# ╟─ebc814df-65f5-491c-bc9c-d63e96c7c4f1
# ╠═07a80716-d8ca-45ca-b49b-9dd3c479be2d
# ╠═e943f653-4282-4c84-ac06-a999f3297f20
# ╟─71bdbfea-44d8-44de-a699-f03c429ebb7c
# ╠═9d01fd44-18ba-4884-8a2d-10502f9b543e
# ╠═999ba021-0d0d-46ca-a74d-7a8629d08cae
# ╟─b2cb48bc-6743-490f-b29c-9b600afbfe7f
# ╠═46ad1e68-317c-4a7d-b1a7-06e42f9b0699
# ╠═525721e4-1061-4b8c-83e4-eb6a7419f4ba
# ╠═1bf43b30-e364-49ce-8cfa-43cee58fe22b
# ╟─2438d081-ddc8-4d3e-9c86-12a4e9115056
# ╟─0c0ea047-1fff-4e0d-9095-9f3cb243a5cc
# ╟─e96b2368-94a3-4116-af37-2674a44bf03f
# ╠═8ff00eeb-30a2-43be-b460-aedc9592fc35
# ╠═a1b565f4-99c4-4892-86f4-f45aaac18bb3
