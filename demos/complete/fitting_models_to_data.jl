### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ 30d63de6-b19f-11ed-3aaf-e549eed34237
begin
	import Pkg; Pkg.activate()
	using CairoMakie, Optim, DataFrames, Random, PlutoUI

	update_theme!(fontsize=24, markersize=16, linewidth=3)
end

# ╔═╡ ac14f14b-1cf0-402c-aa49-f68b10817c8b
md"# fitting models to data"

# ╔═╡ d90018f0-5e80-48bd-a0e7-a4708afee429
# true function
function y(t; A = 1.3, ω = 1.4)
	return A * sin(ω * t)
end

# ╔═╡ b53e9844-1021-4ec3-ba4e-8c018fa60f10
function gen_data(n::Int, σ::Float64=0.3)
	Random.seed!(97330) # for repeatability
	
	ts = range(0.0, 10.0, length=n)
	return DataFrame(
		"t" => ts,
		"y" => y.(ts) .+ σ * randn(n)
	)
end

# ╔═╡ 022ade40-2079-4d89-b79f-7adad8f6ccc7
data = gen_data(20)

# ╔═╡ 442210c0-6928-4b8f-8000-712f97fd4674
md"visualize the data"

# ╔═╡ 419052a8-9ce3-45ec-a7de-59d1c85a497a
begin
	fig = Figure()
	ax = Axis(fig[1, 1], xlabel="t", ylabel="y(t)")
	scatter!(data[:, "t"], data[:, "y"], label="data")
	fig
end

# ╔═╡ cf1b9984-30b0-4a29-ac5f-8b28274e4226
md"propose a model:

```math
\begin{equation}
y(t)=A\sin(\omega t)
\end{equation}
```
here, the parameters $A$ and $\omega$ are unknown, so we fit them to the data.

write a sum of squares loss function---a function of $A$ and $\omega$, that, when minimal, implies the minimizers $\hat{A}$ and $\hat{\omega}$ fit the data best.
```math
\begin{equation}
\ell(\theta:=[A, \omega]):=\sum_i (y_i - A\sin(\omega t_i))^2
\end{equation}
```

here $\theta:=[A, \omega]\in\mathbb{R}^2$ is the parameter vector.
"

# ╔═╡ 8cc3e872-1ac9-409f-b8ed-d39ab0457bb6
function loss(θ)
	# unpack param vector θ = [A, ω]
	A, ω = θ
	# compute loss
	l = 0.0
	for i = 1:nrow(data)
		# the data point
		tᵢ = data[i, "t"]
		yᵢ = data[i, "y"]
		
		# the model prediction with these params passed to the loss
		ŷᵢ = A * sin(ω * tᵢ)
		
		# add the residual to the loss
		l += (ŷᵢ - yᵢ)^2
	end
	return l
end

# ╔═╡ 59f850be-c78c-4ee5-aba0-531f78a22448
md"minimize the loss with the Nelder-Mead algo. see [Optim.jl docs](https://julianlsolvers.github.io/Optim.jl/stable/#user/minimization/)."

# ╔═╡ e26f3c5a-befb-4034-84c9-d45f2d53760d
res = optimize(loss, [1.0, 1.0])

# ╔═╡ 2b3da484-093e-4da7-8e92-c0599b080bc1
md"get the minimizer, ie. the parameters that give the model that fits the data the best."

# ╔═╡ 3a15c770-1bad-4333-a415-d705b7a10b56
Â, ω̂ = res.minimizer

# ╔═╡ d4ee3314-02eb-400a-b787-df08334697f6
md"plot the fit model along with the data to compare."

# ╔═╡ 071ee0de-e96b-4754-af7c-b74b65b692b9
begin
	ts = range(-1.0, 11.0, length=100)
	lines!(ax, ts, Â * sin.(ω̂ * ts), label="model", color=Cycled(3))
	axislegend(position=:cb)
	fig
end

# ╔═╡ bc093374-9036-435e-adae-af6253ce3eb8
md"# viz loss"

# ╔═╡ 0bd5a269-e3ce-4007-9929-2d6ce6cd361f
begin
	x = Dict("A" => 0.5, "ω" => 0.1)
	r = Dict(
		"A" => [Â * (1 - x["A"]), Â * (1 + x["A"])],
		"ω" => [ω̂ * (1 - x["ω"]), ω̂ * (1 + x["ω"])]
	)
end

# ╔═╡ 2bcb7364-15e1-4972-a87c-937230af433a
md"A $(@bind A PlutoUI.Slider(r[\"A\"][1]:0.01:r[\"A\"][2]))"

# ╔═╡ 6e007989-1dcb-4c87-9ca7-6ab060526e74
md"ω $(@bind ω PlutoUI.Slider(r[\"ω\"][1]:0.01:r[\"ω\"][2]))"

# ╔═╡ 17144a55-3ad1-40ef-9b6c-65315e8a1946
begin
	local fig = Figure()
	local ax = Axis(
		fig[1, 1], xlabel="t", ylabel="y(t)", 
		title="A=$(round(A, digits=2)), ω=$(round(ω, digits=2))",
		titlefont=:regular
	)
	scatter!(data[:, "t"], data[:, "y"], label="data")
	lines!(ax, ts, y.(ts, A=A, ω=ω), label="A sin(ωt)", color=Cycled(3))
	axislegend(position=:lb)
	xlims!(-1, 11)
	fig
end

# ╔═╡ c1917198-df00-4248-8ada-7cd594af7033
begin
	local fig = Figure()
	Axis(fig[1, 1], xlabel="A", ylabel="ω", title="loss")

	# compute loss on a grid
	
	As = range(r["A"][1], r["A"][2], length=50)
	ωs = range(r["ω"][1], r["ω"][2], length=50)
	ℓs = [loss([A, ω]) for A in As, ω in ωs]
	
	ct = contourf!(As, ωs, ℓs, levels=45)
	scatter!([Â], [ω̂], color="red", marker=:+)
	scatter!([A], [ω], color="white", marker=:+)
	xlims!(r["A"][1], r["A"][2])
	ylims!(r["ω"][1], r["ω"][2])

	Colorbar(fig[1, 2], ct)
	fig
end

# ╔═╡ Cell order:
# ╠═30d63de6-b19f-11ed-3aaf-e549eed34237
# ╟─ac14f14b-1cf0-402c-aa49-f68b10817c8b
# ╠═d90018f0-5e80-48bd-a0e7-a4708afee429
# ╠═b53e9844-1021-4ec3-ba4e-8c018fa60f10
# ╠═022ade40-2079-4d89-b79f-7adad8f6ccc7
# ╟─442210c0-6928-4b8f-8000-712f97fd4674
# ╠═419052a8-9ce3-45ec-a7de-59d1c85a497a
# ╟─cf1b9984-30b0-4a29-ac5f-8b28274e4226
# ╠═8cc3e872-1ac9-409f-b8ed-d39ab0457bb6
# ╟─59f850be-c78c-4ee5-aba0-531f78a22448
# ╠═e26f3c5a-befb-4034-84c9-d45f2d53760d
# ╟─2b3da484-093e-4da7-8e92-c0599b080bc1
# ╠═3a15c770-1bad-4333-a415-d705b7a10b56
# ╟─d4ee3314-02eb-400a-b787-df08334697f6
# ╠═071ee0de-e96b-4754-af7c-b74b65b692b9
# ╟─bc093374-9036-435e-adae-af6253ce3eb8
# ╠═0bd5a269-e3ce-4007-9929-2d6ce6cd361f
# ╟─2bcb7364-15e1-4972-a87c-937230af433a
# ╟─6e007989-1dcb-4c87-9ca7-6ab060526e74
# ╟─17144a55-3ad1-40ef-9b6c-65315e8a1946
# ╟─c1917198-df00-4248-8ada-7cd594af7033
