### A Pluto.jl notebook ###
# v0.20.5

using Markdown
using InteractiveUtils

# ╔═╡ 7bb2aeee-3012-11f0-1de2-816cc3253f62
begin
	import Pkg; Pkg.activate()
	using JuMP, UnicodePlots, DataFrames
	import HiGHS
end

# ╔═╡ bbafe077-fc6a-4c6c-956a-9ca606d91dbe
md"## data

🐮 store ur data in nice data frames.
"

# ╔═╡ 9c7cc585-9444-4237-b9a7-2bc63c68c4da

# ╔═╡ bf4ee88a-af58-42ad-8bad-10c25f547af1

# ╔═╡ 5841f022-3168-4635-918d-0afc3a2693da

# ╔═╡ ed70b7ee-1360-486d-ae4f-0ef73d76c283

# ╔═╡ 3630e6fd-4777-4a0f-9e68-7b3753a6ebd0
md"## setup optimization problem

!!! note
	see [the JuMP.jl docs](https://jump.dev/JuMP.jl/stable/tutorials/linear/introduction/) for several examples of how to solve linear programs as well as [Cory's blog post](https://simonensemble.github.io/pluto_nbs/linear_programming.html).

🐮 declare the `JuMP.jl` model. use the `HiGHS` optimizer.
"

# ╔═╡ 74cac5b0-f53d-46d3-93f1-d9dc8fdf770c

# ╔═╡ ba4e820b-568a-4846-8316-8d8737a6832e
md"🐮 attach the decision variables."

# ╔═╡ 6a8e8611-64f4-4196-a072-5c4564a725ae

# ╔═╡ d4390acf-9c30-4058-ba8a-9aa7477aab09

# ╔═╡ d8575ac3-ecce-4faa-aa0a-5c917b5f3fb3
md"🐮 attach the objective function."

# ╔═╡ d0755d8f-6335-4db8-8b60-72e2d7866e86

# ╔═╡ 9ba98d46-a17c-48c1-9008-6709633d1aa7
md"🐮 attach the demand constraints."

# ╔═╡ fff52d0c-baf5-4b87-b35c-760c38d25f72

# ╔═╡ 68f993ae-7c9b-4a0d-b3d5-9adc137a28a6
md"🐮 attach the milk quality constraints."

# ╔═╡ 0ecad662-ac6d-498f-ac3a-ad3b8f46affb

# ╔═╡ 31a3f6bb-3144-458e-af51-2e6ac0d5ea15
md"🐮 print the linear program."

# ╔═╡ 14bf8eff-43d4-45b6-b171-187658ce3eb0

# ╔═╡ 880953c4-426b-4c01-ba1a-e924d936a0ec
md"
## solve the optimization problem
🐮 numerically solve the linear program."

# ╔═╡ 87439ce4-a10b-49ca-9e29-d09dc2d4823e

# ╔═╡ 0b399922-eed9-4caa-9f1a-73e0531cec1e
md"🐮 check the linear program was successfully solved."

# ╔═╡ e9f5059b-da96-46b6-b203-05ff127c08d0

# ╔═╡ ef3d70fa-fa79-4c4f-ac1c-c0b438ef12f6
md"🐮 print:
* the optimal flows of milk from farms to customers
* the optimal profit
* the total amount of milk to purchase from each farm
* the total amount of milk to deliver to each customer and its fat content
"

# ╔═╡ a829bbbf-0377-47b2-a9f6-ac5c4f7aab82

# ╔═╡ daca8bcd-b270-47c7-9d77-4d325ff8b384

# ╔═╡ 59220583-c153-4d02-b361-94a941343454

# ╔═╡ 32c42a95-3241-4598-b9b9-5083e8ecc92d

# ╔═╡ Cell order:
# ╠═7bb2aeee-3012-11f0-1de2-816cc3253f62
# ╟─bbafe077-fc6a-4c6c-956a-9ca606d91dbe
# ╠═9c7cc585-9444-4237-b9a7-2bc63c68c4da
# ╠═bf4ee88a-af58-42ad-8bad-10c25f547af1
# ╠═5841f022-3168-4635-918d-0afc3a2693da
# ╠═ed70b7ee-1360-486d-ae4f-0ef73d76c283
# ╟─3630e6fd-4777-4a0f-9e68-7b3753a6ebd0
# ╠═74cac5b0-f53d-46d3-93f1-d9dc8fdf770c
# ╟─ba4e820b-568a-4846-8316-8d8737a6832e
# ╠═6a8e8611-64f4-4196-a072-5c4564a725ae
# ╠═d4390acf-9c30-4058-ba8a-9aa7477aab09
# ╟─d8575ac3-ecce-4faa-aa0a-5c917b5f3fb3
# ╠═d0755d8f-6335-4db8-8b60-72e2d7866e86
# ╟─9ba98d46-a17c-48c1-9008-6709633d1aa7
# ╠═fff52d0c-baf5-4b87-b35c-760c38d25f72
# ╟─68f993ae-7c9b-4a0d-b3d5-9adc137a28a6
# ╠═0ecad662-ac6d-498f-ac3a-ad3b8f46affb
# ╟─31a3f6bb-3144-458e-af51-2e6ac0d5ea15
# ╠═14bf8eff-43d4-45b6-b171-187658ce3eb0
# ╟─880953c4-426b-4c01-ba1a-e924d936a0ec
# ╠═87439ce4-a10b-49ca-9e29-d09dc2d4823e
# ╟─0b399922-eed9-4caa-9f1a-73e0531cec1e
# ╠═e9f5059b-da96-46b6-b203-05ff127c08d0
# ╟─ef3d70fa-fa79-4c4f-ac1c-c0b438ef12f6
# ╠═a829bbbf-0377-47b2-a9f6-ac5c4f7aab82
# ╠═daca8bcd-b270-47c7-9d77-4d325ff8b384
# ╠═59220583-c153-4d02-b361-94a941343454
# ╠═32c42a95-3241-4598-b9b9-5083e8ecc92d
