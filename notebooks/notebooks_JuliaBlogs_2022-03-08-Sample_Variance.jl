### A Pluto.jl notebook ###
# v0.18.1

using Markdown
using InteractiveUtils

# ╔═╡ 1aa48d46-ce4b-4208-afed-115b6cbac2ae
using Statistics, LinearAlgebra

# ╔═╡ a668736a-2a2d-11ec-38e2-dd91039961aa
md"""

[样本方差](https://en.wikipedia.org/wiki/Variance#Sample_variance) 的计算公式为
```math
s_n^2 = \frac{1}{n-1}\sum (x_i-\bar{x})^2
```
有趣的是其分母部分是 $n-1$。 此处的$n-1$被称作[贝塞尔校正](https://en.wikipedia.org/wiki/Bessel%27s_correction)。 平常解释都使用[自由度](https://en.wikipedia.org/wiki/Degrees_of_freedom_(statistics)) 概念。

下面是几个例子 (另外 `randn(1)^2`的期望值是1)
"""

# ╔═╡ 8041a08c-7279-4373-80e5-f865131d97cf
function f(n)
    x = randn(n)
    norm(x .- mean(x))^2
end

# ╔═╡ d828eb5d-df3e-4c90-85bf-eb7fb94f7b2b
f(11)

# ╔═╡ da914742-b67a-4966-8fad-758bea21e492
mean([f(11) for i=1:1_000_000])

# ╔═╡ 7c872172-d4cf-4bfc-af84-06de609477ef
mean([f(5) for i=1:1_000_000])

# ╔═╡ 86524e54-e0cf-46ea-ba80-76d9ff1509ec
md"""
- 传统计算方法
"""

# ╔═╡ 77c6232f-3fef-47e8-a6fb-5fc5499eb338
using Random; Random.seed!(1);

# ╔═╡ 9314893a-12aa-4564-bd51-9e03337a9a75
X = randn(10) # collect(3:7) #

# ╔═╡ e6336c3b-af8a-418a-81e4-56ab5c8b99c1
n = length(X)

# ╔═╡ a76a49bc-4d2b-4315-b22a-7b13f6940b56
sum((X .- mean(X)) .^2)

# ╔═╡ f7fd4861-a67c-43ad-b5d6-b546a74856be
SD = std(X)^2 * (n-1)

# ╔═╡ d1012416-441d-465a-989a-ac6549d4b3ce
md"""
- 线性代数让 `n-1` 更容易理解

给定投射矩阵 $P = I - 1/n$, 一个数组的离差（`x - mean(x)`） 可以通过矩阵和数组的乘积来计算 `Px`

```math
Dev(x_j)
= x_j - mean(X) 
= x_j - \frac{x_1 + \cdots + x_i + \cdots + x_n}{n}
= \frac{n - 1}{n}x_j + \frac{-1}{n}x_1 + \cdots + \frac{-1}{n}x_{j-1} + \frac{-1}{n}x_{j+1} + \cdots + \frac{1}{n}x_n
```
"""

# ╔═╡ ee43a4c3-86ee-4392-94c7-6b90f00e4769
pf(n) = Matrix(I, n, n) .- 1 // n 

# ╔═╡ 1b3734a8-3977-46e4-a323-52c3972d2dc1
P = pf(n)

# ╔═╡ 32fb6120-9fca-47ab-88a8-7c1601f05804
X

# ╔═╡ a5cf93d0-19b5-41cf-8065-9be58e556e4f
Dev = P * X

# ╔═╡ e844e791-d7e9-40fd-be88-ab1c423a3368
Dev'Dev

# ╔═╡ 9922399e-8105-490d-96ef-8d8d7fb1db4c
md"""
如果把投射矩阵做特征值分解， 即 $P = Q \Lambda Q'$， 那么 $\Lambda$ 将有一个值为 0， 其余值为 1。
"""

# ╔═╡ dfb4165f-730c-415c-ad30-89f185e64a60
Λ, Q = eigen(P)

# ╔═╡ 71132fe4-a64a-4211-bfe6-a164cc874d8f
md"""
- 几个事实
`randn(n)` 是由 `n` 个标准正态分数组成的一个数组。 如果 `Q` 是一个正交矩阵 (orthgonal matrix)， 那么 `Q * randn(n)` 也是一个标准正态数据组成的一个 `n` 维数组。 在数学层次上是没有办法区分 `randn(n)` 和  `Q * randn(n)` 的。 这是因为该概率函数是与 $e^{-||x||^2/2}$ 成比例存在， 即它只依赖于 `x` 的长度而不是其方向。 所以， 

```math
||PQx||^2 = ||Q\Lambda x||^2 = ||\Lambda x|^2 = x_2^2 + \cdots + x_n^2
```

很显然， 其期望值应该是 `n-1`。
"""

# ╔═╡ fcd59892-e16c-44b8-a2be-38b017cc11e8
PQX = P * Q * X

# ╔═╡ 01785754-6d2b-45a2-ba67-fdd64bb59732
QLX = Q * diagm(Λ) * X

# ╔═╡ 2be8f66f-f895-483c-853c-419369a81120
LX = diagm(Λ) * X

# ╔═╡ 4325708c-de9a-476a-8506-5edc975b286a
PQX'PQX

# ╔═╡ 73c558e1-750b-4402-8ff1-9cf9779a90ce
QLX'QLX

# ╔═╡ 47573b08-a3ff-43e1-a6d1-d8bc4c6139e3
LX'LX

# ╔═╡ fac1ec0a-41e3-4f86-a8c0-bd72719105e2
sum(X[2:n] .^ 2)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
"""

# ╔═╡ Cell order:
# ╟─f5450eab-0f9f-4b7f-9b80-992d3c553ba9
# ╠═1aa48d46-ce4b-4208-afed-115b6cbac2ae
# ╟─a668736a-2a2d-11ec-38e2-dd91039961aa
# ╠═8041a08c-7279-4373-80e5-f865131d97cf
# ╠═d828eb5d-df3e-4c90-85bf-eb7fb94f7b2b
# ╠═da914742-b67a-4966-8fad-758bea21e492
# ╠═7c872172-d4cf-4bfc-af84-06de609477ef
# ╟─86524e54-e0cf-46ea-ba80-76d9ff1509ec
# ╠═77c6232f-3fef-47e8-a6fb-5fc5499eb338
# ╠═9314893a-12aa-4564-bd51-9e03337a9a75
# ╠═e6336c3b-af8a-418a-81e4-56ab5c8b99c1
# ╠═a76a49bc-4d2b-4315-b22a-7b13f6940b56
# ╠═f7fd4861-a67c-43ad-b5d6-b546a74856be
# ╟─d1012416-441d-465a-989a-ac6549d4b3ce
# ╠═ee43a4c3-86ee-4392-94c7-6b90f00e4769
# ╠═1b3734a8-3977-46e4-a323-52c3972d2dc1
# ╠═32fb6120-9fca-47ab-88a8-7c1601f05804
# ╠═a5cf93d0-19b5-41cf-8065-9be58e556e4f
# ╠═e844e791-d7e9-40fd-be88-ab1c423a3368
# ╟─9922399e-8105-490d-96ef-8d8d7fb1db4c
# ╠═dfb4165f-730c-415c-ad30-89f185e64a60
# ╟─71132fe4-a64a-4211-bfe6-a164cc874d8f
# ╠═fcd59892-e16c-44b8-a2be-38b017cc11e8
# ╠═01785754-6d2b-45a2-ba67-fdd64bb59732
# ╠═2be8f66f-f895-483c-853c-419369a81120
# ╠═4325708c-de9a-476a-8506-5edc975b286a
# ╠═73c558e1-750b-4402-8ff1-9cf9779a90ce
# ╠═47573b08-a3ff-43e1-a6d1-d8bc4c6139e3
# ╠═fac1ec0a-41e3-4f86-a8c0-bd72719105e2
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
