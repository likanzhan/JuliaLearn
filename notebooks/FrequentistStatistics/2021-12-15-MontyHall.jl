### A Pluto.jl notebook ###
# v0.19.9

using Markdown
using InteractiveUtils

# ╔═╡ b926ff60-5d3d-11ec-3b1d-49d78f14aab8
using Random

# ╔═╡ ffc21f5c-7722-4323-9d3f-a8b62c787985
function montyHall(switchPoly; n = 3)
	prize, choice = rand(1:n), rand(1:n)
	remain = (prize == choice) ? rand(setdiff(1:n, choice)) : prize
	# Short-Circuit Evaluation
	switchPoly && (choice = remain) # ||
	# choice  = switchPoly ? Remaining : choice
	return choice == prize
end

# ╔═╡ 2e9ffba9-661e-4209-9e14-59f066edb533
N = 10^6

# ╔═╡ b2f1d494-577d-4846-9a42-354e59b7b04d
Random.seed!(1)

# ╔═╡ e347c824-29bd-48f4-a920-cff37c67dc8f
sum(montyHall(false, n=10) for _ in 1:N) / N

# ╔═╡ 90f75934-18d2-46ae-a973-f6b932a0e394
Random.seed!(1)

# ╔═╡ a95a07d2-4700-41cc-98b0-9903706ec16b
sum(montyHall(true, n=10) for _ in 1:N) / N

# ╔═╡ b59c2e3f-159a-4346-8ce2-89744f1a16bc
x = [[2] 2 (2, 2) (2) (2,)]

# ╔═╡ 121bfe64-7352-46f0-b6c8-5fefbe27daba
typeof.(x)

# ╔═╡ 533cdfb4-6c15-472d-8124-716d124c6ebc
vec = [2]

# ╔═╡ 0c31e2d7-ddff-483b-84f0-ba92a1aef970
vec[]

# ╔═╡ 2f326f0e-9841-44d6-b394-afe192d83b02
vec[3:end]

# ╔═╡ 95feb4d9-e2bd-462b-9670-41db03cd5037
[first(vec) last(vec)]

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.2"
manifest_format = "2.0"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
"""

# ╔═╡ Cell order:
# ╠═b926ff60-5d3d-11ec-3b1d-49d78f14aab8
# ╠═ffc21f5c-7722-4323-9d3f-a8b62c787985
# ╠═2e9ffba9-661e-4209-9e14-59f066edb533
# ╠═b2f1d494-577d-4846-9a42-354e59b7b04d
# ╠═e347c824-29bd-48f4-a920-cff37c67dc8f
# ╠═90f75934-18d2-46ae-a973-f6b932a0e394
# ╠═a95a07d2-4700-41cc-98b0-9903706ec16b
# ╠═b59c2e3f-159a-4346-8ce2-89744f1a16bc
# ╠═121bfe64-7352-46f0-b6c8-5fefbe27daba
# ╠═533cdfb4-6c15-472d-8124-716d124c6ebc
# ╠═0c31e2d7-ddff-483b-84f0-ba92a1aef970
# ╠═2f326f0e-9841-44d6-b394-afe192d83b02
# ╠═95feb4d9-e2bd-462b-9670-41db03cd5037
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
