### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# ╔═╡ 288ed518-bde8-11ed-0204-0b761fe29816
begin
	import Pkg;Pkg.activate()
	using NLsolve, Symbolics
	using ForwardDiff: gradient
	using Symbolics: solve_for, simplify
end

# ╔═╡ 3190b2f4-3b1a-4f02-9284-6948f29a7b67
md"## numerically solving a system of [possibly, nonlinear] algebraic equations

!!! example
	A farmer sells chickens and ducks at the market. He sells a total of 50 birds. Chickens sell for \$8 each, and ducks sell for \$10 each. The farmer makes a total of \$440. How many chickens and how many ducks did the farmer sell?

 $c:=$ \# chickens the farmer sold

 $d:=$ \# of ducks the farmer sold

eqn. for total \# of birds:

$c+d=50$

eqn. farmer's revenue \$:

$8c+10d = 440$

!!! hint
	see the `NLsolve.jl` docs [here](https://github.com/JuliaNLSolvers/NLsolve.jl). (providing the Jacobian to the solver is not necessary.)

🐶 code up this function for `NLsolve`:
"

# ╔═╡ 0930e3e9-dc56-4453-87ba-a6cb460d87b3
# eqn for total # of birds
f₁(c, d) = c + d - 50 # wish to be zero

# ╔═╡ 1d83da1f-3793-4846-94d2-fccd949d9c94
# eqn for revenue
f₂(c, d) = 440 - 10 * d - 8 * c

# ╔═╡ f3878c5c-64eb-40e6-8011-24728eea9588
function f(x)
    # x = [c, d]. unpack the vector to make it clear what the entries represent
    c, d = x
    
    # return the two functions you want to be zero as the two entries of f = [f₁, f₂]
    return f₁(c, d), f₂(c, d)
end

# ╔═╡ 4e123781-c5a3-40fe-95d1-cb3371e4504a
md"🐶 provide guess for the zero, let `NLsolve` find it."

# ╔═╡ 2ad3dc20-60b1-4ac7-91ec-a136b68b7908
x₀_guess = [25.0, 20.0]

# ╔═╡ 27684ddb-05b9-490d-a9a4-512b3ca15d5e
res = nlsolve(f, x₀_guess)

# ╔═╡ cbb84233-381a-4041-99a4-f0d26b5566ca
c, d = res.zero

# ╔═╡ ec352459-78a2-4e12-bb0a-57d24ec60dac
print("# chickens: ", round(Int, c))

# ╔═╡ b0e92e30-81ee-43ce-af91-44e35ddd49e6
print("# ducks: ", round(Int, d))

# ╔═╡ d79493d8-8844-42fa-9600-a4b308102124
f₁(c, d) # yay!

# ╔═╡ f3e22b86-94cc-4ba5-bdfc-bc210b064abe
f₂(c, d) # yay!

# ╔═╡ 9682a5f0-d5fd-4023-939e-ca25747b81fe
md"
!!! note
	the above system of algebraic equations are linear. so, we could have written a matrix equation $Zx=b$ and solved it.
"

# ╔═╡ c96c4b69-7f5c-4119-9fb6-bb859055e914
Z = [1 1; 8 10]

# ╔═╡ 5d6a426b-94b2-47b1-b430-44721fcdc36a
b = [50, 440]

# ╔═╡ 855ace84-dfa8-4f38-847b-a07e9a328335
Z \ b # c, d

# ╔═╡ cd7a338c-90a9-4d3a-9d75-d28af2c65911
md"
here's a nonlinear example. I solve it with much condensed code using some syntactic sugar.

!!! example
	A rectangular garden has an area of 100 square meters. A diagonal path cuts across the garden, and the length of this diagonal path is 20 meters. What are the dimensions (length and width) of the garden?
"

# ╔═╡ 2db8d937-4882-4416-88b6-dac5896d0e75
res2 = nlsolve(
	x -> (x[1] * x[2] - 100.0, x[1]^2 + x[2]^2 - 20.0^2),
	[10.0, 12.0]
)

# ╔═╡ 9f636727-7272-43a1-a735-20736780ee70
md"## numerically differentiating a function

!!! example
	consider
	$g(x_1, x_2)= x_1 x_2 + x_2^2 - 4$.

	compute both:
	* $\dfrac{\partial g}{\partial x_1}\bigg|_{x_1=3, x_2=1}$
	* $\dfrac{\partial g}{\partial x_2}\bigg|_{x_1=3, x_2=1}$

!!! hint
	let's use the `ForwardDiff` package to numerically differentiate $g(x_1, x_2)$, instead of doing the math by hand (though easy in this case).

🐶 we view this function as $g:\mathbb{R}^2 \rightarrow \mathbb{R}$. code it up.
"

# ╔═╡ 2299403b-881f-4818-a1eb-c7a946dd3e55
function g(x) # x is a vector
    # x = [x₁, x₂]. unpack the vector for clarity
    x₁, x₂ = x
    return x₁ * x₂ + x₂ ^ 2 - 4
end

# ╔═╡ 38c74300-39a7-45f1-8edf-14c7f03b5393
x̄ = [3.0, 1.0] # a vector. so x₁ = 2.0, x₂ = 4.0

# ╔═╡ 419fd86c-12e0-4cbf-9acb-91b130955dca
g(x̄)

# ╔═╡ 8a4cfe40-909c-4d19-a120-53671874d8e6
md"🐶 compute the gradient of the function at $\mathbf{x}=\mathbf{\bar{x}}$."

# ╔═╡ f517ddbc-8a30-4e78-831d-da969c4f9819
∇g_at_x̄ = gradient(g, x̄) # ∇f = [∂f/∂x₁, ∂f/∂x₂] evaluated at x̄

# ╔═╡ 51c85651-7337-4bdf-aae8-e7e930b03b8d
md"unpack so we have the partial derivatives as scalar variables"

# ╔═╡ f92847e4-09f3-4e9d-9722-6c245c67cf1f
∂g_∂x₁_at_x̄, ∂g_∂x₂_at_x̄ = ∇g_at_x̄

# ╔═╡ 882f8867-1bdc-407a-b2f9-1337f793b757
md"## solving symbolic equations with `Symbolics.jl`

(to save you some algebra)

!!! example
	in our handout \"intro to second-order systems\", we took the Laplace transform of two coupled, linear ODEs comprising a model for pesticide application to apple trees and its influence on the soil. the equations were:
	
	```math
	\begin{align}
		sA(s) &= - 3 A(s) + G(s) + R(s) \\
		s G(S) &= 2 A(s) - 2 G(s)
	\end{align}
	```
	we wish to solve for $G(s)$ in terms of $R(s)$, eliminating $A(s)$, giving the transfer function for how $R(s)$ affects $G(s)$.

!!! hint
	see [the docs](https://symbolics.juliasymbolics.org/stable/getting_started/) for `Symbolics.jl`.
"

# ╔═╡ efe4024f-4b38-49a2-9c4b-531b536aaeb5
md"define variables."

# ╔═╡ 78b91616-6794-4707-8a89-eeca1b327aba
# define symbols
@variables A, G, R, s # note can't load with Controlz.jl b/c s defined by it.

# ╔═╡ b67604b4-b559-4a46-9f30-02b7561de80d
md"define the two algebraic equations as (...) = 0."

# ╔═╡ 85f93d29-3702-44c2-86d5-a404c9108ade
A_eqn = s * A + 3 * A - G - R

# ╔═╡ 521aa029-e348-4cf5-87c9-f0eb2481094f
G_eqn = s * G - 2 * A + 2 * G

# ╔═╡ 9b267e35-4a14-4048-b0a3-473980edbe9c
md"solve `A_eqn` for `A` in terms of `G` and `R`."

# ╔═╡ 4551f197-2765-4e31-95f8-f64f0aea4c9d
A_expr = symbolic_linear_solve(A_eqn, A)

# ╔═╡ d662b59f-b8e1-4ec7-893b-03e08eff1bd2
md"substitute this expression for `A` into `G_eqn`."

# ╔═╡ 3a3416ec-eb6c-4707-8db4-8d7cef4961e1
new_G_eqn = substitute(G_eqn, A => A_expr)

# ╔═╡ 0ad4d4cb-9597-45a9-914c-3900a36f02fd
md"solve for `G`, divide by `R` to get the transfer function $G(s)/R(s)$."

# ╔═╡ aed884f7-2554-4393-9723-f7c30e361ef8
symbolic_linear_solve(new_G_eqn, G, simplify=true) / R

# ╔═╡ Cell order:
# ╠═288ed518-bde8-11ed-0204-0b761fe29816
# ╟─3190b2f4-3b1a-4f02-9284-6948f29a7b67
# ╠═0930e3e9-dc56-4453-87ba-a6cb460d87b3
# ╠═1d83da1f-3793-4846-94d2-fccd949d9c94
# ╠═f3878c5c-64eb-40e6-8011-24728eea9588
# ╟─4e123781-c5a3-40fe-95d1-cb3371e4504a
# ╠═2ad3dc20-60b1-4ac7-91ec-a136b68b7908
# ╠═27684ddb-05b9-490d-a9a4-512b3ca15d5e
# ╠═cbb84233-381a-4041-99a4-f0d26b5566ca
# ╠═ec352459-78a2-4e12-bb0a-57d24ec60dac
# ╠═b0e92e30-81ee-43ce-af91-44e35ddd49e6
# ╠═d79493d8-8844-42fa-9600-a4b308102124
# ╠═f3e22b86-94cc-4ba5-bdfc-bc210b064abe
# ╟─9682a5f0-d5fd-4023-939e-ca25747b81fe
# ╠═c96c4b69-7f5c-4119-9fb6-bb859055e914
# ╠═5d6a426b-94b2-47b1-b430-44721fcdc36a
# ╠═855ace84-dfa8-4f38-847b-a07e9a328335
# ╟─cd7a338c-90a9-4d3a-9d75-d28af2c65911
# ╠═2db8d937-4882-4416-88b6-dac5896d0e75
# ╟─9f636727-7272-43a1-a735-20736780ee70
# ╠═2299403b-881f-4818-a1eb-c7a946dd3e55
# ╠═38c74300-39a7-45f1-8edf-14c7f03b5393
# ╠═419fd86c-12e0-4cbf-9acb-91b130955dca
# ╟─8a4cfe40-909c-4d19-a120-53671874d8e6
# ╠═f517ddbc-8a30-4e78-831d-da969c4f9819
# ╟─51c85651-7337-4bdf-aae8-e7e930b03b8d
# ╠═f92847e4-09f3-4e9d-9722-6c245c67cf1f
# ╟─882f8867-1bdc-407a-b2f9-1337f793b757
# ╟─efe4024f-4b38-49a2-9c4b-531b536aaeb5
# ╠═78b91616-6794-4707-8a89-eeca1b327aba
# ╟─b67604b4-b559-4a46-9f30-02b7561de80d
# ╠═85f93d29-3702-44c2-86d5-a404c9108ade
# ╠═521aa029-e348-4cf5-87c9-f0eb2481094f
# ╟─9b267e35-4a14-4048-b0a3-473980edbe9c
# ╠═4551f197-2765-4e31-95f8-f64f0aea4c9d
# ╟─d662b59f-b8e1-4ec7-893b-03e08eff1bd2
# ╠═3a3416ec-eb6c-4707-8db4-8d7cef4961e1
# ╟─0ad4d4cb-9597-45a9-914c-3900a36f02fd
# ╠═aed884f7-2554-4393-9723-f7c30e361ef8
