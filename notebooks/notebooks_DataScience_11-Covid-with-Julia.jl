### A Pluto.jl notebook ###
# v0.18.2

using Markdown
using InteractiveUtils

# ╔═╡ 3148423c-7fce-4fd0-b44a-b9ec82641b75
html"<button onclick='present()'> Presentation Mode </button>"

# ╔═╡ d0492b8b-64f2-47e1-8afb-6b14d5ddb322
PlutoUI.TableOfContents(title = "目录", depth = 1, aside = false)

# ╔═╡ 36a7677b-d589-42a8-a45d-28c133b5b94b
md"""

# Julia 语言是什么

$(PlutoUI.LocalResource("../assets/Covid_with_Julia/julia-logo-color-large.png"))

- Julia 是面向未来的技术型编程语言。
- [_The Technical Programming Language of the Future_](http://pages.stat.wisc.edu/~bates/JuliaForRProgrammers.pdf) - Douglas Bates

"""

# ╔═╡ 8d71ed8d-3022-4f6c-83ad-b75b56b1b121
begin
struct TwoColumn{T, L, R}
	top::T
    left::L
    right::R
	end

function Base.show(io, mime::MIME"text/html", tc::TwoColumn)
    write(io, """<div style="display: flex;"><div style="flex: 100%;">""")
    show(io, mime, tc.top)
    write(io, """<div style="display: flex;"><div style="flex: 100%;">""")
    show(io, mime, tc.left)
    write(io, """</div><div style="flex: 50%;font-size:69%">""")
    show(io, mime, tc.right)
    write(io, """</div></div>""")
	end
TwoColumn(md"## 编程语言编年史",
	PlutoUI.LocalResource("../assets/Covid_with_Julia/Turris_Babel_by_Athanasius_Kircher.jpg"), 
	md"""
	- 1966: FORTRAN
	- 1972: C, Proglog, SQL
	- 1975: Scheme
	- 1976: S, SAS
	- 1978: MATLAB
	- 1980: Ada, Smalltalk-80
	- 1982: PostScript
	- 1983: Objective-C, C++
	- 1984: Common Lisp, Standard ML
	- 1986: Eiffel, Erlang
	- 1987: Perl, Mathematica
	- 1988: Tcl
	- 1990: Haskell
	- 1991: Python, Visual Basic
	- 1993: Lua, R
	- 1995: Java, PHP, Ruby, JavaScript, Racket
	- 1996: OCaml
	- 2000: C#
	- 2001: D
	- 2003: Scala
	- 2005: F#
	- 2007: Clojure
	- 2009: Go
	- 2010: Rust
	- 2011: Dart, Kotlin
	- 2012: Elixir, Elm, TypeScript, **Julia**
	- 2014: Hack, Swift
	""")
end

# ╔═╡ 02376d65-c884-45a2-8537-27896d5994fd
md"""
## Julia 语言的设计者很 "贪婪"

这门编程语言应该：


- 是开源的和自由许可的； 


- 同时拥有 `C` 的速度和 `Ruby` 的动态性；


- 同像的， 既与 `Lisp` 一样有真正的宏， 也与 `Matlab` 一样有熟悉的数学符号系统；


- 像 `Python` 一样高效地进行通用编程， 像 `R` 一样简单地执行统计分析， 像 `Perl` 一样自然地处理字符串, 像 `Matlab` 一样强劲地进行线性代数运算， 像胶水语言 `sheel` 一样擅长把不同程序粘合到一起;


- 既简单易学， 又要让最苛刻的极客们开心;


- 既是交互式的， 又能被编译。


[全文链接](https://julialang.org/blog/2012/02/why-we-created-julia/)
"""

# ╔═╡ a2914ab7-2048-46ab-abaf-5e4604a94eb2
md"""
## 编程的双语言问题
$(PlutoUI.LocalResource("../assets/Covid_with_Julia/Julia-Speed.png"))

- Julia 在两个世界中都实现了很好的效果， Julia 语言是面向未来的技术性编程语言。 [Douglas Bates](http://pages.stat.wisc.edu/~bates/JuliaForRProgrammers.md)

[图片来源 (https://statisticswithjulia.org)](https://statisticswithjulia.org)
"""

# ╔═╡ b54c9ef9-cae8-4f0e-a152-0d24686ad8e0
md"""
## Julia 语言的设计团队
$(PlutoUI.LocalResource("../assets/Covid_with_Julia/Julia-Citation.png"))
"""

# ╔═╡ 9c49c542-d813-47cd-bfa4-2fcfa78f2267
md"""
## Julia 语言的诞生
$(PlutoUI.LocalResource("../assets/Covid_with_Julia/Julia-Start.png"))
- [全文链接](https://julialang.org/assets/blog/2018-08-08-one-point-zero/release-1.0-keynote.pdf)
"""

# ╔═╡ b6c11ebe-d1d6-47fe-86e8-2047cd61ef03
md"""
## Julia 语言简史

- Aug 2009: 


- Feb 2012: Julia 0.0


- Aug 2018: Julia 1.0


- Aug 2021: Julia 1.6.2
"""

# ╔═╡ 3aea3c3e-fb5e-4deb-a33f-7fdd92bb08cc
md"""
## Julia 语言更快
![](https://julialang.org/assets/benchmarks/benchmarks.svg)
- [源文件链接](https://julialang.org/benchmarks/)
"""

# ╔═╡ b1e164c2-712e-4b7f-863c-5779b97afd1e
md"""
## Julia 编译器不特别
- Julia 使用的是公众熟知的开源编译器 LLVM (Low Level Virtual Machine)， 所以其后端并没有任何特别之处， Julia 并没有什么秘密武器。


- Julia 的速度优势完全来源于其前端设计： Julia 的语义系统使得编译器更有机会产生更加高效的代码和内存布局。


- 如果只是简单地把 Matlab 或 Python 代码在 Julia 中进行编译， 那么受限于这些语言的语义系统， 此类代码甚至会比在 Matalb 或 Python 中表现更差。 


- 基于此类语义系统的关键作用， Python 编译器对某些子模块的优化效果也是非常好的， 如 Numba。 但是此类优化是很难应用于整个解释性编程语言系统的。 


- Julia 的优势在于代码的高效性并不局限于某些特定内在类型和操作， 而能在任何研究者自行设定的类型中实现。

[原文链接](https://docs.julialang.org/en/v1/manual/faq/#Why-don't-you-compile-Matlab/Python/R/…-code-to-Julia?)
"""

# ╔═╡ c38e1222-43f7-4564-a7f7-ddaee168e499
md"""
## Julia 语言为什么能更快？
- 语言实现 (Language Implementation)


- 语言设计 (Language Design)


- 代码风格 (Programming Style)
"""

# ╔═╡ c524c211-5426-43f8-8770-f1686f33b150
md"""
## 语言实现

$(PlutoUI.LocalResource("../assets/Covid_with_Julia/Julia-Compile-Pipline.png"))

- 泛型特化 (Specialization)


- 函数内联 (inlining)


- 无需封装和解封 (unboxing)

"""

# ╔═╡ 9dbeecc0-d149-4bc6-a625-04516050c8a7
md"""
## 编译过程

1. 首先， 所有代码本质上都是一些字符串 （string）， 存储在硬盘上的文本文件中；


2. 我们首先要解析 （`Meta.parse`） 这些字符串， 得到一个抽象语法数 （Abstract Syntax Tree， AST）


3. 而 AST 里有一些节点是宏， 这些宏是一些只接受编译时期变量的， 里面描述了如何产生更多的 AST。 在这一步将会运行这些宏， 我们称为展开 AST。 你可以通过 `@macroexpand` 宏查看这一步的编译结果


4. 这个时候我们再将 AST 里的语法糖等节点全部替换为函数调用， 并且使用 SSA （Static Single Assignment） 形式的 中介码（IR， intermediate representation） 作为更低级的表示。 你可以用 `@code_lowered` 来查看这一步的结果。

到此位置我们完成了代码的初始化过程。

5. 函数在被派发时会被继续编译， 因为范型函数 （generic function） 的变量类型在编译阶段无法确定的， 从而无法产生定制的机器码。


6. 然后开始进行类型推导 （type inference）， 这是为什么你可以不用写清楚到底是什么类型的原因。同时有了类型以后编译器才能做很多优化。 这样我们就得到了带类型的 IR （typed IR）。 你可以用 `@code_typed` 来查看这部分编译结果。


7. 然后我们用这个 IR 来产生 LLVM IR。 你可以用 `@code_llvm` 来查看此阶段编译结果。


8. LLVM IR 会用来产生机器码， 你可以用 `@code_native` 宏来获得这个编译结果

- [全文链接](https://blog.rogerluo.dev/2019/07/27/yassad/)

"""

# ╔═╡ 76b8ca26-b868-4ff4-991f-d93c142284d2
# Meta.parse； @macroexpand；  @code_lowered， @code_typed， @code_llvm， @code_native

# ╔═╡ 46add8a1-913d-4d83-bc3d-491dcd72e0a6
md"""
## 语言设计

- 类型有高表达性，不可擦除：减少分支，多重派发； \
  Expressive, non-erased, types: Reduces branching in code, instead relies on multi-dispatch


- 字段存储值是核查过的: 字段的存储值均为被标记的类型； \
  Checked field stores: Field always hold values of adverstised type


- 继承是单一的：派发简单、快速； \
  Single inheritance: Simpler, faster, dispatch


- 实体类型是终态的：其数据结构没有子类型，编译器知道其布局； \
  Concrete types are final: No subtyping for data structure, layout is know to the compiler


- `eval` 函数受限于全局作用域和世界时代：不会干扰编译过的编码； \
  eval restricted & world age: no interference with compiled code


Bezanson, J., Chen, J., Chung, B., Karpinski, S., Shah, V. B., Vitek, J., & Zoubritzky, L. (2018). Julia: Dynamism and performance reconciled by design. *Proceedings of the ACM on Programming Languages, 2*, 1-23. https://doi.org/10.1145/3276490 

"""

# ╔═╡ 786411b0-0191-4e67-830b-cfb8ad5d04cd
md"""
## 代码风格

- 自定义类型：能根据输入值对范型进行特化； \
  Define types: Allows differentiating between values；


- 用派发而非分支：派发是特化的，而分支不是； \
  Prefer dispatch over branches: Dispatch is specialzied whereas branches are not;


- 保持类型稳定： 单态代码有确定的布局， 并能进行函数内联； \
  Write type code: Monomorphis code has a know layout, and allows for inlining

"""

# ╔═╡ 47f2b4f9-1062-4f1e-b33e-c1b54189d250
md"""
## 一个例子
"""

# ╔═╡ ec4e5ea3-1234-4425-9311-37278392cb51
removetype(@nospecialize(x)) = Ref{Any}(x)[];

# ╔═╡ 5f4469a1-8917-43f2-bf54-a63b070e8f28
foo(x) = 42 * x

# ╔═╡ aadb4b5a-94f1-4909-a806-0345efb62b71
function with_type(x)
	y = x
	return foo(y)
end

# ╔═╡ fadd14f1-7b6a-453f-b6d6-0d3e8e5c78f8
function no_type(x)
	y = removetype(x)
	return foo(y)
end

# ╔═╡ 667297fc-2bf2-4842-9cb8-ca60a6e27bdc
with_type(3) == no_type(3) == 126

# ╔═╡ db49e131-f5b3-4c48-b97b-50f362c4d343
# @code_typed with_type(3)

# ╔═╡ 86513f98-152a-4d0d-ae07-4c85689d24ab
# @code_typed no_type(3)

# ╔═╡ d820af77-e19a-42b1-86b2-a2ec0a06cc78
# with_terminal() do
# 	@code_native with_type(3)
# end

# ╔═╡ 005d7a08-728b-44c3-9d1a-8e5eb2a87b2b
# with_terminal() do
# 	@code_native no_type(3)
# end

# ╔═╡ 4d74b0b1-c4a4-48af-b9d7-e87d2974b0d9
md"""
# 软件安装和使用
- 用于科学计算的动态编程语言
- A dynamic language for scientific computing
"""

# ╔═╡ b280a3f3-058b-4e7e-9a30-086b88782a2b
md"""
## 代码编辑器
$(PlutoUI.LocalResource("../assets/Covid_with_Julia/Editors-and-IDEs.png"))

"""

# ╔═╡ 34110910-2f87-44b4-b028-74f8972f92be
md"""
## 软件安装和运行
- [安装二进制版](https://julialang.org/downloads/)
- [自行编译源代码](https://github.com/JuliaLang/julia)
"""

# ╔═╡ a5a8db8b-c14d-4e0d-8102-a367bc7a022b
PlutoUI.with_terminal() do 
	versioninfo() 
end

# ╔═╡ 49a5a52e-6652-4724-a758-de45db08377d
# varinfo() # Core, Base, Main

# ╔═╡ ab8b326b-ad96-445e-97d6-5dd8ab68f224
md"""
## 安装和运行额外包
"""

# ╔═╡ 92c4155d-c639-4ce8-97e5-9f8bb68ba57c
begin
	using PlutoUI       # Pluto 附加函数, 如 PlutoUI.TableOfContents(), PlutoUI.LocalResource(), PlutoUI.with_terminal() 等
	using Pipe          # 宏 `@pipe`
	using Downloads     # 只包含一个函数 `download()`
	using CSV           # 数据读入包
	using DataFrames    # 数据预处理包
	using Dates         # 日期数据
	using Plots         # 作图包
	using ShiftedArrays # lag() 函数
	using GLM           # 函数拟合和统计分析
	using StatsBase     # 统计模型的提取函数, 如 coeftable 等
	using Distributions # 用到的函数 Normal(), ccdf()
	# using LinearAlgebra
	# using Statistics
end

# ╔═╡ e2deac36-9b92-492d-ac61-502d9714aed2
md"""
# 数据整理和展示

- 走起来像 Python， 跑起来像 C。
- *Walks like Python, Runs like C*.
"""

# ╔═╡ 69e31dcc-788a-443e-8532-a69463b470a3
md"""
## 下载数据
"""

# ╔═╡ 50c71109-7918-4ffb-a902-bf9c214c4ee2
covid_github = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/";

# ╔═╡ 19d0923c-0450-4007-b8d7-76ec0064a1bb
confirmed_global = covid_github * "time_series_covid19_confirmed_global.csv";

# ╔═╡ 702e85a8-fc89-45bc-8ce2-3cb178eda547
confirmed_wide = CSV.read(Downloads.download(confirmed_global, "covid_global.csv"), DataFrame);

# ╔═╡ 65b1bf77-6c35-4b5f-831c-9907829abb70
# describe(confirmed_wide)

# ╔═╡ a166d57d-2723-40f2-97a7-e9678d1e3bec
# methods(), @edit 

# ╔═╡ 44c4ef27-73db-4c87-9cf9-4e3709290cdd
md"""
## 数据整洁性
- 每个变量必读独占一列;
- 每个观测必须独占一行；
- 每个值必须独占一个单元格；
$(PlutoUI.LocalResource("../assets/Covid_with_Julia/Tidy-Data.png"))
"""

# ╔═╡ 05885122-92e3-4052-97fd-6ec815c65e65
# describe(confirmed_wide)

# ╔═╡ 43f89505-4af3-4a1e-a967-2b92eebb0768
md"""
## 整洁数据和修改格式
"""

# ╔═╡ 546c55ce-be0c-44a1-9f0c-f842d0a9896b
confirmed_long = stack(
	confirmed_wide, 
	names(confirmed_wide)[5:end], 
	variable_name = "Date", 
	value_name = "Confirmed"
);

# ╔═╡ 9a77d594-9bfe-4988-9387-91b924b30f5d
# confirmed_long

# ╔═╡ b1d1ad9f-0f02-474b-9177-2d8d0965fac9
confirmed_long.Date = parse.(Date, 
	confirmed_long.Date, 
	Dates.DateFormat("m/d/Y")) + Year(2000);

# ╔═╡ a9d9fd7d-bc16-48ca-be19-eeb4cbeca899
describe(confirmed_long)

# ╔═╡ 66ab70b5-115b-4e48-9b9c-5c768e4869a5
md"""
## 处理台湾省数据
"""

# ╔═╡ 4bc28463-9036-4a3f-bd40-4717334ca1d0
subset(confirmed_long, Symbol("Country/Region") => x -> startswith.(x, "Taiwan"))

# ╔═╡ 817f78d9-24f2-4a6c-aaef-0190a0a5b5a8
confirmed_long."Country/Region" .= ifelse.(
	occursin.("Taiwan", confirmed_long."Country/Region"), 
	"China", confirmed_long."Country/Region");

# ╔═╡ 2152c4d4-35ab-4f06-83d5-4c882a3d3e0a
subset(confirmed_long, Symbol("Country/Region") => x -> startswith.(x, "Taiwan"))

# ╔═╡ 027246a1-2393-49d2-9abe-f7a39c0ff4b9
describe(confirmed_long)

# ╔═╡ a9e2e3ee-c5d8-4481-94cd-1e7745d1bba9
md"""
## 按国家整合数据
"""

# ╔═╡ 0d53f235-4180-4df3-b123-8dd3eb240f4c
confirmed = @pipe confirmed_long                  |> 
	groupby(_, [Symbol("Country/Region"), :Date]) |>
	combine(_, :Confirmed => sum => :Confirmed)   |>
	groupby(_, Symbol("Country/Region"))          |>
	transform(_, :Confirmed => (x -> x - lag(x; default = 0)) => :Daily);

# ╔═╡ f542b846-dc76-421a-9cf1-ef55ddaf4535
describe(confirmed)

# ╔═╡ f72433f1-2411-4c7a-b804-c0485380d444
md"""
## 探索数据基本信息
"""

# ╔═╡ 1aae1226-15f0-4f35-8a44-918ab3f2c005
length(unique(confirmed."Country/Region")) # 国家和地区总数

# ╔═╡ 824b0730-4129-4473-b02d-47a120076d41
min, max = extrema(confirmed.Date)         # 数据时间范围

# ╔═╡ 3f511575-ec35-4823-97de-17e4609aa271
diff([min, max])                           # 数据总天数

# ╔═╡ df72b3dc-5cb5-4b2b-a4cc-9d269764346d
md"""
## 按确诊总数筛选国家
"""

# ╔═╡ 207a52a3-9e8f-4df3-9e40-eb3fea3cbc78
function Select_Country(Data, N_day, N_country)
	N_country = N_country - 1
	min, max = extrema(Data.Date)
	(N_day > (max - min).value) && error("N_day exceed max ($((max-min).value))")
	Day_Data = Data[Data.Date .== (min + Day(N_day)), :]
	Country_List(Day_Data, N_country) = 
		sort(Day_Data, :Confirmed, rev = true)[1:N_country, :("Country/Region")]
	if "China" ∈ Country_List(Day_Data, N_country)
		return  Country_List(Day_Data, N_country + 1)
	else
		return [Country_List(Day_Data, N_country); "China"]
	end
end

# ╔═╡ 9cb98725-c250-4bb4-b7b3-dbd4f49478a1
Select_Country(confirmed, 1, 10)

# ╔═╡ 26a8bea8-235e-48b6-b685-3ef6270d1801
md"""
## 选定国家确诊总数
"""

# ╔═╡ 042388ff-6c79-4309-a32d-3775688c2557
function Day_N_Country(Data, N_day, N_country)
	min_date     = minimum(Data.Date)
	Country_List = Select_Country(Data, N_day, N_country)
	return filter(x -> (x.Date == (min_date + Day(N_day))) & 
					   (x."Country/Region" ∈ Country_List), 
		   Data)
end

# ╔═╡ 50194e91-5b5f-470d-a558-e6a4388e0015
Day_N_Country(confirmed, 500, 5)

# ╔═╡ 961a68ba-a800-4e86-be66-e05b4557cb9f
md"""
## 确诊总数的柱形图
"""

# ╔═╡ c37c22cb-baef-43af-905c-8124d88de9c4
Day_Data = Day_N_Country(confirmed, 100, 20);

# ╔═╡ f5afaa88-616a-4643-9db3-ff12be4c2a9c
plot(
	Day_Data."Country/Region",  
	Day_Data.Confirmed,
	group = Day_Data."Country/Region",
	yticks = :all,
	bar_width = 1,
	yflip = true,
	orientation = :h,
	seriestype = :bar,
	framestyle = :semi,
	tickfontsize = 8,
	xlabel = "Confirmed Cases", 
	ylabel = "Country/Region",
	grid = false, 
	legend = false,
	size = (800, 600)
	)

# ╔═╡ 9c338a22-8939-409c-ac89-9fc0acd2cc6c
md"""
## 确诊总数的动态变化
"""

# ╔═╡ 35890f54-ea48-4cca-acb6-1e9b803f2afc
anim = @animate for i ∈ 1:(max - min).value
	List_Selected  = Select_Country(confirmed, i, 5)
	Select_Data = filter(x -> (x."Country/Region" ∈ List_Selected) & 
							  (x.Date <= min + Day(i)), confirmed)
	LastDay = Select_Data[Select_Data.Date .== (min + Day(i)), :]
	plot(
		Select_Data.Date, 
		Select_Data.Confirmed, 
		group = Select_Data."Country/Region",
		seriestype = :line, arrow = true,
		xlims = (min, max),
		xlabel = "Date", 
		ylabel = "Confirmed Cases",
		xrotation = 0, legend = false)
	annotate!(
		LastDay.Date, 
		LastDay.Confirmed, 
		LastDay."Country/Region",
		annotationfontsize = 9,
		annotationhalign = :right, 
		annotationvalign =  :bottom
		)
end;

# ╔═╡ ce6d98ab-cad1-46cc-aef5-f1b85fad8f14
gif(anim, "anim_fps15.gif", fps = 15)

# ╔═╡ ed271d15-c42e-4083-b768-50b5d77ef578
md"""
# 统计和模型拟合

- 因其句法而来， 因其速度而留。
- [_Come for the Syntax, Stay for the Speed._](https://media.nature.com/original/magazine-assets/d41586-019-02310-3/d41586-019-02310-3.pdf) - Nature
"""

# ╔═╡ 36cfc0cd-adb3-427d-a445-a400f8084090
md"""
## 数据提取和转化
"""

# ╔═╡ 01a404b1-d941-42f7-b5ce-d7f6684970d3
China_US = confirmed[confirmed."Country/Region" .∈ (["US", "China"],), :]

# ╔═╡ e3127bbf-c246-4eec-8480-4592ce071cee
rename!(China_US, "Country/Region" => "Country");

# ╔═╡ 3923b173-0f94-4de2-8112-907cc479aaf1
# China_US

# ╔═╡ 29388df7-db60-43c2-962a-447cae593500
transform!(China_US, :Date => ByRow(x -> getfield((x - min), :value)) => :Day);

# ╔═╡ a28039e8-f3f6-44ad-826e-4474375309b7
# China_US

# ╔═╡ f3549035-c80c-4b98-9c2b-f93c3bb1c7b4
md"""
## 模型定义和拟合
"""

# ╔═╡ 45201cfb-a31e-4740-bd82-4541ebc3a86b
model = @formula(Confirmed ~ 1 + Country + Day + Day^2 + Day^3 );

# ╔═╡ 965a1f3f-8c35-4488-8ed3-41cdcdb2cc3b
contr = Dict(:Country => EffectsCoding())

# ╔═╡ a340487e-afa0-428e-87eb-a0cd89ef8cc0
fm = fit(GeneralizedLinearModel, model, China_US, Poisson(), contrasts = contr);

# ╔═╡ c435caf9-2232-4969-becc-796ef77a7c8c
md"""
## 模型拟合结果
"""

# ╔═╡ 7ceb96ae-42f8-4361-a56d-635b90a3ec20
fm

# ╔═╡ d8a0fbb1-3d60-4b75-883b-b843327ce2d9
md"""
## 拟合的准确性
"""

# ╔═╡ 0c189181-d0f8-4059-b673-485769d8b80e
begin
	plot(China_US.Date, China_US.Confirmed, 
		group = China_US.Country, label = ["Observed-China" "Observed-US"], 
		legend = :topleft)
    plot!(China_US.Date, predict(fm), 
		group = China_US.Country, label = ["Predicted-China" "Predict-US"])
end

# ╔═╡ 3bc6de1f-eb5b-4e45-b616-23bb8d5a75cc
md"""
## 提取相关参数
"""

# ╔═╡ 3ea0f8a1-4114-41b1-adba-ced5fce99d7c
## 常见提取函数: coef, coeftable, confint, deviance, nulldeviance, dof, dof_residual, loglikelihood, nullloglikelihood, nobs, stderror, vcov, residuals, predict, fitted, fit, fit!, model_response, response, modelmatrix, r2, r², adjr2, adjr²

# ╔═╡ 70a746fd-29e3-409a-908f-abcd5a495498
coeftable(fm)

# ╔═╡ 2d21d130-7eb7-412d-9234-e144e52719a8
b_val = coef(fm)

# ╔═╡ 99aab59e-6978-4dfe-a121-5ae8e06f7ed0
se = stderror(fm)# ≈ sqrt.(diag(vcov(fm)))

# ╔═╡ 276dd17a-3cb5-4ecf-832d-0087d7ec5ee4
z_val = b_val ./ se

# ╔═╡ c61b42a3-a94f-4973-90a5-e8eb276de56a
p_val = @. ccdf(Normal(0, 1), abs(z_val))

# ╔═╡ 0741c318-2807-4c37-a524-1f8d03e1b6c5
zz = cquantile(Normal(0, 1), (1 - 0.95)/2)

# ╔═╡ bc7d1235-4db5-4275-8807-0257dac2d1a8
conf_low = b_val .-  zz .* se

# ╔═╡ c6308cea-6719-4183-b418-2ad2f16bfc52
conf_high = b_val .+  zz .* se

# ╔═╡ f769acf5-5972-4362-87ce-2d33a0aa1bc2
[b_val se z_val p_val conf_low conf_high]

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
Dates = "ade2ca70-3891-5945-98fb-dc099432e06a"
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
Downloads = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
GLM = "38e38edf-8417-5370-95a0-9cbb8c7f171a"
Pipe = "b98c9c47-44ae-5843-9183-064241ee97a0"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
ShiftedArrays = "1277b4bf-5013-50f5-be3d-901d8477a67a"
StatsBase = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"

[compat]
CSV = "~0.10.2"
DataFrames = "~1.3.2"
Distributions = "~0.25.49"
GLM = "~1.6.1"
Pipe = "~1.3.0"
Plots = "~1.25.11"
PlutoUI = "~0.7.35"
ShiftedArrays = "~1.0.0"
StatsBase = "~0.33.16"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "af92965fb30777147966f58acb05da51c5616b5f"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.3.3"

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[CSV]]
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "SentinelArrays", "Tables", "Unicode", "WeakRefStrings"]
git-tree-sha1 = "9519274b50500b8029973d241d32cfbf0b127d97"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.10.2"

[[Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f641eb0a4f00c343bbc32346e1217b86f3ce9dad"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.1"

[[ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "c9a6160317d1abe9c44b3beb367fd448117679ca"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.13.0"

[[ChangesOfVariables]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "bf98fa45a0a4cee295de98d4c1462be26345b9a1"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.2"

[[CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "ded953804d019afa9a3f98981d99b33e3db7b6da"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.0"

[[ColorSchemes]]
deps = ["ColorTypes", "Colors", "FixedPointNumbers", "Random"]
git-tree-sha1 = "12fc73e5e0af68ad3137b886e3f7c1eacfca2640"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.17.1"

[[ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "44c37b4636bc54afac5c574d2d02b625349d6582"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.41.0"

[[CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[Contour]]
deps = ["StaticArrays"]
git-tree-sha1 = "9f02045d934dc030edad45944ea80dbd1f0ebea7"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.5.7"

[[Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[DataAPI]]
git-tree-sha1 = "cc70b17275652eb47bc9e5f81635981f13cea5c8"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.9.0"

[[DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Reexport", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "ae02104e835f219b8930c7664b8012c93475c340"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.3.2"

[[DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "3daef5523dd2e769dad2365274f760ff5f282c7d"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.11"

[[DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[DensityInterface]]
deps = ["InverseFunctions", "Test"]
git-tree-sha1 = "80c3e8639e3353e5d2912fb3a1916b8455e2494b"
uuid = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
version = "0.4.0"

[[Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[Distributions]]
deps = ["ChainRulesCore", "DensityInterface", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SparseArrays", "SpecialFunctions", "Statistics", "StatsBase", "StatsFuns", "Test"]
git-tree-sha1 = "9d3c0c762d4666db9187f363a76b47f7346e673b"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.49"

[[DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "b19534d1895d702889b219c382a6e18010797f0b"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.6"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[DualNumbers]]
deps = ["Calculus", "NaNMath", "SpecialFunctions"]
git-tree-sha1 = "84f04fe68a3176a583b864e492578b9466d87f1e"
uuid = "fa6b7ba4-c1ee-5f82-b5fc-ecf0adba8f74"
version = "0.6.6"

[[EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3f3a2501fa7236e9b911e0f7a588c657e822bb6d"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.2.3+0"

[[Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ae13fcbc7ab8f16b0856729b050ef0c446aa3492"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.4.4+0"

[[FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "Pkg", "Zlib_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "d8a578692e3077ac998b50c0217dfd67f21d1e5f"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.0+0"

[[FilePathsBase]]
deps = ["Compat", "Dates", "Mmap", "Printf", "Test", "UUIDs"]
git-tree-sha1 = "04d13bfa8ef11720c24e4d840c0033d145537df7"
uuid = "48062228-2e41-5def-b9a4-89aafe57970f"
version = "0.9.17"

[[FillArrays]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "Statistics"]
git-tree-sha1 = "4c7d3757f3ecbcb9055870351078552b7d1dbd2d"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "0.13.0"

[[FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "87eb71354d8ec1a96d4a7636bd57a7347dde3ef9"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.4+0"

[[FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "51d2dfe8e590fbd74e7a842cf6d13d8a2f45dc01"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.6+0"

[[GLM]]
deps = ["Distributions", "LinearAlgebra", "Printf", "Reexport", "SparseArrays", "SpecialFunctions", "Statistics", "StatsBase", "StatsFuns", "StatsModels"]
git-tree-sha1 = "fb764dacfa30f948d52a6a4269ae293a479bbc62"
uuid = "38e38edf-8417-5370-95a0-9cbb8c7f171a"
version = "1.6.1"

[[GR]]
deps = ["Base64", "DelimitedFiles", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Printf", "Random", "RelocatableFolders", "Serialization", "Sockets", "Test", "UUIDs"]
git-tree-sha1 = "9f836fb62492f4b0f0d3b06f55983f2704ed0883"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.64.0"

[[GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Pkg", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "a6c850d77ad5118ad3be4bd188919ce97fffac47"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.64.0+0"

[[GeometryBasics]]
deps = ["EarCut_jll", "IterTools", "LinearAlgebra", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "58bcdf5ebc057b085e58d95c138725628dd7453c"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.4.1"

[[Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "a32d672ac2c967f3deb8a81d828afc739c838a06"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.68.3+2"

[[Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "0fa77022fe4b511826b39c894c90daf5fce3334a"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.17"

[[HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[HypergeometricFunctions]]
deps = ["DualNumbers", "LinearAlgebra", "SpecialFunctions", "Test"]
git-tree-sha1 = "65e4589030ef3c44d3b90bdc5aac462b4bb05567"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.8"

[[Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[HypertextLiteral]]
git-tree-sha1 = "2b078b5a615c6c0396c77810d92ee8c6f470d238"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.3"

[[IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[IniFile]]
git-tree-sha1 = "f550e6e32074c939295eb5ea6de31849ac2c9625"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.1"

[[InlineStrings]]
deps = ["Parsers"]
git-tree-sha1 = "61feba885fac3a407465726d0c330b3055df897f"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.1.2"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "a7254c0acd8e62f1ac75ad24d5db43f5f19f3c65"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.2"

[[InvertedIndices]]
git-tree-sha1 = "bee5f1ef5bf65df56bdd2e40447590b272a5471f"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.1.0"

[[IrrationalConstants]]
git-tree-sha1 = "7fd44fd4ff43fc60815f8e764c0f352b83c49151"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.1"

[[IterTools]]
git-tree-sha1 = "fa6287a4469f5e048d763df38279ee729fbd44e5"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.4.0"

[[IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b53380851c6e6664204efb2e62cd24fa5c47e4ba"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.2+0"

[[LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "Printf", "Requires"]
git-tree-sha1 = "a6552bfeab40de157a297d84e03ade4b8177677f"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.12"

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

[[Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "7739f837d6447403596a75d19ed01fd08d6f56bf"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.3.0+3"

[[Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "42b62845d70a619f063a7da093d995ec8e15e778"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+1"

[[Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "340e257aada13f95f98ee352d316c3bed37c8ab9"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.3.0+0"

[[Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "e5718a00af0ab9756305a0392832c8952c7426c1"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.6"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "3d3e902b31198a27340d0bf00d6ac452866021cf"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.9"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "Random", "Sockets"]
git-tree-sha1 = "1c38e51c3d08ef2278062ebceade0e46cefc96fe"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.0.3"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[Measures]]
git-tree-sha1 = "e498ddeee6f9fdb4551ce855a46f54dbd900245f"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.1"

[[Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[NaNMath]]
git-tree-sha1 = "b086b7ea07f8e38cf122f5016af580881ac914fe"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "0.3.7"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"

[[OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "648107615c15d4e09f7eca16307bc821c1f718d8"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.13+0"

[[OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[PCRE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b2a7af664e098055a7529ad1a900ded962bca488"
uuid = "2f80f16e-611a-54ab-bc61-aa92de5b98fc"
version = "8.44.0+0"

[[PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "7e2166042d1698b6072352c74cfd1fca2a968253"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.6"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "13468f237353112a01b2d6b32f3d0f80219944aa"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.2.2"

[[Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[PlotThemes]]
deps = ["PlotUtils", "Requires", "Statistics"]
git-tree-sha1 = "a3a964ce9dc7898193536002a6dd892b1b5a6f1d"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "2.0.1"

[[PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "6f1b25e8ea06279b5689263cc538f51331d7ca17"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.1.3"

[[Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "GeometryBasics", "JSON", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "PlotThemes", "PlotUtils", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "5c907bdee5966a9adb8a106807b7c387e51e4d6c"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.25.11"

[[PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "85bf3e4bd279e405f91489ce518dedb1e32119cb"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.35"

[[PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "db3a23166af8aebf4db5ef87ac5b00d36eb771e2"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.0"

[[Preferences]]
deps = ["TOML"]
git-tree-sha1 = "de893592a221142f3db370f48290e3a2ef39998f"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.4"

[[PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "dfb54c4e414caa595a1f2ed759b160f5a3ddcba5"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.3.1"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "ad368663a5e20dbb8d6dc2fddeefe4dae0781ae8"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+0"

[[QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "78aadffb3efd2155af139781b8a8df1ef279ea39"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.4.2"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[RecipesBase]]
git-tree-sha1 = "6bf3f380ff52ce0832ddd3a2a7b9538ed1bcca7d"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.2.1"

[[RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "RecipesBase"]
git-tree-sha1 = "995a812c6f7edea7527bb570f0ac39d0fb15663c"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.5.1"

[[Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "cdbd3b1338c72ce29d9584fdbe9e9b70eeb5adca"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "0.1.3"

[[Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "bf3188feca147ce108c76ad82c2792c57abe7b1f"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.7.0"

[[Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "68db32dff12bb6127bac73c209881191bf0efbb7"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.3.0+0"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[Scratch]]
deps = ["Dates"]
git-tree-sha1 = "0b4b7f1393cff97c33891da2a0bf69c6ed241fda"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.1.0"

[[SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "6a2f7d70512d205ca8c7ee31bfa9f142fe74310c"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.3.12"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[ShiftedArrays]]
git-tree-sha1 = "22395afdcf37d6709a5a0766cc4a5ca52cb85ea0"
uuid = "1277b4bf-5013-50f5-be3d-901d8477a67a"
version = "1.0.0"

[[Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "85e5b185ed647b8ee89aa25a7788a2b43aa8a74f"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.1.3"

[[StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "6354dfaf95d398a1a70e0b28238321d5d17b2530"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.4.0"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "c3d8ba7f3fa0625b062b82853a7d5229cb728b6b"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.2.1"

[[StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "8977b17906b0a1cc74ab2e3a05faa16cf08a8291"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.16"

[[StatsFuns]]
deps = ["ChainRulesCore", "HypergeometricFunctions", "InverseFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "25405d7016a47cf2bd6cd91e66f4de437fd54a07"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "0.9.16"

[[StatsModels]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "Printf", "REPL", "ShiftedArrays", "SparseArrays", "StatsBase", "StatsFuns", "Tables"]
git-tree-sha1 = "677488c295051568b0b79a77a8c44aa86e78b359"
uuid = "3eaba693-59b7-5ba5-a881-562e759f1c8d"
version = "0.6.28"

[[StructArrays]]
deps = ["Adapt", "DataAPI", "StaticArrays", "Tables"]
git-tree-sha1 = "57617b34fa34f91d536eb265df67c2d4519b8b98"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.5"

[[SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "TableTraits", "Test"]
git-tree-sha1 = "bb1064c9a84c52e277f1096cf41434b675cd368b"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.6.1"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "216b95ea110b5972db65aa90f88d8d89dcb8851c"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.6"

[[URIs]]
git-tree-sha1 = "97bbe755a53fe859669cd907f2d96aee8d2c1355"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.3.0"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[Unzip]]
git-tree-sha1 = "34db80951901073501137bdbc3d5a8e7bbd06670"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.1.2"

[[Wayland_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "3e61f0b86f90dacb0bc0e73a0c5a83f6a8636e23"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.19.0+0"

[[Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4528479aa01ee1b3b4cd0e6faef0e04cf16466da"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.25.0+0"

[[WeakRefStrings]]
deps = ["DataAPI", "InlineStrings", "Parsers"]
git-tree-sha1 = "c69f9da3ff2f4f02e811c3323c22e5dfcb584cfa"
uuid = "ea10d353-3f73-51f8-a26c-33c1cb351aa5"
version = "1.4.1"

[[XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "1acf5bdf07aa0907e0a37d3718bb88d4b687b74a"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.9.12+0"

[[XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "5be649d550f3f4b95308bf0183b82e2582876527"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.6.9+4"

[[Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4e490d5c960c314f33885790ed410ff3a94ce67e"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.9+4"

[[Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fe47bd2247248125c428978740e18a681372dd4"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.3+4"

[[Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6783737e45d3c59a4a4c4091f5f88cdcf0908cbb"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.0+3"

[[Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "daf17f441228e7a3833846cd048892861cff16d6"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.13.0+3"

[[Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "926af861744212db0eb001d9e40b5d16292080b2"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.0+4"

[[Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "4bcbf660f6c2e714f87e960a171b119d06ee163b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.2+4"

[[Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "5c8424f8a67c3f2209646d4425f3d415fee5931d"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.27.0+4"

[[Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "79c31e7844f6ecf779705fbc12146eb190b7d845"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.4.0+3"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e45044cd873ded54b6a5bac0eb5c971392cf1927"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.2+0"

[[libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"

[[x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "ece2350174195bb31de1a63bea3a41ae1aa593b6"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "0.9.1+5"
"""

# ╔═╡ Cell order:
# ╟─f5450eab-0f9f-4b7f-9b80-992d3c553ba9
# ╟─3148423c-7fce-4fd0-b44a-b9ec82641b75
# ╟─d0492b8b-64f2-47e1-8afb-6b14d5ddb322
# ╟─36a7677b-d589-42a8-a45d-28c133b5b94b
# ╟─8d71ed8d-3022-4f6c-83ad-b75b56b1b121
# ╟─02376d65-c884-45a2-8537-27896d5994fd
# ╟─a2914ab7-2048-46ab-abaf-5e4604a94eb2
# ╟─b54c9ef9-cae8-4f0e-a152-0d24686ad8e0
# ╟─9c49c542-d813-47cd-bfa4-2fcfa78f2267
# ╟─b6c11ebe-d1d6-47fe-86e8-2047cd61ef03
# ╟─3aea3c3e-fb5e-4deb-a33f-7fdd92bb08cc
# ╟─b1e164c2-712e-4b7f-863c-5779b97afd1e
# ╟─c38e1222-43f7-4564-a7f7-ddaee168e499
# ╟─c524c211-5426-43f8-8770-f1686f33b150
# ╟─9dbeecc0-d149-4bc6-a625-04516050c8a7
# ╠═76b8ca26-b868-4ff4-991f-d93c142284d2
# ╟─46add8a1-913d-4d83-bc3d-491dcd72e0a6
# ╟─786411b0-0191-4e67-830b-cfb8ad5d04cd
# ╟─47f2b4f9-1062-4f1e-b33e-c1b54189d250
# ╠═ec4e5ea3-1234-4425-9311-37278392cb51
# ╠═5f4469a1-8917-43f2-bf54-a63b070e8f28
# ╠═aadb4b5a-94f1-4909-a806-0345efb62b71
# ╠═fadd14f1-7b6a-453f-b6d6-0d3e8e5c78f8
# ╠═667297fc-2bf2-4842-9cb8-ca60a6e27bdc
# ╠═db49e131-f5b3-4c48-b97b-50f362c4d343
# ╠═86513f98-152a-4d0d-ae07-4c85689d24ab
# ╠═d820af77-e19a-42b1-86b2-a2ec0a06cc78
# ╠═005d7a08-728b-44c3-9d1a-8e5eb2a87b2b
# ╟─4d74b0b1-c4a4-48af-b9d7-e87d2974b0d9
# ╟─b280a3f3-058b-4e7e-9a30-086b88782a2b
# ╟─34110910-2f87-44b4-b028-74f8972f92be
# ╟─a5a8db8b-c14d-4e0d-8102-a367bc7a022b
# ╠═49a5a52e-6652-4724-a758-de45db08377d
# ╟─ab8b326b-ad96-445e-97d6-5dd8ab68f224
# ╠═92c4155d-c639-4ce8-97e5-9f8bb68ba57c
# ╟─e2deac36-9b92-492d-ac61-502d9714aed2
# ╟─69e31dcc-788a-443e-8532-a69463b470a3
# ╠═50c71109-7918-4ffb-a902-bf9c214c4ee2
# ╠═19d0923c-0450-4007-b8d7-76ec0064a1bb
# ╠═702e85a8-fc89-45bc-8ce2-3cb178eda547
# ╠═65b1bf77-6c35-4b5f-831c-9907829abb70
# ╠═a166d57d-2723-40f2-97a7-e9678d1e3bec
# ╟─44c4ef27-73db-4c87-9cf9-4e3709290cdd
# ╠═05885122-92e3-4052-97fd-6ec815c65e65
# ╟─43f89505-4af3-4a1e-a967-2b92eebb0768
# ╠═546c55ce-be0c-44a1-9f0c-f842d0a9896b
# ╠═9a77d594-9bfe-4988-9387-91b924b30f5d
# ╠═b1d1ad9f-0f02-474b-9177-2d8d0965fac9
# ╠═a9d9fd7d-bc16-48ca-be19-eeb4cbeca899
# ╟─66ab70b5-115b-4e48-9b9c-5c768e4869a5
# ╠═4bc28463-9036-4a3f-bd40-4717334ca1d0
# ╠═817f78d9-24f2-4a6c-aaef-0190a0a5b5a8
# ╠═2152c4d4-35ab-4f06-83d5-4c882a3d3e0a
# ╠═027246a1-2393-49d2-9abe-f7a39c0ff4b9
# ╟─a9e2e3ee-c5d8-4481-94cd-1e7745d1bba9
# ╠═0d53f235-4180-4df3-b123-8dd3eb240f4c
# ╠═f542b846-dc76-421a-9cf1-ef55ddaf4535
# ╟─f72433f1-2411-4c7a-b804-c0485380d444
# ╠═1aae1226-15f0-4f35-8a44-918ab3f2c005
# ╠═824b0730-4129-4473-b02d-47a120076d41
# ╠═3f511575-ec35-4823-97de-17e4609aa271
# ╟─df72b3dc-5cb5-4b2b-a4cc-9d269764346d
# ╟─207a52a3-9e8f-4df3-9e40-eb3fea3cbc78
# ╠═9cb98725-c250-4bb4-b7b3-dbd4f49478a1
# ╟─26a8bea8-235e-48b6-b685-3ef6270d1801
# ╟─042388ff-6c79-4309-a32d-3775688c2557
# ╠═50194e91-5b5f-470d-a558-e6a4388e0015
# ╟─961a68ba-a800-4e86-be66-e05b4557cb9f
# ╠═c37c22cb-baef-43af-905c-8124d88de9c4
# ╟─f5afaa88-616a-4643-9db3-ff12be4c2a9c
# ╟─9c338a22-8939-409c-ac89-9fc0acd2cc6c
# ╠═35890f54-ea48-4cca-acb6-1e9b803f2afc
# ╠═ce6d98ab-cad1-46cc-aef5-f1b85fad8f14
# ╟─ed271d15-c42e-4083-b768-50b5d77ef578
# ╟─36cfc0cd-adb3-427d-a445-a400f8084090
# ╠═01a404b1-d941-42f7-b5ce-d7f6684970d3
# ╠═e3127bbf-c246-4eec-8480-4592ce071cee
# ╠═3923b173-0f94-4de2-8112-907cc479aaf1
# ╠═29388df7-db60-43c2-962a-447cae593500
# ╠═a28039e8-f3f6-44ad-826e-4474375309b7
# ╟─f3549035-c80c-4b98-9c2b-f93c3bb1c7b4
# ╠═45201cfb-a31e-4740-bd82-4541ebc3a86b
# ╠═965a1f3f-8c35-4488-8ed3-41cdcdb2cc3b
# ╠═a340487e-afa0-428e-87eb-a0cd89ef8cc0
# ╟─c435caf9-2232-4969-becc-796ef77a7c8c
# ╠═7ceb96ae-42f8-4361-a56d-635b90a3ec20
# ╟─d8a0fbb1-3d60-4b75-883b-b843327ce2d9
# ╟─0c189181-d0f8-4059-b673-485769d8b80e
# ╟─3bc6de1f-eb5b-4e45-b616-23bb8d5a75cc
# ╠═3ea0f8a1-4114-41b1-adba-ced5fce99d7c
# ╠═70a746fd-29e3-409a-908f-abcd5a495498
# ╠═2d21d130-7eb7-412d-9234-e144e52719a8
# ╠═99aab59e-6978-4dfe-a121-5ae8e06f7ed0
# ╠═276dd17a-3cb5-4ecf-832d-0087d7ec5ee4
# ╠═c61b42a3-a94f-4973-90a5-e8eb276de56a
# ╠═0741c318-2807-4c37-a524-1f8d03e1b6c5
# ╠═bc7d1235-4db5-4275-8807-0257dac2d1a8
# ╠═c6308cea-6719-4183-b418-2ad2f16bfc52
# ╠═f769acf5-5972-4362-87ce-2d33a0aa1bc2
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
