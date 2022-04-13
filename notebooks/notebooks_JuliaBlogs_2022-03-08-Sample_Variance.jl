### A Pluto.jl notebook ###
# v0.19.0

using Markdown
using InteractiveUtils

# ╔═╡ 1aa48d46-ce4b-4208-afed-115b6cbac2ae
using Statistics, LinearAlgebra

# ╔═╡ eb5fc016-c3ad-486c-ae79-6448140e0731
md"""
#### 贝塞尔校正
"""

# ╔═╡ a668736a-2a2d-11ec-38e2-dd91039961aa
md"""

[样本方差](https://en.wikipedia.org/wiki/Variance#Sample_variance) 的计算公式为
```math
s_n^2 = \frac{1}{n-1}\sum (x_i-\bar{x})^2
```
有趣的是其分母部分是 $n-1$。 此处的$n-1$被称作[贝塞尔校正](https://en.wikipedia.org/wiki/Bessel%27s_correction)。 平常解释都使用[自由度](https://en.wikipedia.org/wiki/Degrees_of_freedom_(statistics)) 概念。 下面是几个例子：
"""

# ╔═╡ 8041a08c-7279-4373-80e5-f865131d97cf
function f1(n)
    x = randn(n)
    return norm(x .- mean(x))^2
end

# ╔═╡ 7c872172-d4cf-4bfc-af84-06de609477ef
mean([f1(11) for i=1:1_000_000])

# ╔═╡ f7309eb8-e721-43ef-bb94-ec4808f5743f
md"""
#### 投射矩阵
"""

# ╔═╡ d1012416-441d-465a-989a-ac6549d4b3ce
md"""
给定投射矩阵 $P = I - 1/n$, 一个数组的离差（`x - mean(x)`） 可以通过矩阵和数组的乘积来计算 `Px`

```math
\begin{align}

\text{Dev}(x_j) 
& = x_j - \text{mean}(X) \\

& = x_j - \frac{x_1 + \cdots + x_i + \cdots + x_n}{n} \\

& = \frac{n - 1}{n}x_j + \frac{-1}{n}x_1 + \cdots + \frac{-1}{n}x_{j-1} + \frac{-1}{n}x_{j+1} + \cdots + \frac{1}{n}x_n
\end{align}
```

如果把投射矩阵做特征值分解， 即 $P = Q \Lambda Q'$， 那么 $\Lambda$ 将有一个值为 0， 其余值为 1。
"""

# ╔═╡ ee43a4c3-86ee-4392-94c7-6b90f00e4769
projectionMatrix(n) = Matrix(I, n, n) .- 1 // n 

# ╔═╡ 1b3734a8-3977-46e4-a323-52c3972d2dc1
Prj = projectionMatrix(5)

# ╔═╡ dfb4165f-730c-415c-ad30-89f185e64a60
Λ, Q = eigen(Prj)

# ╔═╡ 4ef1d5e9-4f0b-45f1-ad2a-6a89f02a5992
md"""
#### 矩阵分解与贝塞尔校正
"""

# ╔═╡ 71132fe4-a64a-4211-bfe6-a164cc874d8f
md"""
注意： `randn(n)` 是由 `n` 个标准正态分数组成的一个数组。 而 `randn(1)^2`的期望值是1。 

如果 `Q` 是一个正交矩阵 (orthgonal matrix)， 那么 `Q * randn(n)` 也是一个标准正态数据组成的一个 `n` 维数组。 在数学层次上是没有办法区分 `randn(n)` 和  `Q * randn(n)` 的。 这是因为该概率函数是与 $e^{-||x||^2/2}$ 成比例存在， 即它只依赖于 `x` 的长度而不是其方向。 所以， 

```math
||PQx||^2 = ||Q\Lambda x||^2 = ||\Lambda x|^2 = x_2^2 + \cdots + x_n^2
```

很显然， 其期望值应该是 `n-1`。
"""

# ╔═╡ 06308e2a-2e35-4aaa-ad6e-086cc82f7c2d
function f2(n)
	Prj = projectionMatrix(n)
	LV, QM = eigen(Prj)
	LM = diagm(LV)
	X  = randn(n)
	LX = LM * X
	return LX'LX
end

# ╔═╡ 1be65ce3-ea21-4959-a886-c0994aedeb26
mean([f2(11) for i = 1:100_000])

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
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
# ╟─eb5fc016-c3ad-486c-ae79-6448140e0731
# ╟─a668736a-2a2d-11ec-38e2-dd91039961aa
# ╠═8041a08c-7279-4373-80e5-f865131d97cf
# ╠═7c872172-d4cf-4bfc-af84-06de609477ef
# ╟─f7309eb8-e721-43ef-bb94-ec4808f5743f
# ╟─d1012416-441d-465a-989a-ac6549d4b3ce
# ╠═ee43a4c3-86ee-4392-94c7-6b90f00e4769
# ╠═1b3734a8-3977-46e4-a323-52c3972d2dc1
# ╠═dfb4165f-730c-415c-ad30-89f185e64a60
# ╟─4ef1d5e9-4f0b-45f1-ad2a-6a89f02a5992
# ╟─71132fe4-a64a-4211-bfe6-a164cc874d8f
# ╠═06308e2a-2e35-4aaa-ad6e-086cc82f7c2d
# ╠═1be65ce3-ea21-4959-a886-c0994aedeb26
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
