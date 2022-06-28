### A Pluto.jl notebook ###
# v0.19.9

using Markdown
using InteractiveUtils

# ╔═╡ 9cce261b-fecf-4431-9c2c-770270d8f5e3
md"""
# 组合运算符 ``\circ``
"""

# ╔═╡ 238ce9e8-b235-4a6e-9572-8286e4b94ff7
using PlutoUI, BenchmarkTools

# ╔═╡ 5836e3bf-4841-47c8-b5bd-a2ea99821ad1
md"""
- 初识组合运算符 ``\circ``
"""

# ╔═╡ a118fd87-eb47-4284-bc74-96980f450633
md"""
要了解组合运算符 ``\circ``， 可以首先从其帮助文档开始：
"""

# ╔═╡ fc3a2cd0-3ea4-11ec-1d80-77833be4418b
# @doc ∘

# ╔═╡ bfa5bc60-9e7d-4dec-aeff-138880a9174e
md"""
所以在 REPL 和合理配置的编辑器中使用复合运算符可以通过 `\circ <tab>` 来输入。 还可以查看其单一码（`Unicode`）， 或 `UTF-8` 表征：
"""

# ╔═╡ 9c22e106-65eb-43cf-9716-173158bdd02d
'∘'

# ╔═╡ 542569f1-efae-4dc8-830b-ba4478298953
codeunits("∘")

# ╔═╡ feb8fbf4-13f4-4236-ae78-f59b7064ea18
md"""
- 理解组合运算符 ``\circ``
"""

# ╔═╡ cac491da-f274-4b31-b427-faa9c8164e49
md"""
假定 `f` 和 `g` 是两个函数， 那么 `f` ``\circ`` `g` 也是一个函数。 该函数的参数与 `g` 一致， 并把 
 `g` 的输出值传递给函数 `f`。 该操作叫做函数的组合 (function composiiton)。 例如
"""

# ╔═╡ 94fb261c-944e-4001-b4f0-e8fcfca39c3e
c = abs ∘ sin

# ╔═╡ 4efdb5aa-3ef8-4f9f-8ae3-ed376e46d0d8
c(-1)

# ╔═╡ 5cba5e5f-363f-4e44-8e16-97bae225797e
abs(sin(-1))

# ╔═╡ 31428755-c959-4684-8c4b-144833617173
abs(sin(-1)) == c(-1)

# ╔═╡ bee10be8-06bf-468c-85bb-d889f21af233
md"""
对象一旦已经产生， 我们就可以查看其相关特征了：
"""

# ╔═╡ eda1c67e-5e4b-4c23-8384-c5f6e1921301
typeof(c) # 类型

# ╔═╡ ab1f4bc7-e369-4527-96de-a1543baefcf0
fieldnames(typeof(c))

# ╔═╡ 44d7e992-e9b3-4922-96a9-bba5089b0e53
c.outer

# ╔═╡ 4292198a-1787-4514-9c1b-5b41f916e25b
c.inner

# ╔═╡ 65c7ed2a-0e3d-41a0-a233-c5c0fda38849
md"""
可以看到， 对象 `c` 是一个组合函数， 即其类型是 `ComposedFunction`。 也可以很容易地恢复和提取被组合函数。很多情况下， 这两个特征是很有用的。
"""

# ╔═╡ e0aeccea-3a87-449d-9cd6-2dc6c34c3418
md"""
需要注意的一点是， 如果你需要直接调用组合函数， 你需要用括号把其阔起来：
"""

# ╔═╡ 7469eb94-6f40-4e9b-90d3-d3bb3df037b2
abs ∘ sin(-1) # 不正确

# ╔═╡ e9c018e5-5a1e-4a75-91e5-6a7f2ba8e6a3
(abs ∘ sin)(-1) # 正确

# ╔═╡ ef5d9f8f-7b02-4bad-b3b9-1da0644f25ca
md"""
- 组合符号 ``\circ`` 存在的逻辑合理性
"""

# ╔═╡ bfa8acf9-ba49-4722-9d58-8cf747aa5e35
md"""
既然 $f \circ g (x)$ 等价于 $f(g(x))$ 和管道 $x |> g |> f$， 那么复合符号存在的意义是什么呢？ $\circ$ 存在意义在于 $f \circ g$ 是一个可以被传递的对象。 虽然你可以创造一个不具名函数, 例如 $x -> f(g(x))$ 或 $x -> x |> g |> f$。 但很明显组合符号更简单。 组合函数 $f\circ g$ 通常被作为一个参数输入到更高级的函数中。 如：
"""

# ╔═╡ cd481e49-4589-4e81-8503-9673613ad0eb
map(uppercase ∘ strip, [" a", "b ", " c "])

# ╔═╡ 306b5e17-d7d6-445d-b825-f8b7c43ec3e7
sum(sqrt ∘ abs, -10:10)

# ╔═╡ c6e7cad7-e467-4059-bb7e-1ab17a1c5f4d
x = 1:100

# ╔═╡ e854d4f7-56eb-4a2d-a133-3acd7bdb7bfa
with_terminal() do
	@time sum(abs ∘ sin, x)
end

# ╔═╡ 0889d985-96fa-4a18-a88e-572e62ff89ed
with_terminal() do
	@time sum(x -> abs(sin(x)), x)
end

# ╔═╡ a722f569-e053-41db-aeb5-089982c89964
md"""
即组合函数只需编译一次。 这是因为 `abs ∘ sin` 的类型是一致不变的, 即 `ComposedFunction{typeof(abs), typeof(sin)}`。 但是如果你定义了一个匿名函数， 每次定义一个匿名函数， 都会产生一个新的独立的对象：
"""

# ╔═╡ f0f89cc1-cfdb-47a3-8e10-d5cf8fdb4cce
x -> abs(sin(x)) # 一个方法

# ╔═╡ bf58e4cd-f35f-450b-bc2b-d19c673e0d60
x -> abs(sin(x)) # 一个新的方法

# ╔═╡ 199215cf-85e4-4720-b377-55166e3a5184
md"""
- 原文链接： [Why, how, and when of ∘](https://bkamins.github.io/julialang/2021/11/05/circ.html)
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
BenchmarkTools = "~1.2.0"
PlutoUI = "~0.7.18"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "0ec322186e078db08ea3e7da5b8b2885c099b393"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.0"

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[BenchmarkTools]]
deps = ["JSON", "Logging", "Printf", "Profile", "Statistics", "UUIDs"]
git-tree-sha1 = "61adeb0823084487000600ef8b1c00cc2474cd47"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.2.0"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[HypertextLiteral]]
git-tree-sha1 = "5efcf53d798efede8fee5b2c8b09284be359bf24"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.2"

[[IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "ae4bbcadb2906ccc085cf52ac286dc1377dceccc"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.1.2"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "57312c7ecad39566319ccf5aa717a20788eb8c1f"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.18"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[Profile]]
deps = ["Printf"]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╟─f5450eab-0f9f-4b7f-9b80-992d3c553ba9
# ╟─9cce261b-fecf-4431-9c2c-770270d8f5e3
# ╠═238ce9e8-b235-4a6e-9572-8286e4b94ff7
# ╟─5836e3bf-4841-47c8-b5bd-a2ea99821ad1
# ╟─a118fd87-eb47-4284-bc74-96980f450633
# ╠═fc3a2cd0-3ea4-11ec-1d80-77833be4418b
# ╟─bfa5bc60-9e7d-4dec-aeff-138880a9174e
# ╠═9c22e106-65eb-43cf-9716-173158bdd02d
# ╠═542569f1-efae-4dc8-830b-ba4478298953
# ╟─feb8fbf4-13f4-4236-ae78-f59b7064ea18
# ╠═cac491da-f274-4b31-b427-faa9c8164e49
# ╠═94fb261c-944e-4001-b4f0-e8fcfca39c3e
# ╠═4efdb5aa-3ef8-4f9f-8ae3-ed376e46d0d8
# ╠═5cba5e5f-363f-4e44-8e16-97bae225797e
# ╠═31428755-c959-4684-8c4b-144833617173
# ╟─bee10be8-06bf-468c-85bb-d889f21af233
# ╠═eda1c67e-5e4b-4c23-8384-c5f6e1921301
# ╠═ab1f4bc7-e369-4527-96de-a1543baefcf0
# ╠═44d7e992-e9b3-4922-96a9-bba5089b0e53
# ╠═4292198a-1787-4514-9c1b-5b41f916e25b
# ╟─65c7ed2a-0e3d-41a0-a233-c5c0fda38849
# ╟─e0aeccea-3a87-449d-9cd6-2dc6c34c3418
# ╠═7469eb94-6f40-4e9b-90d3-d3bb3df037b2
# ╠═e9c018e5-5a1e-4a75-91e5-6a7f2ba8e6a3
# ╟─ef5d9f8f-7b02-4bad-b3b9-1da0644f25ca
# ╟─bfa8acf9-ba49-4722-9d58-8cf747aa5e35
# ╠═cd481e49-4589-4e81-8503-9673613ad0eb
# ╠═306b5e17-d7d6-445d-b825-f8b7c43ec3e7
# ╠═c6e7cad7-e467-4059-bb7e-1ab17a1c5f4d
# ╠═e854d4f7-56eb-4a2d-a133-3acd7bdb7bfa
# ╠═0889d985-96fa-4a18-a88e-572e62ff89ed
# ╟─a722f569-e053-41db-aeb5-089982c89964
# ╠═f0f89cc1-cfdb-47a3-8e10-d5cf8fdb4cce
# ╠═bf58e4cd-f35f-450b-bc2b-d19c673e0d60
# ╟─199215cf-85e4-4720-b377-55166e3a5184
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
