### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# ╔═╡ 10584412-7a33-11ec-2593-c1520e9673b3
begin
	import Pkg; Pkg.activate()
	
	using DifferentialEquations, CairoMakie, Roots, DataFrames, PlutoUI
end

# ╔═╡ 5ef8147c-1d07-4367-a93d-416a9b7417b3
update_theme!(linewidth=4, fontsize=20)

# ╔═╡ 04ab13f8-0698-465a-882c-ac6128cd810b
md"
# numerically solving ODEs and simulating the continuous process of saline solution production via mixing salt and water

**learning objectives:**
* use `DifferentialEquations.jl` in Julia (documentation [here](https://docs.sciml.ai/DiffEqDocs/stable/getting_started/#Example-1-:-Solving-Scalar-Equations)) to numerically solve (well, approximate the solution to) nonlinear ordinary differential equations (ODEs).
* illustrate the usefulness of dynamic models to predict how an input affects an output in a continuous process.

📔 [Julia cheatsheet](https://cheatsheet.juliadocs.org)
"

# ╔═╡ 3e141f28-7126-4108-948f-13634ed02257
md"## saline solution facility

a dynamic model of the process to produce saline solution (see lecture notes and hw1) is:
```math
\begin{equation}
    V \frac{dc}{dt} = w(t) - c(t) \left[q(t)-\frac{\alpha-1}{\rho_w} w(t) \right]
\end{equation}
```

#### parameters (constant)
*  $V$ [L]: volume of liquid in the tank
*  $\alpha$ [g solution /g salt]: describes dependence of the density of the saline solution on the salt concentration.
*  $\rho_w$ [g / L]: density of pure water

#### inputs
*  $q(t)$ [L water/ s]: incoming volumetric flow rate of pure water
*  $w(t)$ [g salt / s]: incoming gravimetric flow rate of solid salt granules

#### output
*  $c(t)$ [g salt/L solution]: concentration of salt in the outlet stream
"

# ╔═╡ 82c8f328-0243-4108-80a3-07dce9fe7c1f
html"<img src=\"https://github.com/SimonEnsemble/CHE_361_W2023/blob/main/images/salt_mixer.png?raw=true\" width=400>"

# ╔═╡ 5fa98241-6651-4363-99bf-20604f079ad3
md"
### problem setup
take the parameters as:                                                            
*  $V=25$ L                                         
*  $\alpha=0.64$ g / g                                                              
*  $\rho_w=1000$ g/L 
also, the salt input rate as constant:
*  $w(t)=\bar{w}=0.2$ g/s     

!!! note \"task\"
	our task then in this studio is to predict how the output $c(t)$ behaves in response to a time-varying input $q(t)$ (described later). the other input, $w(t)=\bar{w}$, is constant with time.
	
🐝 assign `V`, `α`, `ρw`, and `w̄` as variables in the cell below, for later use in the code.
"  

# ╔═╡ 548d1f73-8772-4ede-b1c6-e6bf31d21138
begin    
	# parameters
    
	# constant input
end 

# ╔═╡ 3c729599-4be0-422d-9a66-fc871f246729
md"
### computing the desired salt input rate

!!! example \"customer standards\"
	the customer, a hospital, wishes for saline solution with a salt concentration of $\bar{c}=0.1$ g/L. however, they will accept saline solution with salt concentration $c\in[0.07, 0.13]$ g/L. ie., the customer specifications are for the saline solution to have a salt concentration within 0.03 g/L of the target $\bar{c}=0.1$ g/L.                                                      
" 

# ╔═╡ db3976e0-5430-45a4-9d2f-6ad360c134ee
c̄ = 0.1 # desired salt concentration, g/L

# ╔═╡ ae760afc-1704-4992-9fb0-8bc770569d8c
md"🐝 to produce saline solution that meets the customer specifications, we wish to achieve and maintain a constant output salt concentration of $\bar{c}$ at steady state conditions. given the value of the constant incoming flow rate of salt, $\bar{w}$, compute the corresponding steady state value $\bar{q}$ [g/s] of the incoming water stream, $q$, that we should maintain. assign it as a variable `q̄`.
"

# ╔═╡ e1e14dd3-fe8d-4705-a541-27b3b7f449da

# ╔═╡ 72bfb292-2b6b-46fc-98a9-81017fb9bd1d
md"
### a disturbance in the incoming salt

suppose the process is initially ($t=0$) operating at steady state---with the proper inlet water flow rate $\bar{q}$ and salt flow rate $\bar{w}$, thus, producing saline solution with the desired salt concentration $\bar{c}$. (well-mixed $\implies$ the salt concentration in the solution in the tank is initially $\bar{c}$ as well.)

these steady state conditions are maintained until $t=60$ s.

at $t=60$ s, the water pump loses power and shuts off (thus, no water is fed into the tank) temporarily, for only 30 s.
i.e. at $t=90$ s, the pump resumes to [immediately] achieve water inlet rate $\bar{q}$ again.

🐝 model this input $q=q(t)$ as a rectangular pulse---a piecewise flat function. write it mathematically by editing this markdown cell.

```math
\begin{equation}
q(t) = \begin{cases}
?? , & t<?? \\
??, & ??<t<??\\
??, & t>??
	\end{cases}
\end{equation}
```
"

# ╔═╡ e8e2333d-eef1-4f35-becf-4c31ba95f238
md"
🐝 code-up this rectangular pulse input $q(t)$ as a function in Julia, `q(t)`, that takes the time `t` as input and returns the water inlet flow rate at that time `t`. 
"

# ╔═╡ 4d09665d-31f9-4836-a68e-33d83b224fd3

# ╔═╡ ce1a816a-a60b-40b0-a300-e240e508acb6
md"🐝 to verify your `q(t)` function, use it to plot this rectangular pulse input $q(t)$ over the domain $t\in[0,250]$ s. include x- and y-axis labels with units and a title \"rectangular pulse function\".
"

# ╔═╡ 7955eb9d-61df-42e9-953b-b042c0d2542c

# ╔═╡ dbe43e13-7137-41d3-b56f-090b478d625a

# ╔═╡ a78430b5-b763-4523-9895-3be19b809ea5
md"🐝 on paper, sketch out what you anticipate the salt concentration $c(t)$ in the tank to look like in response to this rectangular pulse input $q(t)$. this should test your intuition of the process dynamics.

### 🚀 simulation time! 🚀

🐝 use `DifferentialEquations.jl` to simulate the concentration of salt in the tank $c(t)$ in response to this disturbance in the water inlet rate $q(t)$, for $t\in[0, 250]$ s. 

plot the numerical solution, $c(t)$, for $t\in[0, 250]$ s.
* include x- and y-axis labels indicating which variable is on the axis and its units.
* plot a black, horizontal, dashed line at $\bar{c}=0.1$ g/L.
* enforce a minimal y-axis limit of 0 to give perspective of how close the water is to being pure.

!!! hint
	see `DifferentialEquations.jl` docs for an example [here](https://docs.sciml.ai/DiffEqDocs/stable/getting_started/#Example-1-:-Solving-Scalar-Equations).

!!! hint
	viewing the dynamic model as $dc/dt=f(c, t)$, use the time argument, `t`, in your Julia function `f(c, p, t)`, by passing it to your `q(t)` function to retreive the value of $q$ at that time.

!!! hint
	pass `d_discontinuities=[60.0, 90.0]` to `ODEProblem` to inform the solver where discontinuities are present.
"

# ╔═╡ 434aaccc-d0b7-43fb-923f-89e92eba6153
begin
	# initial condition
	
	# viewing the ODE as dc/dt=f(c, t)
	#  hint: DifferentialEquations.jl requires the form f(c, p, t) where p are params. we won't use the p argument. (but you can if you want)	
	
	# DifferentialEquations.jl syntax

	# solve ODE, return data frame
end

# ╔═╡ a6cfd7c8-5557-4260-a8d3-c3342ff26e61

# ╔═╡ 2f0f38ab-dab4-421d-89f8-18f9afa6d03c

# ╔═╡ fbf03ff1-27d6-4fdb-a523-6757ba3a5a7c

# ╔═╡ b67f3967-1cda-44d0-8243-ce603f5f913a
md"
🐝 does the solution $c(t)$ conform to your expectations? explain the shape of the response curve to your neighbor.

🐝 owing to the pump power outage, for what time interval is the process producing saline solution that does not meet customer standards?

!!! hint
	options: `for` loop, `findfirst`/`findlast`, or a `filter`.
"

# ╔═╡ 9f5a3ee7-5505-4d34-bfa5-f1f0844f853d

# ╔═╡ dc8e7160-690d-489e-8f7c-3efd85530876
md"🐝 verify your calculation above by (i) replotting $c(t)$ and (ii) using:
```julia
vspan!(ax, t_start, t_end, color=(:red, 0.2))
```
to highlight, on the same plot, the time interval over which the saline solution *cannot* be sold because it does not meet customer specifications. see the [`CairoMakie.jl` docs](https://docs.makie.org/dev/reference/plots/vspan). also draw a horizontal dashed line indicating the highest acceptable concentration of salt for the customer.
"

# ╔═╡ 0d0e6241-dbc9-418b-b696-8f2922b023ed

# ╔═╡ Cell order:
# ╠═10584412-7a33-11ec-2593-c1520e9673b3
# ╠═5ef8147c-1d07-4367-a93d-416a9b7417b3
# ╟─04ab13f8-0698-465a-882c-ac6128cd810b
# ╟─3e141f28-7126-4108-948f-13634ed02257
# ╟─82c8f328-0243-4108-80a3-07dce9fe7c1f
# ╟─5fa98241-6651-4363-99bf-20604f079ad3
# ╠═548d1f73-8772-4ede-b1c6-e6bf31d21138
# ╟─3c729599-4be0-422d-9a66-fc871f246729
# ╠═db3976e0-5430-45a4-9d2f-6ad360c134ee
# ╟─ae760afc-1704-4992-9fb0-8bc770569d8c
# ╠═e1e14dd3-fe8d-4705-a541-27b3b7f449da
# ╟─72bfb292-2b6b-46fc-98a9-81017fb9bd1d
# ╟─e8e2333d-eef1-4f35-becf-4c31ba95f238
# ╠═4d09665d-31f9-4836-a68e-33d83b224fd3
# ╟─ce1a816a-a60b-40b0-a300-e240e508acb6
# ╠═7955eb9d-61df-42e9-953b-b042c0d2542c
# ╠═dbe43e13-7137-41d3-b56f-090b478d625a
# ╟─a78430b5-b763-4523-9895-3be19b809ea5
# ╠═434aaccc-d0b7-43fb-923f-89e92eba6153
# ╠═a6cfd7c8-5557-4260-a8d3-c3342ff26e61
# ╠═2f0f38ab-dab4-421d-89f8-18f9afa6d03c
# ╠═fbf03ff1-27d6-4fdb-a523-6757ba3a5a7c
# ╟─b67f3967-1cda-44d0-8243-ce603f5f913a
# ╠═9f5a3ee7-5505-4d34-bfa5-f1f0844f853d
# ╟─dc8e7160-690d-489e-8f7c-3efd85530876
# ╠═0d0e6241-dbc9-418b-b696-8f2922b023ed
