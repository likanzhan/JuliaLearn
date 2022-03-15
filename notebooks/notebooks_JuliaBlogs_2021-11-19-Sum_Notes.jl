### A Pluto.jl notebook ###
# v0.18.2

using Markdown
using InteractiveUtils

# ╔═╡ dc794918-4948-11ec-176c-151d58a07b63
using Statistics

# ╔═╡ 8b83de6d-d7e3-4b7a-a312-c00e4c4c0390
md"""
- 为了完全不使用内存分配， `Statistics.jl` 对函数 `sum!` 的定义是首先把目标数组初始化为 `0`. 在这个步骤后， 目标数组就只包含 `0` 了。 例如：
"""

# ╔═╡ 08f47b2a-d448-4e19-9d67-490db0d5bba1
x1 = reshape(1:9, 3, 3) |> transpose |> Matrix

# ╔═╡ e2985a9a-4cbf-4752-b127-ef0fd99d71ec
y1 = view(x1, :, 1)

# ╔═╡ 7a0427a8-400a-4a1e-ae72-31ac3d6f4e95
sum!(y1, x1)

# ╔═╡ a0232b4d-2741-4332-bbc7-beedd181f93f
x1

# ╔═╡ cf82d9b7-f563-455b-9c98-7a6cbec9724c
md"""
- `mean!()`  的行为与 `sum!()` 类似， 因为 `mean!()` 实际调用的就是 `sum!()`。 例如， 
"""

# ╔═╡ 98a63659-1f56-4aab-bcd9-11d45e586378
x2 = 1:3 |> transpose |> Matrix

# ╔═╡ 6f973d8d-9d9b-4db7-8cb0-66a79f759386
mean!(x2, x2)

# ╔═╡ f4b9f30b-6d1e-42e4-9830-5b350fd56183
x3 = 1:3 |> transpose |> Matrix

# ╔═╡ 02d21ddb-26bd-45e2-857d-18962fec6e61
mean!(copy(x3), x3)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
"""

# ╔═╡ Cell order:
# ╟─f5450eab-0f9f-4b7f-9b80-992d3c553ba9
# ╠═dc794918-4948-11ec-176c-151d58a07b63
# ╟─8b83de6d-d7e3-4b7a-a312-c00e4c4c0390
# ╠═08f47b2a-d448-4e19-9d67-490db0d5bba1
# ╠═e2985a9a-4cbf-4752-b127-ef0fd99d71ec
# ╠═7a0427a8-400a-4a1e-ae72-31ac3d6f4e95
# ╠═a0232b4d-2741-4332-bbc7-beedd181f93f
# ╟─cf82d9b7-f563-455b-9c98-7a6cbec9724c
# ╠═98a63659-1f56-4aab-bcd9-11d45e586378
# ╠═6f973d8d-9d9b-4db7-8cb0-66a79f759386
# ╠═f4b9f30b-6d1e-42e4-9830-5b350fd56183
# ╠═02d21ddb-26bd-45e2-857d-18962fec6e61
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
