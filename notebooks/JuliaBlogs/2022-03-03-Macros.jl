### A Pluto.jl notebook ###
# v0.18.4

using Markdown
using InteractiveUtils

# ╔═╡ eb30c73f-4f60-4fc4-8166-1da11585e628
using PlutoUI

# ╔═╡ c5bec4ad-8955-422a-bad3-4968d4d39c0c
TableOfContents(title = "目录", aside = false)

# ╔═╡ 7d53a8fa-fd00-4503-93b1-0dae05578700
md"""
### 什么是宏
"""

# ╔═╡ 4d7165a9-c781-40e2-bd42-82df2be034a2
md"""
宏在内核上是一个函数： （1） 其参数是一段或多段引用代码 （`quoted code`）， （2） 其返回值也是一段引用代码。 （3） 宏函数仅在编译阶段被唯一运行一次。 运行结束后， 宏中的引用代码将在原位置被替换为调用代码。 该替换将不会保留任何宏存在过的痕迹。 （注意： 在极特殊情况下， 有些代码是只有借助宏才能产生。）

宏导致的困难大多与上面三个问题有关。 下面是两个极易被混淆的问题： (1) 宏在执行前其参数如何被引用； （2） 宏执行后产生的引用代码如何被后期处理， 以避免其与本地变量可能产生的矛盾。
"""

# ╔═╡ 858936b7-5ac7-42c0-8aa9-df1cbfe9d1f6
md"""
### 代码引用产生很多类型
"""

# ╔═╡ 8c57aa1f-5c18-4292-b62c-f4909d1d4818
md"""
宏的内核是以引用代码为输入参数的函数， 所以明白代码引用在 Julia 的工作机制很重要。 由于下面两个原因， Julia 的引用机制稍显混乱： （1） 代码引用可以产生包括 `Expr` 类在内的很多数据类型。 所以宏的参数并不总是 `Expr` 类的实例； （2） 输入到宏参数的引用和存在于宏之外的引用有不同的引用机制。 

Julia 中 `:( )` 和 `quote` 都可被用作代码引用， 例如： 
"""

# ╔═╡ 67aa4a88-46b6-4a5f-af89-3f72a977c8cb
dt = [:(1), :(:x), :(x), :(1 + x),
	  quote 1 end, quote 1 + x end, quote 1 + x; x + 1 end];

# ╔═╡ 3958f679-6c86-4731-a6e9-9ac597326f44
[typeof.(dt) dt]

# ╔═╡ ba2ec22d-d255-4bc7-8cc3-d090f00da1fc
md"""
虽然前面的例子都可看作代码引用， 但是只有 `:(1 + x)` 和 `quote` 包裹的模块产生的实例类型为 `Expr`。 与其他语言不同， **Julia 语言没有把所有代码引用值包裹为某种类型的 `Expr`， 所以 Julia 中宏的参数必须具备处理非 `Expr` 类型输入的能力。**
"""

# ╔═╡ ef39222a-0c18-4eae-b883-88eff1015077
md"""
### 类型 `Expr` 有复杂的结构
"""

# ╔═╡ 1275c1f6-2c09-4c39-b253-dd857128ef27
md"""
与 `Lisp` 不同， Julia 复杂的句法系统使得 Julia 能够产生很多不同的 `Expr` 对象， 你需要一些策略来掌握这种复杂性。 来看一些例子：
"""

# ╔═╡ 9f26dc3f-509f-451c-b0ef-b70aee06bfc0
with_terminal(dump, 
	:(1 + x)
)

# ╔═╡ 898c0633-f722-4c84-b568-06795c047e6a
with_terminal(dump, 
	:( sin(x) ) 
) 

# ╔═╡ f4091b2c-24c1-423d-af18-16cee421c552
with_terminal(dump, 
	:( x == y )
)

# ╔═╡ bc81576d-b1a0-4060-8487-a13da3c8bc42
with_terminal(dump, 
    begin
		y = 1
		y + 1
	end
)

# ╔═╡ eef769c8-e69d-4e0a-a95e-01fc9eb76205
with_terminal(dump, 
    :(2)
)

# ╔═╡ 60dce293-35c3-4a31-a6f8-1bcaae2ff644
with_terminal(dump, 
    quote
		2
    end
)

# ╔═╡ af589ba9-02e0-4334-8b3c-c9fec4d4635f
with_terminal(dump, 
    quote
        let x = 1
            x + 1
        end
    end
)

# ╔═╡ 6ddfc2f8-167f-4236-8095-990b0136285e
md"""
后面两个例子显示， 由 `quote` 包裹的引用代码除去包含了指向实际代码的 `Expr` 对象之外， 还包含了类型为 `LineNumberNode` 的对象表示该代码所处的位置。 `LineNumberNode` 在错误报告时非常重要， 但通常会形成干扰。 此时你可以用 `MacroTools.jl` 中的 `rmlines` 删除这些对象， 但该函数无法递归性的删除这些对象。 例如：
"""

# ╔═╡ ad714b6b-5f1a-4027-962c-dcd5d43a98ed
import MacroTools: rmlines

# ╔═╡ 3dd1474b-43d0-4aab-b27e-2256a0fe3156
with_terminal(dump, 
	rmlines(
	quote
		let x = 1
			x + 1
		end
	end
	)
)

# ╔═╡ 6eda4169-a034-42a9-a15b-4157421e7cba
md"""
对 `Expr` 对象能实现为什么类型有一个基本的了解对于掌握宏非常重要。 这个 [gist](https://gist.githubusercontent.com/johnmyleswhite/17d8e897e995874ce04f2fc102b59991/raw/be9e40f1014c0871e09a5fc9c044395fab62ddea/expr_kinds.txt) 列出了 jialia 基础包中 `Expr` 的类型及相对频率。 Julia 编译器中的 [ast.scm](https://github.com/JuliaLang/a/blob/a645d7f256c2d1634869fa927c90d4e282见ff0a47/src/ast.scm#L75) 穷尽式的给出了编译器能理解的所有可能类型。
"""

# ╔═╡ 23298a41-8f64-490d-ac4c-22691ad75038
md"""
除了执行一些引用代码并查看其结果外， 自己手动建构一些表达式也很有意义， 例如
"""

# ╔═╡ 8362af9b-534f-429a-9f7c-c79eef64840d
:(x - y) == Expr(:call, :-, :x, :y)

# ╔═╡ dd8be7b8-a8b8-4629-97f3-3748e79761fa
:(sin(x)) == Expr(:call, :sin, :x)

# ╔═╡ b6e13d5e-7937-4918-a44d-fdf24e39785b
:(1 + sin(x)) == Expr(:call, :+, 1, Expr(:call, :sin, :x))

# ╔═╡ 0a6cddb7-3888-4c3e-9323-e5eab5301479
md"""
- **练习**
"""

# ╔═╡ f73a3a81-4439-4ba2-84f4-b060754cee0c
# 1. 一个 for loop
fl = 
Expr(
	:for,
	Expr(
		:(=),
		:i,
		Expr(
			:call,
			:(:),
			1,
			2
		)
	),
	Expr(
		:call,
		:println,
		Expr(
			:call,
			:(*),
			:i,
			3	
		)
	)
)

# ╔═╡ 18ebacb7-6b6e-4347-b175-aa9b7c98f93e
with_terminal() do
	eval(fl)
end

# ╔═╡ cf7d932f-9b22-44de-a178-73b5327964fd
# 2. 一个条件表达式
iff = 
Expr(
	:if,
	Expr(
		:call,
		:(<=),
		:z,
		5
	),
	Expr(
		:call,
		:(+),
		:z,
		100
	),
	Expr(
		:elseif,
		Expr(
			:call,
			:(<=),
			:z,
			10
		),
		Expr(
			:call,
			:(+),
			:z,
			200
		),
		Expr(
			:call,
			:(+),
			:z,
			300
		)
	)
)

# ╔═╡ 0be7d504-32d1-43f5-92b5-0980487abb1a
begin
	z = 0
	eval(iff)
end

# ╔═╡ daa034c0-92bd-47de-8377-de9b2c6403d3
# 3. 定义一个匿名函数： x -> x + 1
fun = 
Expr(
	:(->),
	:x,
	Expr(
		:call,
		:(+),
		:x,
		1
	)
)

# ╔═╡ 620b63c4-f43b-4026-a787-63900dea046f
eval(fun)(4)

# ╔═╡ 80d488fa-8588-486a-b9ec-26544d2449bc
md"""
### 引用和伪引用
"""

# ╔═╡ 268e84f3-bd32-4e9d-9d65-ee72a5d3d00c
md"""
前面提到， Julia 内置的引用系统 （`:( )` 和 `quote`）和宏对其参数的引用机制是不同的。 前者执行的是伪引用 （[quasiquotation](https://courses.cs.washington.edu/courses/cse341/04wi/lectures/14-scheme-quote.html)）， 而后者执行的则是真引用。 二者的区别在于对插入（[interpolation](https://docs.julialang.org/en/v1/manual/metaprogramming/#man-expression-interpolation-1)）的处理。 在伪引用中， 美元符号 `$` 可被用于引用表达式内插入值。 而在真引用中， 美元符号只是被调用而不会执行插入操作。 例如：
"""

# ╔═╡ ed3ea5e5-7aaa-4738-8cb3-31015308812f
x = 2

# ╔═╡ 5fad2af8-e8b6-4eff-99a0-04c5080f044b
:(1 + x), 
:(1 + $x)

# ╔═╡ 4e17c358-6788-4b98-a650-70f785698fb3
let y = :x
	:(1 + y), 
	:(1 + $y) 
end

# ╔═╡ 85115360-f7f2-4d4f-b493-5ccc4c19122f
md"""
与 `:()` 执行的伪引用不同， 当真引用中出现美元符号 `$` 时， 并会不执行差值过程， 而是会捕获相关描述插值过程的句法， 例如：
"""

# ╔═╡ 8919b66e-4f3e-474b-8a9e-8d1afa7ab757
(
:(1 + $x),                       # 伪引用
Expr(:call, :+, 1, Expr(:$, :x)) # 真引用
)

# ╔═╡ add73323-a15d-4b57-b9a8-d7b30428e3df
md"""
但是 Julia 并没有内置的句法以执行真引用操作， 这也就是我们直接用 `Expr` 来手动建构真引用的原因。 但是我们可以通过宏来执行真引用。 在写这个宏之前， 当对象处于真引用状态时， 该对象的存储类型为 `QuoteNode`。 例如：
"""

# ╔═╡ d45e0165-141b-4aaa-8399-0a38e8f2247e
let qn = [:x, :(:x)]; [qn typeof.(qn)] end

# ╔═╡ 8b102cba-3d07-408c-be44-f1b96d8b68ca
md"""
把一个符号 `Symbol` 包裹在 `QuoteNode` 之内咋看起来没有什么作用。 但当把该包裹结构放在宏之内时， 作用就体现出来了： 当包裹结构 `QuoteNode` 位于宏之内时， 说明包裹之内的代码在宏被执行完毕后依然会保持着引用状态。 看下面的例子：
"""

# ╔═╡ 8802e2e4-11ea-48d8-929b-145944f4c4d8
macro true_quote(e)
	QuoteNode(e)
end

# ╔═╡ c27aafb7-b211-4a6e-b013-01a98bb57a54
let y = :x
	(
	@true_quote(1 + $y),
	:(1 + $y)
	)
end

# ╔═╡ 18c148cb-4570-4d78-bcfa-931948aa869e
md"""
Julia 在对宏本体求值之前对其参数进行的是真引用而非伪引用。 其原因在于， 从底层看插入和拼接是位于运行阶段的概念， 用于捕获运行阶段数值。

此特征的一个重要后果是**宏无法执行标准的插值和拼接操作**。 如果你需要在宏中执行插值和拼接操作， 你需要在宏内部进行插值模拟。 例如， `BenchmarkTools.jl` 中的宏 `@btime` 具实用了[模拟操作](https://discourse.julialang.org/t/interpolation-in-macro-calls/25530)。 你可以试着阅读一下 [BenchmarkTools.jl](https://github.com/JuliaCI/BenchmarkTools.jl) 的底层代码， 以查看该包是如何利用拼接算子的句法来捕获本地变量而不影响测试结果的。

从另一方面来讲， 宏执行的是真引用而非伪引用也就意味着你能给插入和拼接算子赋予非标准的语义。
"""

# ╔═╡ 2f1bd642-693e-4255-aa44-4661a28c69b3
md"""
### 宏： 作用于表达式的函数
"""

# ╔═╡ 42d51254-a51f-4379-84fa-534d75ec7a17
md"""
如前所述， 宏本质上是一个在编译阶段运行，把输入表达式匹配到输出表达式 （expressions） 的函数。 因为宏的行为与函数类似， 所以定义宏更简单方式是定义一个作用于表达式的函数。 从大处看， 上述定义方法会让事情大大简化， 因为无论是否在宏内部， 这些函数的行为都是一致的。

我们可以先写一个计算表达式参数个数的函数：
"""

# ╔═╡ 7fae7a9b-3985-4547-a717-6375c58e62fd
nargs(e::Expr) = length(e.args)

# ╔═╡ feb85b7b-57e8-4e02-aa70-907fadc87985
e1 = :(1 + 2 + 3)

# ╔═╡ 3c43b095-dea0-499a-8cfc-288016aa289f
nargs(e1)

# ╔═╡ a7b9068b-607e-42f2-b8b2-2bac25232fdb


# ╔═╡ d830da2d-5ef6-4a99-9bee-3bb264e8da1e
with_terminal(dump, e1)

# ╔═╡ b7cda82e-aadb-45ae-a89a-87750aac13cf
maxargs(e::Any) = 0

# ╔═╡ 8912fe22-9d87-4526-a7d0-f9c90a4bcae7
maxargs(e::Expr) = max(nargs(e), maximum(map(maxargs, e.args)))

# ╔═╡ 1a70d5d4-ec58-4267-9cc8-6c45385ae6ac
e2 = quote
	z = 1 + log(x + y)
	exp(z)
end;

# ╔═╡ f29ac37b-7f4e-4e98-85a0-f8b976733de0
maxargs(e2)

# ╔═╡ 06edfd58-799d-49a2-b64b-89648d9c8e6a
# with_terminal(dump, e2)

# ╔═╡ c970f478-e372-4ed5-b947-7c8b14b3c3a8
md"""
# MM
"""

# ╔═╡ f7546504-48b2-44c9-b64e-74b01e5a7eab
macro bad_macro()
	x = rand()
	:($x)
end

# ╔═╡ 9b984175-05b7-4dd0-80ec-efe6d11781d8
with_terminal() do
	for i in 1:10
		println(@bad_macro(), "||", i)
	end
end

# ╔═╡ e8e2bc44-c8f4-4d6c-8d32-8deb69ec7852
md"""
### 卫生宏
"""

# ╔═╡ fb755431-fa70-413d-816b-4b92979033a9
macro assign1(name, e)
	Expr(:(=), name, e)
end

# ╔═╡ 265e20b1-d5e2-4f82-b9f9-e9f541235520
@assign1(z1, 1)

# ╔═╡ 74bce9d0-9bab-4493-a86b-16ccdf9018dc
z1

# ╔═╡ b4eac822-a1b2-4887-b50a-1c2e0611dbdc
@macroexpand(@assign1(z1, 1))

# ╔═╡ d10ab636-653f-4be2-8e38-0b6f341b5e9a
let name = :z1, e = :(1)
	Expr(:(=), name, e)
end

# ╔═╡ 669c9315-e26c-4732-964c-0eb26a1e1365
let name = :z1, e = :(1)
	Expr(:(=), gensym(name), e)
end

# ╔═╡ 5bf2975a-611a-435e-a780-b1e39da2a324
esc(:x)

# ╔═╡ 12dd4c3a-d297-4966-af2c-aa627dd29d0d
esc(:(1 + x))

# ╔═╡ 061e722b-cfc3-4287-9199-3a348c49eb5d
macro assign2(name, e)
	Expr(:(=), esc(name), e)
end

# ╔═╡ ea39e5f4-248f-4ccd-b1ef-884200f27fd6
@assign2(z2, 1)

# ╔═╡ 8e72ecad-dd20-4e46-90f4-7c0c2fc318fc
z2

# ╔═╡ 27ef040e-ab61-4971-af74-f8f9e18cb473
macro assign3(name, e)
	esc(Expr(:(=), name, e))
end

# ╔═╡ a63883bf-abe6-4038-a609-be4c901025ee
@assign3(z3, 1)

# ╔═╡ 326bc784-0148-4c91-8772-4b3d2b37d5c3
z3

# ╔═╡ 0b930b9b-d30a-4b34-91bc-1970ae5c93ac
md"""
### 展开顺序
"""

# ╔═╡ 32a42762-b2fd-4d7c-8159-c5b130014b38
macro foo(e)
	println("In Foo")
	e
end

# ╔═╡ 60df657b-0f71-418c-8162-3a0489a185f0
macro bar(e)
	println("In Bar")
	e
end

# ╔═╡ 5c506881-3abe-40aa-980e-35be0c64e488
@bar(1)

# ╔═╡ 0686ce0f-59ed-4e07-9af1-203208f6183e
with_terminal() do
	@foo(1)
end

# ╔═╡ 018e62a9-5614-45f7-a9f9-41b70f2dad8b
with_terminal() do
	@foo(@bar(1))
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
MacroTools = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
MacroTools = "~0.5.9"
PlutoUI = "~0.7.35"
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

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

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

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

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

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

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

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "13468f237353112a01b2d6b32f3d0f80219944aa"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.2.2"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "85bf3e4bd279e405f91489ce518dedb1e32119cb"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.35"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╠═eb30c73f-4f60-4fc4-8166-1da11585e628
# ╟─c5bec4ad-8955-422a-bad3-4968d4d39c0c
# ╟─7d53a8fa-fd00-4503-93b1-0dae05578700
# ╟─4d7165a9-c781-40e2-bd42-82df2be034a2
# ╟─858936b7-5ac7-42c0-8aa9-df1cbfe9d1f6
# ╟─8c57aa1f-5c18-4292-b62c-f4909d1d4818
# ╠═67aa4a88-46b6-4a5f-af89-3f72a977c8cb
# ╠═3958f679-6c86-4731-a6e9-9ac597326f44
# ╟─ba2ec22d-d255-4bc7-8cc3-d090f00da1fc
# ╟─ef39222a-0c18-4eae-b883-88eff1015077
# ╟─1275c1f6-2c09-4c39-b253-dd857128ef27
# ╠═9f26dc3f-509f-451c-b0ef-b70aee06bfc0
# ╠═898c0633-f722-4c84-b568-06795c047e6a
# ╠═f4091b2c-24c1-423d-af18-16cee421c552
# ╠═bc81576d-b1a0-4060-8487-a13da3c8bc42
# ╠═eef769c8-e69d-4e0a-a95e-01fc9eb76205
# ╠═60dce293-35c3-4a31-a6f8-1bcaae2ff644
# ╠═af589ba9-02e0-4334-8b3c-c9fec4d4635f
# ╟─6ddfc2f8-167f-4236-8095-990b0136285e
# ╠═ad714b6b-5f1a-4027-962c-dcd5d43a98ed
# ╠═3dd1474b-43d0-4aab-b27e-2256a0fe3156
# ╟─6eda4169-a034-42a9-a15b-4157421e7cba
# ╟─23298a41-8f64-490d-ac4c-22691ad75038
# ╠═8362af9b-534f-429a-9f7c-c79eef64840d
# ╠═dd8be7b8-a8b8-4629-97f3-3748e79761fa
# ╠═b6e13d5e-7937-4918-a44d-fdf24e39785b
# ╟─0a6cddb7-3888-4c3e-9323-e5eab5301479
# ╟─f73a3a81-4439-4ba2-84f4-b060754cee0c
# ╠═18ebacb7-6b6e-4347-b175-aa9b7c98f93e
# ╟─cf7d932f-9b22-44de-a178-73b5327964fd
# ╠═0be7d504-32d1-43f5-92b5-0980487abb1a
# ╟─daa034c0-92bd-47de-8377-de9b2c6403d3
# ╠═620b63c4-f43b-4026-a787-63900dea046f
# ╟─80d488fa-8588-486a-b9ec-26544d2449bc
# ╟─268e84f3-bd32-4e9d-9d65-ee72a5d3d00c
# ╠═ed3ea5e5-7aaa-4738-8cb3-31015308812f
# ╠═5fad2af8-e8b6-4eff-99a0-04c5080f044b
# ╠═4e17c358-6788-4b98-a650-70f785698fb3
# ╟─85115360-f7f2-4d4f-b493-5ccc4c19122f
# ╠═8919b66e-4f3e-474b-8a9e-8d1afa7ab757
# ╟─add73323-a15d-4b57-b9a8-d7b30428e3df
# ╠═d45e0165-141b-4aaa-8399-0a38e8f2247e
# ╟─8b102cba-3d07-408c-be44-f1b96d8b68ca
# ╠═8802e2e4-11ea-48d8-929b-145944f4c4d8
# ╠═c27aafb7-b211-4a6e-b013-01a98bb57a54
# ╟─18c148cb-4570-4d78-bcfa-931948aa869e
# ╟─2f1bd642-693e-4255-aa44-4661a28c69b3
# ╟─42d51254-a51f-4379-84fa-534d75ec7a17
# ╠═7fae7a9b-3985-4547-a717-6375c58e62fd
# ╠═feb85b7b-57e8-4e02-aa70-907fadc87985
# ╠═3c43b095-dea0-499a-8cfc-288016aa289f
# ╠═a7b9068b-607e-42f2-b8b2-2bac25232fdb
# ╠═d830da2d-5ef6-4a99-9bee-3bb264e8da1e
# ╠═b7cda82e-aadb-45ae-a89a-87750aac13cf
# ╠═8912fe22-9d87-4526-a7d0-f9c90a4bcae7
# ╠═1a70d5d4-ec58-4267-9cc8-6c45385ae6ac
# ╠═f29ac37b-7f4e-4e98-85a0-f8b976733de0
# ╠═06edfd58-799d-49a2-b64b-89648d9c8e6a
# ╠═c970f478-e372-4ed5-b947-7c8b14b3c3a8
# ╠═f7546504-48b2-44c9-b64e-74b01e5a7eab
# ╠═9b984175-05b7-4dd0-80ec-efe6d11781d8
# ╠═e8e2bc44-c8f4-4d6c-8d32-8deb69ec7852
# ╠═fb755431-fa70-413d-816b-4b92979033a9
# ╠═265e20b1-d5e2-4f82-b9f9-e9f541235520
# ╠═74bce9d0-9bab-4493-a86b-16ccdf9018dc
# ╠═b4eac822-a1b2-4887-b50a-1c2e0611dbdc
# ╠═d10ab636-653f-4be2-8e38-0b6f341b5e9a
# ╠═669c9315-e26c-4732-964c-0eb26a1e1365
# ╠═5bf2975a-611a-435e-a780-b1e39da2a324
# ╠═12dd4c3a-d297-4966-af2c-aa627dd29d0d
# ╠═061e722b-cfc3-4287-9199-3a348c49eb5d
# ╠═ea39e5f4-248f-4ccd-b1ef-884200f27fd6
# ╠═8e72ecad-dd20-4e46-90f4-7c0c2fc318fc
# ╠═27ef040e-ab61-4971-af74-f8f9e18cb473
# ╠═a63883bf-abe6-4038-a609-be4c901025ee
# ╠═326bc784-0148-4c91-8772-4b3d2b37d5c3
# ╠═0b930b9b-d30a-4b34-91bc-1970ae5c93ac
# ╠═32a42762-b2fd-4d7c-8159-c5b130014b38
# ╠═60df657b-0f71-418c-8162-3a0489a185f0
# ╠═5c506881-3abe-40aa-980e-35be0c64e488
# ╠═0686ce0f-59ed-4e07-9af1-203208f6183e
# ╠═018e62a9-5614-45f7-a9f9-41b70f2dad8b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
