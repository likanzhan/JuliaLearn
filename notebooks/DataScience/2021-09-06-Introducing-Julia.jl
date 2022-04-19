### A Pluto.jl notebook ###
# v0.18.0

using Markdown
using InteractiveUtils

# ╔═╡ f924796f-52f3-4b4b-aa47-61a179874647
using Pkg, Plots, LaTeXStrings, Measures

# ╔═╡ 6dd76507-be07-4c3a-9747-99eca74d3519
begin
	using PlutoUI
	PlutoUI.TableOfContents(title = "初识 Julia")
end

# ╔═╡ 2fdb3281-7229-4f18-b9d9-bc5e3086d903
using Statistics

# ╔═╡ 3baed4bd-1c0c-4d44-b7ab-f7c0627fda1b
begin
	using AbstractTrees
	AbstractTrees.children(x::Type) = subtypes(x)
	with_terminal(() -> print_tree(Number))
end

# ╔═╡ 2edcc72c-bfa4-4623-a34f-220c0df9c4d3
using HTTP, JSON

# ╔═╡ 42da8f74-1b44-11ec-32f2-276bdcef1c69
md"""
## 1.1. 你好世界
"""

# ╔═╡ e71aacbb-efff-4b93-b5c4-cbdfa88981ad
md"""
- `command/control + m`: 把当下单元格切换到markdown格式
"""

# ╔═╡ 0660d564-9a26-417d-9a2c-42ef181187c2
with_terminal() do
    println("你好， 世界!")
end

# ╔═╡ 77c5ddd3-ddfc-4a57-ab48-e9db765057d3
with_terminal(() -> println("你好， 世界!"))

# ╔═╡ 8eefb8aa-ae85-4231-abf5-9948cdc92ec1
md"""
`do f() end` 等价于 `（） -> f()`
"""

# ╔═╡ d22fc28f-c591-4db2-8275-54d93fda85e9
f(x) = BigInt(x)^BigInt(x)

# ╔═╡ 4ece5fc8-18d5-408a-851b-31ce58015e72
map(x -> 3x, 1:10)

# ╔═╡ c266f6e2-4e8e-4870-ac38-d4d0e8b9d042
map(1:10) do x
	3x
end

# ╔═╡ 8f3277e9-7905-4beb-9ef1-c3e18b2f449a
map(x -> rand(), 1:10)

# ╔═╡ f6e99ac9-2183-4ea2-991e-f3422b1d1f20
map(__ -> rand(), 1:10)

# ╔═╡ cd0ce1b4-9bc9-4218-95e9-e576abeb1af1
# map(() -> rand(), 1:10) # 不合语法

# ╔═╡ 37fec978-f817-4aa8-85fc-4912eaeb402e
helloArray = ["你好", "👋", "世界"]

# ╔═╡ adc183db-ff23-43de-8cf6-a961d13c2f01
with_terminal() do
	for i ∈ eachindex(helloArray)
		println(helloArray[i])
	end
end

# ╔═╡ 4f1ce95f-2f2f-4817-9d5f-348184a1b800
[i^2 for i in 1:10 for __ in 1:10] # 一维数组

# ╔═╡ dec64158-9161-4b37-b19f-432a5635719e
[i^2 for i in 1:10, __ in 1:10]   # 矩阵

# ╔═╡ 5a401f10-09d2-4939-87fe-621f469a68ee
Square = [i^2 for i in 1:10]

# ╔═╡ c2c7c916-1ba8-4e14-a25b-e15faf676f8a
with_terminal() do
	for i ∈ eachindex(Square)
			println(Square[i])
	end
end

# ╔═╡ 93b0afb2-e9f3-434d-b21a-2ccad6a12d90
[rand() for __ in 1:100]

# ╔═╡ 8bcc15c7-d66a-40cc-9f33-50c6de62fadc
md"""
### 运行速度
"""

# ╔═╡ 428c124a-1052-45c8-a49b-b1047267d644
md"""
- LaTeX Syntax

```math
y = \frac{\displaystyle\sum_{i=1}^\infty}{\epsilon\times\sigma}

```
"""

# ╔═╡ 863624c7-f378-467a-bed2-94182bae73b7
with_terminal() do 
	@time begin
		global data = Float64[]
		for __ in 1:10^6
			group = Float64[]
			for __ in 1:5*10^2
				push!(group, rand())
			end
			push!(data, mean(group))
		end
	end
end

# ╔═╡ 0e8b6a32-ba23-4e37-b78c-8ffb3779a43e
"98%的平均值位于 $(quantile(data, 0.01)) 和 $(quantile(data, 0.99)) 之间。"

# ╔═╡ 9e35d6a1-df94-4a27-9e04-234548495780
with_terminal() do
	@time global data2 = [mean(rand(5 * 10 ^ 2)) for __ in 1 : 10 ^ 6]
end

# ╔═╡ 1b45a9bf-56c7-4b7b-bdd5-b4fcaa572ec0
"98%的平均值位于 $(quantile(data2, 0.01)) 和 $(quantile(data2, 0.99)) 之间。"

# ╔═╡ 60b263eb-f786-40c4-b60b-2daabdacba7b
md"""
### 类型和多重派发
"""

# ╔═╡ b0db7a9c-2498-46c5-bf3c-280d3083ba88
# @edit 1 + 2

# ╔═╡ 412ee0c1-26ad-4b9f-9d6e-c552d8431e76
# @edit 1.0 + 2

# ╔═╡ aa5e313d-19d9-4300-a65e-f547f7e571d0
mutable struct zhan
	dt::Int64
end

# ╔═╡ 0ba25fa7-72cb-4d6e-bfaf-eddcf12b9f9c
x = zhan(4)

# ╔═╡ d5251a23-b71e-4faf-9f5a-f6ab1d2ffb7d
y = zhan(8)

# ╔═╡ b717d872-0d16-4556-a6c8-1ccc3c7b76c3
Base.:+(x::zhan, y::zhan) = x.dt * 100 + y.dt * 200

# ╔═╡ a0322171-cff9-48bb-9f73-792c8ea4798f
function g(x)
	x + 1000
end

# ╔═╡ 3711c338-748f-448e-a06d-d3c29094a14b
map(g, 1:10)

# ╔═╡ f77b7762-29ee-4472-a4ee-a5c1a6dfb369
sqrt.(Square) .+ 100

# ╔═╡ e9d5ee6c-de1a-41ee-850e-a6f5471537ea
@. sqrt(Square) + 100

# ╔═╡ 90fe2c2b-d62d-40b5-9a34-0eb1e9836250
[10 + x for x in 1:100]

# ╔═╡ 72b3ed37-3f3f-4a7d-9036-dadb06c3e1e4
x + y

# ╔═╡ 8c6e966d-9185-4a44-8cd9-e69528cee54b
# methods(+)

# ╔═╡ 1e9be5f5-ab15-4a29-8fd6-d20fee084ad5
abstract type LIKANZHAN <: Signed end #抽象类型

# ╔═╡ 59b884e5-a55a-42f6-9ed4-404d55eae5e9
md"""
## 1.2. 几个例子
"""

# ╔═╡ 3cbd7219-7fb0-4c6e-a2ad-724e97b67d94
function bubbleSort!(a)
	n = length(a)
	for i ∈ 1:n-1
		for j ∈ 1:n-i
			if a[j] > a[j+1]
				a[j], a[j+1] = a[j+1], a[j] # Julian Way
			end
		end
	end
	return a
end

# ╔═╡ 93a86467-cf02-4d3c-b127-79247a588250
data3 = [65, 66, 55, 44, 20, 34, 78, 80]

# ╔═╡ 0423223e-90c5-4d86-8370-66ddee6ba496
with_terminal() do
	@time bubbleSort!(rand(10^5))
end

# ╔═╡ 721c67fd-6d40-4171-89c4-21a1c0064880
with_terminal() do
	@time sort!(rand(10^5))
end

# ╔═╡ 5a4dd40b-d917-4634-a4d4-255c63d68d3f
md"""
- 网络接口和 JSON
"""

# ╔═╡ 20097ff6-c516-454c-978f-4c92e6c72d52
data4 = HTTP.request("GET","https://ocw.mit.edu/ans7870/6/6.006/s08/lecturenotes/files/t8.shakespeare.txt");

# ╔═╡ fbbc0558-7916-4308-b8be-4428f47ca4e5
shakespeare = String(data4)

# ╔═╡ 290d3b7f-ee12-476c-a4f2-189671c84398
# shakespeareWords = split(shakespeare)

# ╔═╡ cc728038-b20f-4b93-97a7-883d5734a0b2
# jsonWords = HTTP.request("GET", "https://raw.githubusercontent.com/"*"h-Klok/StatsWithJuliaBook/master/data/jsonCode.json")

# ╔═╡ 2eca9295-370d-41e9-95a4-b56ee2b0e1dc
"julia" * " is good"

# ╔═╡ b4c5a72d-5ce1-4e21-a04f-8344d1023648
string("Julia", " is Good", ". Python", " is slow.")

# ╔═╡ 4f11cc1a-a78e-4d6c-8bd2-857f85f48aa8
ls = 1:7

# ╔═╡ 50039da8-2c71-4a1d-8cc1-2d4bd8126988
typeof(ls)

# ╔═╡ efb2b80c-af6c-4f6e-bcba-e57c7c39cab3
collect(ls)

# ╔═╡ 1ca893dd-2040-47df-8fa0-c3cb4dd0d7dc
md"""
- 数据存储的常见格式：数组
"""

# ╔═╡ dbbcd955-e0c9-4a6c-81bf-fe5c5ad2f018
md"""
- 数据存储的另外格式： 词典
"""

# ╔═╡ 5565b0a4-792b-40f6-82a2-f8f642432129
dct = Dict("x" => collect(ls), "y" => collect(ls .+ 1) )

# ╔═╡ 6d4175a4-af6e-4a08-bcd2-0b1966ae9035
getindex(dct, "x")

# ╔═╡ c4a58e43-2ea8-48fa-a99d-09f83b1b8ba8
md"""
- 数据存储的另外格式： 元组
"""

# ╔═╡ e0e5ef4a-fc35-4d9b-9a34-a9439d87051d
vec = [1, 2, 3]; typeof(vec)

# ╔═╡ c9d041cb-6a29-449a-8909-b529e8c562a6
yz = (1, 2, 4); typeof(yz)

# ╔═╡ c77241fb-bd9e-4270-bd04-e8b5bcb2406b
md"""
## 1.3. 做图初步
"""

# ╔═╡ 87296377-fe6d-4225-b114-a8c3b8bea1bc
with_terminal() do
	Pkg.status()
end

# ╔═╡ aa61efe4-b3a2-4379-a748-f37cd7f9c6fb
f(x, y) = x^2 + y^2

# ╔═╡ 9d9f4d96-7755-4fd1-851a-092929ad1ac7
f(6)

# ╔═╡ 8b0db1dd-5d79-42e5-9763-ca4ef7259060
map(f, 1:10)

# ╔═╡ 182ab07b-a3e6-47f0-8de5-d59113027c43
f0(x) = f(x, 0)

# ╔═╡ 6262451f-4dcf-4f84-8be6-2f8fbf2631bd
f2(x) = f(x, 2)

# ╔═╡ 3d664567-d879-41f7-9e1a-cdfc08e4e7c9
xVals, yVals = -5:0.1:5, -5:0.1:5

# ╔═╡ 5e03a17e-861e-4749-b18e-00e293d24f28
plot([f0, f2], xVals) # command + /

# ╔═╡ 4d5c7119-f2bf-44ed-bc20-5597a795fbcd
plot(xVals, [f0.(xVals), f2.(xVals)],
	color = [:blue :green],
	xlims = (-6, 6),
	ylims = (-5, 30),
	xlabel = "Range of X",
	ylabel = L"f(x, \cdot)",
	label = [L"f(x, 0)" L"f(x, 2)"],
	legends = :bottomleft
)

# ╔═╡ af2e86c1-4c58-4577-9ae9-313f8ae78475
p1 = annotate!(0, -0.2, text("(0, 0) the mainimum \n of f(x, 0)", :left, :top, 10))

# ╔═╡ 9461292e-3658-41e2-8349-45790fa7c9e0
z = [f(x, y) for y in yVals, x in xVals];

# ╔═╡ 7e03b8d1-1ddb-435f-b9ba-b72b0c44da18
p2 = surface(xVals, yVals, z,
	color = cgrad([:blue, :red]),
	legend = :none,
	ylabel = "y",
	zlabel = L"f(x, y)"
)

# ╔═╡ e54420c1-1ff3-4f38-b9b8-0e3a18127c9a
M = z[1:10, 1:10];

# ╔═╡ 458dfaeb-0370-4e61-90a2-f5b54a0fab42
p3 = heatmap(M, 
	color = cgrad([:blue, :red]),
	ylabel = "y",
	xticks = ([1:10; ], xVals),
	yticks = ([1:10; ], yVals)
)

# ╔═╡ b7729c93-781a-46ec-b057-65c4e9e15a04
plot(p1, p2, p3, layout = (1, 3), size = (1200, 400), xlabel = "x", margin = 5mm)

# ╔═╡ 543de112-675c-4368-957d-f37647ad85bd
 L"\frac{\delta}{\gamma\times \cdots}"

# ╔═╡ 37f6486e-e03c-4ddb-bca6-d13157d69822
plot([f0, f2], 1:0.5:10, 
	seriestype = [:scatter, :line], 
	markersize = 6,
	linewidth = 3, linecolor = :green, 
	legend = false)

# ╔═╡ 68d89124-d6e9-4609-b12a-d3b508733680
# surface() # 等价于 plot(.., seriestype = :surface,...,)

# ╔═╡ 6003cd52-89ea-4d93-ac00-43ca395357b8
md"""
### 1.3.1 希尔顿序列
"""

# ╔═╡ 92c42555-8550-4c1b-9b1a-502813c40237
md"""
- 条件句
"""

# ╔═╡ 5c3f1925-ebfb-4bef-8425-635262927bf1
function ff1(x)
	if x % 3 == 0
		return "$x 除以 3 的余数是 0"
	elseif x % 3 == 1
		return "$x 除以 3 的余数是 1"
	else
		return "$x 除以 3 的余数是 2"
	end
end

# ╔═╡ ec02b4a7-529b-4d37-ba4b-bf146a33ee0f
[ff1(x) for x in 1:5]

# ╔═╡ 954f166b-e8db-4cf7-a0a2-75ab3b3acbe0
function ff2(x)
	if x % 3 == 0
		return "x 除3的余数是 0"
	end
end

# ╔═╡ e97dcedb-4b53-4ce8-a0e9-ed20b77d8b2d
[ff2(x) for x in 1:5]

# ╔═╡ f662c9f4-8004-43d6-ad1e-872ad3d24e48
md"""
- 类型稳定性： 除号可能会改变数据的类型
"""

# ╔═╡ c72335d5-39e3-4ab9-a398-e3960dcafe0c
xd = Int(2)

# ╔═╡ 8ebae10c-3148-43fe-9b14-f07934c3b2ea
typeof(xd)

# ╔═╡ e49a1426-bcf5-453a-8753-2bb8387e67eb
yd = xd/2

# ╔═╡ 46bd26e6-c1bf-4fa3-890a-2d424865c2dc
typeof(yd)

# ╔═╡ 55e79482-e30e-4eea-b083-cac2a9667348
md"""
- 希尔顿序列
"""

# ╔═╡ 9537df9b-7fc8-4b32-bc7c-d8ee8730d73a
function hailLength1(x::Int)
	n = 0
	while x != 1
		if x % 2 == 0
			x = Int(x / 2)
		else
			x = 3x + 1
		end
		n += 1 # 等价于 n = n + 1, *=, /= 
	end
	return n
end

# ╔═╡ 6434a9f1-aa8a-491f-ac7e-c58b3a4b2638
function hailLength(x::Int)
	n = 0
	while x != 1
		x = x % 2 == 0 ? Int(x / 2) : 3x + 1
		n += 1
	end
	return n
end

# ╔═╡ 4abd57c6-1a0c-4e7c-a195-d07ddc299b2c
md"""
注意： `condition ? res1 : res2` 等价于 `if condition res1 else res2`
"""

# ╔═╡ aa2c895f-7219-4b98-bf50-c96d676ead09
x2 = 13

# ╔═╡ 5fb204e1-d150-4a3c-ac19-6fa5b67b072b
if x2 % 2 == 1 "奇数" else "偶数" end

# ╔═╡ c0df29b8-368d-40d1-bad0-73493531903a
lengths = [hailLength(x0) for x0 in 2:10^7];

# ╔═╡ 51046c66-6e14-420e-8a5e-5a58580841a6
# histogram(lengths)

# ╔═╡ 3659f664-3fc3-48bd-94e3-f57ae84e7301
plot(lengths, seriestype = :histogram,
	bins = 1000,
	# fill = (:green, true) # 元组
	fill = true, color = :green,
	normed = true, legend = false,
	linealpha = 0.2
)

# ╔═╡ 9392cdfb-ceef-40ac-a67b-8c7ca33de123
md"""
### 1.3.2 动图
"""

# ╔═╡ 20605ee6-f245-4e77-b014-a8e42a520e8d
n = 10

# ╔═╡ c69f8278-9627-458b-8204-91ae08efbf92
points = [exp(2 * pi * im * k / n) for k in 1:n];

# ╔═╡ a5f4d797-db11-4d6a-8906-b4af6804a936
plot(points, seriestype = :scatter, legend = false);

# ╔═╡ 46f62dad-820b-42d3-8cdd-ab02cacabc47
xPts, yPts = real.(points), imag.(points);

# ╔═╡ 758082fe-038e-4090-b658-111db3ee1f13
edges  = [(v, u) for v in 1:n for u in (v+1):n];

# ╔═╡ 931e4862-c109-4b17-9048-7826f3dd0c6f
animate = Animation();

# ╔═╡ 3017c6db-acee-422d-bb97-692495972631
plot(xPts, yPts, seriestype = :scatter, legend = false) # 等价于 scatter(xPts, yPts)

# ╔═╡ 404716dd-7a05-4f3b-b336-cab7fc679ed1
for i in eachindex(edges)
	u, v = edges[i][1], edges[i][2]
	xpoints = [xPts[u], xPts[v]]
	ypoints = [yPts[u], yPts[v]]
	plot!(xpoints, ypoints, line = :red, legend = false)
	frame(animate)
end

# ╔═╡ 43b3b163-05a7-4c06-a948-bf5c001b7af0
gif(animate)

# ╔═╡ 4c0169d7-b280-4326-aa79-9c979280077a
md"""
## 1.4. 随机数
"""

# ╔═╡ 694d2ceb-233f-49ea-9416-9e8a8f272d38
md"""
## 1.6. 嵌入其他语言
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
AbstractTrees = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"
JSON = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Measures = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
Pkg = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[compat]
AbstractTrees = "~0.3.4"
HTTP = "~0.9.17"
JSON = "~0.21.3"
LaTeXStrings = "~1.3.0"
Measures = "~0.3.1"
Plots = "~1.25.9"
PlutoUI = "~0.7.34"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.2"
manifest_format = "2.0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.AbstractTrees]]
git-tree-sha1 = "03e0550477d86222521d254b741d470ba17ea0b5"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.3.4"

[[deps.Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "af92965fb30777147966f58acb05da51c5616b5f"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.3.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "f9982ef575e19b0e5c7a98c6e75ee496c0f73a93"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.12.0"

[[deps.ChangesOfVariables]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "bf98fa45a0a4cee295de98d4c1462be26345b9a1"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.2"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "Colors", "FixedPointNumbers", "Random"]
git-tree-sha1 = "12fc73e5e0af68ad3137b886e3f7c1eacfca2640"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.17.1"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[deps.Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "44c37b4636bc54afac5c574d2d02b625349d6582"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.41.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Contour]]
deps = ["StaticArrays"]
git-tree-sha1 = "9f02045d934dc030edad45944ea80dbd1f0ebea7"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.5.7"

[[deps.DataAPI]]
git-tree-sha1 = "cc70b17275652eb47bc9e5f81635981f13cea5c8"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.9.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "3daef5523dd2e769dad2365274f760ff5f282c7d"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.11"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "b19534d1895d702889b219c382a6e18010797f0b"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.6"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3f3a2501fa7236e9b911e0f7a588c657e822bb6d"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.2.3+0"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ae13fcbc7ab8f16b0856729b050ef0c446aa3492"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.4.4+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "Pkg", "Zlib_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "d8a578692e3077ac998b50c0217dfd67f21d1e5f"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.0+0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "87eb71354d8ec1a96d4a7636bd57a7347dde3ef9"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.4+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "51d2dfe8e590fbd74e7a842cf6d13d8a2f45dc01"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.6+0"

[[deps.GR]]
deps = ["Base64", "DelimitedFiles", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Printf", "Random", "RelocatableFolders", "Serialization", "Sockets", "Test", "UUIDs"]
git-tree-sha1 = "4a740db447aae0fbeb3ee730de1afbb14ac798a1"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.63.1"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Pkg", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "aa22e1ee9e722f1da183eb33370df4c1aeb6c2cd"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.63.1+0"

[[deps.GeometryBasics]]
deps = ["EarCut_jll", "IterTools", "LinearAlgebra", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "58bcdf5ebc057b085e58d95c138725628dd7453c"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.4.1"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "a32d672ac2c967f3deb8a81d828afc739c838a06"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.68.3+2"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "0fa77022fe4b511826b39c894c90daf5fce3334a"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.17"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
git-tree-sha1 = "2b078b5a615c6c0396c77810d92ee8c6f470d238"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.3"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.IniFile]]
deps = ["Test"]
git-tree-sha1 = "098e4d2c533924c921f9f9847274f2ad89e018b8"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "a7254c0acd8e62f1ac75ad24d5db43f5f19f3c65"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.2"

[[deps.IrrationalConstants]]
git-tree-sha1 = "7fd44fd4ff43fc60815f8e764c0f352b83c49151"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.1"

[[deps.IterTools]]
git-tree-sha1 = "fa6287a4469f5e048d763df38279ee729fbd44e5"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.4.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b53380851c6e6664204efb2e62cd24fa5c47e4ba"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.2+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "Printf", "Requires"]
git-tree-sha1 = "a8f4f279b6fa3c3c4f1adadd78a621b13a506bce"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.9"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "7739f837d6447403596a75d19ed01fd08d6f56bf"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.3.0+3"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "42b62845d70a619f063a7da093d995ec8e15e778"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+1"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "340e257aada13f95f98ee352d316c3bed37c8ab9"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.3.0+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "e5718a00af0ab9756305a0392832c8952c7426c1"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.6"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "3d3e902b31198a27340d0bf00d6ac452866021cf"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.9"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "Random", "Sockets"]
git-tree-sha1 = "1c38e51c3d08ef2278062ebceade0e46cefc96fe"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.0.3"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Measures]]
git-tree-sha1 = "e498ddeee6f9fdb4551ce855a46f54dbd900245f"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.1"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NaNMath]]
git-tree-sha1 = "b086b7ea07f8e38cf122f5016af580881ac914fe"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "0.3.7"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "648107615c15d4e09f7eca16307bc821c1f718d8"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.13+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.PCRE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b2a7af664e098055a7529ad1a900ded962bca488"
uuid = "2f80f16e-611a-54ab-bc61-aa92de5b98fc"
version = "8.44.0+0"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "13468f237353112a01b2d6b32f3d0f80219944aa"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.2.2"

[[deps.Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Requires", "Statistics"]
git-tree-sha1 = "a3a964ce9dc7898193536002a6dd892b1b5a6f1d"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "2.0.1"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "6f1b25e8ea06279b5689263cc538f51331d7ca17"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.1.3"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "GeometryBasics", "JSON", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "PlotThemes", "PlotUtils", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "1d0a11654dbde41dc437d6733b68ce4b28fbe866"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.25.9"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "8979e9802b4ac3d58c503a20f2824ad67f9074dd"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.34"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "2cf929d64681236a2e074ffafb8d568733d2e6af"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "ad368663a5e20dbb8d6dc2fddeefe4dae0781ae8"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+0"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RecipesBase]]
git-tree-sha1 = "6bf3f380ff52ce0832ddd3a2a7b9538ed1bcca7d"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.2.1"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "RecipesBase"]
git-tree-sha1 = "37c1631cb3cc36a535105e6d5557864c82cd8c2b"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.5.0"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "cdbd3b1338c72ce29d9584fdbe9e9b70eeb5adca"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "0.1.3"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "0b4b7f1393cff97c33891da2a0bf69c6ed241fda"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.1.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "a635a9333989a094bddc9f940c04c549cd66afcf"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.3.4"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StatsAPI]]
git-tree-sha1 = "d88665adc9bcf45903013af0982e2fd05ae3d0a6"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.2.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "118e8411d506d583fbbcf4f3a0e3c5a9e83370b8"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.15"

[[deps.StructArrays]]
deps = ["Adapt", "DataAPI", "StaticArrays", "Tables"]
git-tree-sha1 = "d21f2c564b21a202f4677c0fba5b5ee431058544"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.4"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "TableTraits", "Test"]
git-tree-sha1 = "bb1064c9a84c52e277f1096cf41434b675cd368b"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.6.1"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.URIs]]
git-tree-sha1 = "97bbe755a53fe859669cd907f2d96aee8d2c1355"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.3.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unzip]]
git-tree-sha1 = "34db80951901073501137bdbc3d5a8e7bbd06670"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.1.2"

[[deps.Wayland_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "3e61f0b86f90dacb0bc0e73a0c5a83f6a8636e23"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.19.0+0"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "66d72dc6fcc86352f01676e8f0f698562e60510f"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.23.0+0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "1acf5bdf07aa0907e0a37d3718bb88d4b687b74a"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.9.12+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "5be649d550f3f4b95308bf0183b82e2582876527"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.6.9+4"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4e490d5c960c314f33885790ed410ff3a94ce67e"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.9+4"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fe47bd2247248125c428978740e18a681372dd4"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.3+4"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6783737e45d3c59a4a4c4091f5f88cdcf0908cbb"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.0+3"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "daf17f441228e7a3833846cd048892861cff16d6"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.13.0+3"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "926af861744212db0eb001d9e40b5d16292080b2"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.0+4"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "4bcbf660f6c2e714f87e960a171b119d06ee163b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.2+4"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "5c8424f8a67c3f2209646d4425f3d415fee5931d"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.27.0+4"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "79c31e7844f6ecf779705fbc12146eb190b7d845"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.4.0+3"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e45044cd873ded54b6a5bac0eb5c971392cf1927"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.2+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "ece2350174195bb31de1a63bea3a41ae1aa593b6"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "0.9.1+5"
"""

# ╔═╡ Cell order:
# ╠═6dd76507-be07-4c3a-9747-99eca74d3519
# ╟─42da8f74-1b44-11ec-32f2-276bdcef1c69
# ╟─e71aacbb-efff-4b93-b5c4-cbdfa88981ad
# ╠═0660d564-9a26-417d-9a2c-42ef181187c2
# ╠═77c5ddd3-ddfc-4a57-ab48-e9db765057d3
# ╟─8eefb8aa-ae85-4231-abf5-9948cdc92ec1
# ╠═d22fc28f-c591-4db2-8275-54d93fda85e9
# ╠═9d9f4d96-7755-4fd1-851a-092929ad1ac7
# ╠═4ece5fc8-18d5-408a-851b-31ce58015e72
# ╠═8b0db1dd-5d79-42e5-9763-ca4ef7259060
# ╠═a0322171-cff9-48bb-9f73-792c8ea4798f
# ╠═3711c338-748f-448e-a06d-d3c29094a14b
# ╠═c266f6e2-4e8e-4870-ac38-d4d0e8b9d042
# ╠═8f3277e9-7905-4beb-9ef1-c3e18b2f449a
# ╠═f6e99ac9-2183-4ea2-991e-f3422b1d1f20
# ╠═cd0ce1b4-9bc9-4218-95e9-e576abeb1af1
# ╠═37fec978-f817-4aa8-85fc-4912eaeb402e
# ╠═adc183db-ff23-43de-8cf6-a961d13c2f01
# ╠═4f1ce95f-2f2f-4817-9d5f-348184a1b800
# ╠═dec64158-9161-4b37-b19f-432a5635719e
# ╠═5a401f10-09d2-4939-87fe-621f469a68ee
# ╠═c2c7c916-1ba8-4e14-a25b-e15faf676f8a
# ╠═2fdb3281-7229-4f18-b9d9-bc5e3086d903
# ╠═f77b7762-29ee-4472-a4ee-a5c1a6dfb369
# ╠═e9d5ee6c-de1a-41ee-850e-a6f5471537ea
# ╠═93b0afb2-e9f3-434d-b21a-2ccad6a12d90
# ╠═90fe2c2b-d62d-40b5-9a34-0eb1e9836250
# ╟─8bcc15c7-d66a-40cc-9f33-50c6de62fadc
# ╠═428c124a-1052-45c8-a49b-b1047267d644
# ╠═863624c7-f378-467a-bed2-94182bae73b7
# ╠═0e8b6a32-ba23-4e37-b78c-8ffb3779a43e
# ╠═9e35d6a1-df94-4a27-9e04-234548495780
# ╠═1b45a9bf-56c7-4b7b-bdd5-b4fcaa572ec0
# ╟─60b263eb-f786-40c4-b60b-2daabdacba7b
# ╠═b0db7a9c-2498-46c5-bf3c-280d3083ba88
# ╠═412ee0c1-26ad-4b9f-9d6e-c552d8431e76
# ╠═aa5e313d-19d9-4300-a65e-f547f7e571d0
# ╠═0ba25fa7-72cb-4d6e-bfaf-eddcf12b9f9c
# ╠═d5251a23-b71e-4faf-9f5a-f6ab1d2ffb7d
# ╠═b717d872-0d16-4556-a6c8-1ccc3c7b76c3
# ╠═72b3ed37-3f3f-4a7d-9036-dadb06c3e1e4
# ╠═8c6e966d-9185-4a44-8cd9-e69528cee54b
# ╠═1e9be5f5-ab15-4a29-8fd6-d20fee084ad5
# ╠═3baed4bd-1c0c-4d44-b7ab-f7c0627fda1b
# ╟─59b884e5-a55a-42f6-9ed4-404d55eae5e9
# ╠═3cbd7219-7fb0-4c6e-a2ad-724e97b67d94
# ╠═93a86467-cf02-4d3c-b127-79247a588250
# ╠═0423223e-90c5-4d86-8370-66ddee6ba496
# ╠═721c67fd-6d40-4171-89c4-21a1c0064880
# ╠═5a4dd40b-d917-4634-a4d4-255c63d68d3f
# ╠═2edcc72c-bfa4-4623-a34f-220c0df9c4d3
# ╠═20097ff6-c516-454c-978f-4c92e6c72d52
# ╠═fbbc0558-7916-4308-b8be-4428f47ca4e5
# ╠═290d3b7f-ee12-476c-a4f2-189671c84398
# ╠═cc728038-b20f-4b93-97a7-883d5734a0b2
# ╠═2eca9295-370d-41e9-95a4-b56ee2b0e1dc
# ╠═b4c5a72d-5ce1-4e21-a04f-8344d1023648
# ╠═4f11cc1a-a78e-4d6c-8bd2-857f85f48aa8
# ╠═50039da8-2c71-4a1d-8cc1-2d4bd8126988
# ╠═efb2b80c-af6c-4f6e-bcba-e57c7c39cab3
# ╟─1ca893dd-2040-47df-8fa0-c3cb4dd0d7dc
# ╟─dbbcd955-e0c9-4a6c-81bf-fe5c5ad2f018
# ╠═5565b0a4-792b-40f6-82a2-f8f642432129
# ╠═6d4175a4-af6e-4a08-bcd2-0b1966ae9035
# ╟─c4a58e43-2ea8-48fa-a99d-09f83b1b8ba8
# ╠═e0e5ef4a-fc35-4d9b-9a34-a9439d87051d
# ╠═c9d041cb-6a29-449a-8909-b529e8c562a6
# ╟─c77241fb-bd9e-4270-bd04-e8b5bcb2406b
# ╠═f924796f-52f3-4b4b-aa47-61a179874647
# ╠═87296377-fe6d-4225-b114-a8c3b8bea1bc
# ╠═aa61efe4-b3a2-4379-a748-f37cd7f9c6fb
# ╠═182ab07b-a3e6-47f0-8de5-d59113027c43
# ╠═6262451f-4dcf-4f84-8be6-2f8fbf2631bd
# ╠═3d664567-d879-41f7-9e1a-cdfc08e4e7c9
# ╠═5e03a17e-861e-4749-b18e-00e293d24f28
# ╠═4d5c7119-f2bf-44ed-bc20-5597a795fbcd
# ╠═af2e86c1-4c58-4577-9ae9-313f8ae78475
# ╠═9461292e-3658-41e2-8349-45790fa7c9e0
# ╠═7e03b8d1-1ddb-435f-b9ba-b72b0c44da18
# ╠═e54420c1-1ff3-4f38-b9b8-0e3a18127c9a
# ╠═458dfaeb-0370-4e61-90a2-f5b54a0fab42
# ╠═b7729c93-781a-46ec-b057-65c4e9e15a04
# ╠═543de112-675c-4368-957d-f37647ad85bd
# ╠═37f6486e-e03c-4ddb-bca6-d13157d69822
# ╠═68d89124-d6e9-4609-b12a-d3b508733680
# ╟─6003cd52-89ea-4d93-ac00-43ca395357b8
# ╟─92c42555-8550-4c1b-9b1a-502813c40237
# ╠═5c3f1925-ebfb-4bef-8425-635262927bf1
# ╠═ec02b4a7-529b-4d37-ba4b-bf146a33ee0f
# ╠═954f166b-e8db-4cf7-a0a2-75ab3b3acbe0
# ╠═e97dcedb-4b53-4ce8-a0e9-ed20b77d8b2d
# ╟─f662c9f4-8004-43d6-ad1e-872ad3d24e48
# ╠═c72335d5-39e3-4ab9-a398-e3960dcafe0c
# ╠═8ebae10c-3148-43fe-9b14-f07934c3b2ea
# ╠═e49a1426-bcf5-453a-8753-2bb8387e67eb
# ╠═46bd26e6-c1bf-4fa3-890a-2d424865c2dc
# ╟─55e79482-e30e-4eea-b083-cac2a9667348
# ╠═9537df9b-7fc8-4b32-bc7c-d8ee8730d73a
# ╠═6434a9f1-aa8a-491f-ac7e-c58b3a4b2638
# ╠═4abd57c6-1a0c-4e7c-a195-d07ddc299b2c
# ╠═aa2c895f-7219-4b98-bf50-c96d676ead09
# ╠═5fb204e1-d150-4a3c-ac19-6fa5b67b072b
# ╠═c0df29b8-368d-40d1-bad0-73493531903a
# ╠═51046c66-6e14-420e-8a5e-5a58580841a6
# ╠═3659f664-3fc3-48bd-94e3-f57ae84e7301
# ╟─9392cdfb-ceef-40ac-a67b-8c7ca33de123
# ╠═20605ee6-f245-4e77-b014-a8e42a520e8d
# ╠═c69f8278-9627-458b-8204-91ae08efbf92
# ╠═a5f4d797-db11-4d6a-8906-b4af6804a936
# ╠═46f62dad-820b-42d3-8cdd-ab02cacabc47
# ╠═758082fe-038e-4090-b658-111db3ee1f13
# ╠═931e4862-c109-4b17-9048-7826f3dd0c6f
# ╠═3017c6db-acee-422d-bb97-692495972631
# ╠═404716dd-7a05-4f3b-b336-cab7fc679ed1
# ╠═43b3b163-05a7-4c06-a948-bf5c001b7af0
# ╠═4c0169d7-b280-4326-aa79-9c979280077a
# ╟─694d2ceb-233f-49ea-9416-9e8a8f272d38
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
