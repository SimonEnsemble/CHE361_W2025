### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# ╔═╡ 94005808-fe98-11ef-1569-ede533fa2bc7
begin
	import Pkg; Pkg.activate()
	using Controlz, CairoMakie

	update_theme!(Controlz.cool_theme)
end

# ╔═╡ 2872843c-c1d5-4c9e-ad9d-b55015d86299
md"# simulating the response of a FOPTD system"

# ╔═╡ 46ced5e8-c6ef-4503-9816-691987c23ee0
K = 2.0 # gain

# ╔═╡ d26008c8-b76f-4839-af4b-c52315fe759f
τ = 1.0 # time constant

# ╔═╡ 2b2b8871-5582-48ae-85fa-8877de36621c
θ = 3.0 # time delay

# ╔═╡ 11360172-044f-429d-ba55-44133bf39192
# FOPTD transfer function
G = K / (τ * s + 1) * exp(- θ * s)

# ╔═╡ 3730c828-82c9-41dc-86f6-bc5030339879
# input (say, a step)
U★ = 1 / s

# ╔═╡ d1d7aeb2-be0c-422f-aa24-c7c2895f9c06
# output
Y★ = G * U★

# ╔═╡ aabb2ef7-bfa4-48bd-a593-92a023086785
# simulate 
data = simulate(Y★, 10.0)

# ╔═╡ 0b2334e7-953f-4ba6-ab51-e82f43aa46c9
# visualize response
fig = viz_response(data)

# ╔═╡ c7791b51-4d63-4478-9fc1-5550c72a389b
begin
	# interpolate simulated data to get the value of the output
	#   at a specific time
	#   e.g. y(t=5.0)
	t = 5.0
	ŷ = interpolate(data, t)
end

# ╔═╡ f6ad1f24-4e18-4c94-8fba-6895a201ef53
begin
	ax = current_axis(fig)
	scatter!([t], [ŷ], markersize=25)
	fig
end

# ╔═╡ Cell order:
# ╠═94005808-fe98-11ef-1569-ede533fa2bc7
# ╟─2872843c-c1d5-4c9e-ad9d-b55015d86299
# ╠═46ced5e8-c6ef-4503-9816-691987c23ee0
# ╠═d26008c8-b76f-4839-af4b-c52315fe759f
# ╠═2b2b8871-5582-48ae-85fa-8877de36621c
# ╠═11360172-044f-429d-ba55-44133bf39192
# ╠═3730c828-82c9-41dc-86f6-bc5030339879
# ╠═d1d7aeb2-be0c-422f-aa24-c7c2895f9c06
# ╠═aabb2ef7-bfa4-48bd-a593-92a023086785
# ╠═0b2334e7-953f-4ba6-ab51-e82f43aa46c9
# ╠═c7791b51-4d63-4478-9fc1-5550c72a389b
# ╠═f6ad1f24-4e18-4c94-8fba-6895a201ef53
