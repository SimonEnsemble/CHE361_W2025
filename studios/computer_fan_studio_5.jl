### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# ╔═╡ 76f68414-e417-11ef-3432-d333dbdf8948
begin
	import Pkg; Pkg.activate()
	using CairoMakie

	update_theme!(linewidth=3, fontsize=18)
end

# ╔═╡ 85a48f0b-d852-4c37-9239-c953dc0a3238
md"# studio \#5: CPU cooling system

🛑 complete the written portion first.

## parameters and inputs

> here ya go! these are realistic values. - Cory

"

# ╔═╡ adb1f977-f970-407d-a27e-653c9992e709
begin
	#=
	🦩 steady states
	=#
	# steady-state heat generation rate
	q̄ = 2.0 * 60.0 # J / min
	
	# steady-state indoor temperature
	θ̄ₐ = 25.0 # °C

	#=
	🦩 the input
	=#
	# difference between [hotter] outdoor and [colder] indoor temperature
	Δθₐ = 10.0 # °C

	#=
	🦩 model parameters
	=#
	# mass of the CPU
	m = 50.0 # g

	# specific heat capacity of the CPU
	cₚ = 0.71 # J / (g ⋅ °C)

	# surface area of CPU in contact with air
	A = 0.6 # cm²

	# heat transfer coefficient
	U = 1000.0 * 60.0 / 100 ^ 2 # J / (min ⋅ cm² ⋅ °C)
end

# ╔═╡ 795b8d7e-81aa-4885-9322-245241d1c38c
md"## visualize the input and output

🦩 write two functions, one for the input $\theta_a(t)$ and one for the output $\theta(t)$.
"

# ╔═╡ 5bfb113c-a5e2-45ee-8bf1-f189bf761e1b


# ╔═╡ fbd1b239-3591-4171-9dba-390b8d91e9c2
function θ(t)
	# TODO
end

# ╔═╡ 2c286811-1ab6-475a-a507-dc933399dcba
function θₐ(t)
	# TODO
end

# ╔═╡ 5dfd301d-8f36-4fe1-9f23-b5c0a9a8911d
md"🦩 plot both the input $\theta_a(t)$ and the output $\theta(t)$ with a shared time-axis for $t\in[-5, 60]$ min.

🤔 does the shape of the response make sense?
"

# ╔═╡ 4824889e-032b-4a3c-96c0-e5d3819e17a2


# ╔═╡ 14bf5d66-e5f5-4274-b5c6-0cb280c1c0f0
begin
	fig = Figure(size=(600, 600))
	#=
	plot the input θₐ(t) on the top axis
	=#
	ax_t = Axis(fig[1, 1], ylabel="air temperature\nθₐ(t) [°C]")
	# TODO: plot θₐ(t)
	
	#=
	plot the output θ(t) on the bottom axis
	=#
	ax_b = Axis(fig[2, 1], ylabel="CPU temperature\nθ(t) [°C]", xlabel="time [min]")
	linkxaxes!(ax_t, ax_b) # link the time axes
	# TODO: plot θ(t)

	xlims!(-5, 60)
	
	fig
end

# ╔═╡ Cell order:
# ╠═76f68414-e417-11ef-3432-d333dbdf8948
# ╟─85a48f0b-d852-4c37-9239-c953dc0a3238
# ╠═adb1f977-f970-407d-a27e-653c9992e709
# ╟─795b8d7e-81aa-4885-9322-245241d1c38c
# ╠═5bfb113c-a5e2-45ee-8bf1-f189bf761e1b
# ╠═fbd1b239-3591-4171-9dba-390b8d91e9c2
# ╠═2c286811-1ab6-475a-a507-dc933399dcba
# ╟─5dfd301d-8f36-4fe1-9f23-b5c0a9a8911d
# ╠═4824889e-032b-4a3c-96c0-e5d3819e17a2
# ╠═14bf5d66-e5f5-4274-b5c6-0cb280c1c0f0
