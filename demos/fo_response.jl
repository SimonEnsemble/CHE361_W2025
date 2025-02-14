### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# ╔═╡ d65d768c-6c13-11eb-27cb-ad79043d8d20
begin
    import Pkg; Pkg.activate();
    using PlutoUI, Controlz, CairoMakie
end

# ╔═╡ d74ea4d2-6c1d-11eb-1abf-4b435f9e7be3
set_theme!(Controlz.cool_theme)

# ╔═╡ f0051428-0afd-4fc0-bb3b-4a01725f0e77
md"# first order impulse response

**input**: $i(t)$ [mg/s]: rate of drug injection into blood stream

**output**: $c(t)$ [mg/L]: concentration of drug in blood stream

**parameters**
*  $V$ [L]: volume of blood in patient
*  $k$ [s⁻¹]: rate constant describing decay of drug owing to metabolism

```math
V \frac{dc}{dt} = i(t) - k V c(t)
```

re-arranging to make the gain and time constant apparent:
```math
\frac{1}{k} \frac{dc}{dt} + c(t) = \frac{1}{kV} i(t)
```
"

# ╔═╡ 79b551f7-a5da-423e-823a-8511176644c0
html"<img src=\"https://raw.githubusercontent.com/SimonEnsemble/CHE361_W2025/refs/heads/main/drawings/drugs.png\" width=200>"

# ╔═╡ 687d4a43-8812-4ff8-927f-d061c05265a4
md"🐸 define parameters."

# ╔═╡ adf6ce47-3f5b-4c95-b1d2-e4c8b9775d55
k = 0.05 # s⁻¹

# ╔═╡ 84be5688-4689-4bf4-b548-d06d03086769
V = 8.0 # L

# ╔═╡ 8b6cbaa7-3a4d-4aca-b710-5316f56c3669
md"🐸 define transfer function."

# ╔═╡ 773e7569-0cb4-412d-bdb7-cc699c283e89
K = 1 / (k * V) # (mg/L) / (mg/s) = s / L

# ╔═╡ 87827a67-6538-4c83-b93f-0c55c6ce01b5
τ = 1 / k # s

# ╔═╡ 5ac13a38-d6c3-45a0-8655-a04b1f3a0fb6
G = K / (τ * s + 1)

# ╔═╡ bfca883d-7ba9-4a4a-a9e9-5d6d9b45ab5b
md"🐸 simulate the response to swallowing a 10 mg dose of the drug.

```math
i(t) = 10 \delta(t)
```

"

# ╔═╡ 142e631b-c070-4915-abb4-de4c91f52fff
I = 10.0 / s # mg

# ╔═╡ 7f58170f-2c7b-49d2-af04-ca79235cc543
C = G * I

# ╔═╡ be26493d-4fe8-4db3-b2b8-6cbd5ae56478
data = simulate(C, 120.0)

# ╔═╡ 86012949-4193-48bb-8a1c-a9648fbbd6e1
begin
	fig = Figure()
	ax = Axis(fig[1, 1], xlabel="time, t [min]", ylabel="concentration, c(t) [mg/L]")
	lines!(
		data[:, "t"], data[:, "output"]
	)
	# ylims!(0, 5)
	fig
end

# ╔═╡ Cell order:
# ╠═d65d768c-6c13-11eb-27cb-ad79043d8d20
# ╠═d74ea4d2-6c1d-11eb-1abf-4b435f9e7be3
# ╟─f0051428-0afd-4fc0-bb3b-4a01725f0e77
# ╟─79b551f7-a5da-423e-823a-8511176644c0
# ╟─687d4a43-8812-4ff8-927f-d061c05265a4
# ╠═adf6ce47-3f5b-4c95-b1d2-e4c8b9775d55
# ╠═84be5688-4689-4bf4-b548-d06d03086769
# ╟─8b6cbaa7-3a4d-4aca-b710-5316f56c3669
# ╠═773e7569-0cb4-412d-bdb7-cc699c283e89
# ╠═87827a67-6538-4c83-b93f-0c55c6ce01b5
# ╠═5ac13a38-d6c3-45a0-8655-a04b1f3a0fb6
# ╟─bfca883d-7ba9-4a4a-a9e9-5d6d9b45ab5b
# ╠═142e631b-c070-4915-abb4-de4c91f52fff
# ╠═7f58170f-2c7b-49d2-af04-ca79235cc543
# ╠═be26493d-4fe8-4db3-b2b8-6cbd5ae56478
# ╠═86012949-4193-48bb-8a1c-a9648fbbd6e1
