### A Pluto.jl notebook ###
# v0.18.1

using Markdown
using InteractiveUtils

# ╔═╡ b0a8cdb0-11c6-4819-81f3-3b6f624f00c6
using Test

# ╔═╡ 31ae0a9d-50c4-4188-a263-ac45295460dd
using PlutoUI; TableOfContents(title="目录")

# ╔═╡ f9df2424-de50-4147-9a8e-99aaf85e0805
md"""
### 重定义运算符
"""

# ╔═╡ 149a7f06-9dac-426b-a71e-b07cdbf22e0c
md"""
- 表达式 `a - b = 1` 重新定义了符号 `-` 的一个方法， 该方法有两个参数 `a` 和 `b`， 函数的返回值为 1. 当然能够重新定义的前提是该符号在当前工作区中尚没有被调用。 例如
"""

# ╔═╡ cd4147b1-6ad0-47cb-8b2b-dae35e466254
let
	git_tree-sha1 = "8eb7b4d4ca487caade9ba3e85932e28ce6d6e1f8"
	"`2 - 3` 的值是 `$(2 - 3)`"
end

# ╔═╡ 20324cbf-c483-4efe-afac-c48aa907a0aa
md"""
类似的， 下面函数中， 当 `x` 小于 5 时， 输出结果为 `3 - 1`。 但在该环境中运算符 `-` 被重新定义了， 其输出值为 3000：
"""

# ╔═╡ d9b302c2-19d2-44ff-a592-07589b068eb8
let
	function f(x)
		my_cool-variable = 3000
		if x > 5
			return my_cool_variable
		else
			return 3 - 1
		end
	end
	f(2)
end


# ╔═╡ a5c9145c-838f-45ab-a396-83fa0bd24382
md"""
- 运算符 `-` 也可以是一个一元运算符。 重新定义后也会出现类似的结果：
"""

# ╔═╡ 6b81a803-1422-42aa-b0f1-e737120f29bc
let
	-a = 10 # 等价于 `-(a) = 10`
	-(50)
	# 1 - 2   # 报错
end

# ╔═╡ 28746bba-69ea-4294-9710-fb2ec4091a5f
with_terminal(dump, quote -a = 10 end)

# ╔═╡ 3921a5a7-da7e-4de8-9eda-6c6ca2362791
md"""
重启 REPL 或重新绑定原来定义即 `- = Base.:-` 可解决上述问题 （优选方法为前者）。 另外一个教训是函数名称尽量不要用中划线。
"""

# ╔═╡ 64a99c9c-a87b-487a-83e0-c6246f8e3f89
md"""
- 另外一个例子是对常数的重新定义：
"""

# ╔═╡ 0209c1d8-86a9-4147-bfba-cae3ae37c55e
let
	e = 9
	2e, 
	2e+0, 
	2e+8
end

# ╔═╡ ef9da34a-1c12-4786-835f-c57a449d6b85
md"""
### 运算顺序
"""

# ╔═╡ 467ec32a-9edb-4a7b-86f6-d4e377fe4324
md"""
- `&` 和 `|` 的优先级高于 `==` (数值越大优先级越高)
"""

# ╔═╡ 823329bc-31ee-4e95-9799-a4da4fe761e2
 Base.operator_precedence.([ :&, :|, :(==) ])

# ╔═╡ 5fe506eb-4c28-49cf-9c5e-1413da15cf87
1 == 3 & 1 == 1 # 等价于 1 == （3 & 1） == 1

# ╔═╡ fd46025a-26a7-4220-83eb-86e0956d3632
md"""
可用括号改变运算顺序， 得到通常想要的结果：
"""

# ╔═╡ 2bb45a1a-b7bb-40d7-894f-b4ed178058c1
(1 == 3) & (1 == 1)

# ╔═╡ 01bfe70d-e264-43bd-996a-edc187784184
md"""
- 加号 `+` 的优先级高于 `:`, 所以：
"""

# ╔═╡ 43204061-7158-4ac9-952c-0c958da17341
 Base.operator_precedence.([:+, :(:)])

# ╔═╡ 8631d9dc-d1bb-4b2a-9998-ec02a931e9a7
1:2 .+3 # 结果是 `1:5`， 而不是 `4:5`。 要得到后者， 应该用括号改变运算顺序：

# ╔═╡ f6bb2ca0-2375-432d-b6f6-336bb334318e
(1:2) .+ 3

# ╔═╡ 747a5517-0875-40d8-85f9-99c549265644
md"""
-  数对 （`=>`） 和匿名函数 (`->`)， 例如
"""

# ╔═╡ 84bebf53-f1e7-48d9-a544-5750ce627195
:a => x -> x => :b  # 等价于:

# ╔═╡ ab4b15ff-3fb5-47cc-b6c2-58e298b42cfb
:a => (x -> x => :b) # 而非: 

# ╔═╡ f989588b-9811-45d6-b6fe-f6e8d4485e9d
:a => (x -> x) => :b

# ╔═╡ ca8122d5-52cf-494f-a788-160b9002333a
md"""
`DataFrames.jl` 会经常遇到上述情况， 例如
```
source_column => (x -> some_anonymous_function_body) => target_column_name
```
"""

# ╔═╡ 52380b14-91f2-4473-a152-3cd7cc629ea0
md"""
### 函数
"""

# ╔═╡ 63382c3c-6a62-43bc-80f5-c70cbabe59c3
(1)(2) # 等价于 `1 * 2`

# ╔═╡ f0f0a812-c53a-489a-ad46-48c01f9a6c9e
with_terminal(dump, quote
	(1)(2)
end
)

# ╔═╡ 139cf65f-d97d-404d-90dc-d93cf04ee087
let
	x = 1
	(x)(2) #  被解读成一个函数
end

# ╔═╡ 2b54feef-7447-4999-8599-8a787aaa33bd
with_terminal(dump, quote
	(x)(2)
end
)

# ╔═╡ 602b2043-1ea7-4b65-b91c-f4e6afd86f38
let
	x = 1
	(x::Int)(y) = x * y  # 但是可以通过函数名称的类型声明使上述函数合法化。
	(x)(2)
end

# ╔═╡ eebeb094-b34b-4d44-97ca-6db686c5d179
let
	x = 1
	(s::Symbol)(x) = getproperty(x, s) # 这是另外一个例子。
	:im(1-im)
end

# ╔═╡ 7f4fffb1-68c1-4ea2-bba6-b14511ee6fd4
md"""
- 匿名函数
"""

# ╔═╡ a01c3f60-f6e9-46ba-a774-3de875df0e39
function (YOLO) #  是一个匿名函数。
	YOLO + 1
end

# ╔═╡ 0d68ec71-3062-463c-bf59-b21bcf20e924
(function (YOLO)
	YOLO + 1
end)(5) # 所以可以直接被调用

# ╔═╡ 2f51d34a-35ef-4737-895b-d2a440ddaaed
ff = function (YOLO)
	YOLO + 1
end # 也可以存储为一个变量后， 在调用：

# ╔═╡ 6123a34b-696c-4c7e-9de9-fa3c21867d3f
ff(5)

# ╔═╡ 046a9b0a-fdb9-4dbc-b0ad-03eb66ac8ff9
md"""
### 引用
"""

# ╔═╡ f414d3b4-7fa7-4efe-a225-5fdc4068db31
:a === "a"

# ╔═╡ 9a90d0f4-4430-4cda-b0f2-b054b3f696e7
:2 === 2

# ╔═╡ 8ad3a10c-7a39-451b-9337-e2b89cfc2f64
:1234567890123456789 === 1234567890123456789

# ╔═╡ 579ad49d-d623-46b5-be32-13d82e86b19e
:12345678901234567890 === 12345678901234567890

# ╔═╡ aa60a151-4292-447f-9e18-e90c3ea1af31
md"""
### 随机
"""

# ╔═╡ 4fbab4bb-3a07-47ce-982a-0a36a5311cea
with_terminal() do
	@testset begin   # 宏 @testset 会默认设定一个 `RNG`
	         x = rand()
	         @testset for i in 1:10
	           y = rand()
	           @test x == y
	         end
	end
end

# ╔═╡ 055b0d58-cf91-4aa7-aff7-f834eb3912e9
let
	nums = zeros(Int, 10);
	for nums[rand(1:10)] in 1:20
	end
	nums
end

# ╔═╡ 58000e73-0428-4da1-9db3-9d9fec184a77
md"""
- 
"""

# ╔═╡ 76356eee-bdfe-461e-8d72-a46039567b54
append!([1, 2, 3], "4")

# ╔═╡ 24f81fa0-b969-4287-a120-b3beb846aa91
push!([1, 2, 3], '4')

# ╔═╡ 466e10ad-ec0d-4f7a-9512-a764dbe99519
let
	x = [1, 2, 3];
	x[3] = '4';
	x
end

# ╔═╡ 6cdaafff-f8d5-4fa0-9e54-d3c6718e44b0
copyto!([1, 2, 3], "456")

# ╔═╡ 3bc00b30-f83e-4bbb-ba10-c0efa69cf678
md"""
### 其他
"""

# ╔═╡ 038b5b99-3f57-4edb-b9b5-26075978b796
arr1 = reshape(1.0:4.0, 2, 2)

# ╔═╡ 94869e78-5e8a-4437-95f9-7d72d334db63
arr2 = zeros(2, 2)

# ╔═╡ 8e30e576-410d-46d0-8537-3f626b6131bf
arr2 .= arr1[:, :2]

# ╔═╡ 5ab73cbc-b973-4109-a427-a6a5fff07e99
arr2 .= arr1[:, 1:2]

# ╔═╡ d9682fab-d7bc-480e-b3e7-a2a703c942fe
first(1, 2)

# ╔═╡ b043b189-e45c-4512-929c-399a12b9e200
1[1][1][1]

# ╔═╡ 81f052ce-9c44-11ec-1977-19672ef88a51
all([] .== [2]), all([] .≈ [2])

# ╔═╡ b8e812d2-ec4b-41a8-bd20-bc4aa66ee04f
begin

struct PseudoClass{T}
	data::T
end

(o::PseudoClass)(f, args...; kwargs...) = f(o.data, args...; kwargs...)

var"'ᶜ" = PseudoClass

# my_thing'ᶜ(stuff)'ᶜ(more_stuff, an_argument)'ᶜ(final_stuff; a_keyword_argument)
end

# ╔═╡ 8b9381c0-dc5e-4f62-9697-e17da2d9b441
md"""
### 附录
"""

# ╔═╡ f0243d2a-5764-4631-ab03-b49a2523874c
md"""
参考文献
- [Julia Wats](https://miguelraz.github.io/blog/juliawats/)
- [Confused by Julia](https://bkamins.github.io/julialang/2022/03/04/wat.html)
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[compat]
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
# ╟─f9df2424-de50-4147-9a8e-99aaf85e0805
# ╟─149a7f06-9dac-426b-a71e-b07cdbf22e0c
# ╠═cd4147b1-6ad0-47cb-8b2b-dae35e466254
# ╟─20324cbf-c483-4efe-afac-c48aa907a0aa
# ╠═d9b302c2-19d2-44ff-a592-07589b068eb8
# ╟─a5c9145c-838f-45ab-a396-83fa0bd24382
# ╠═6b81a803-1422-42aa-b0f1-e737120f29bc
# ╠═28746bba-69ea-4294-9710-fb2ec4091a5f
# ╟─3921a5a7-da7e-4de8-9eda-6c6ca2362791
# ╟─64a99c9c-a87b-487a-83e0-c6246f8e3f89
# ╠═0209c1d8-86a9-4147-bfba-cae3ae37c55e
# ╟─ef9da34a-1c12-4786-835f-c57a449d6b85
# ╟─467ec32a-9edb-4a7b-86f6-d4e377fe4324
# ╠═823329bc-31ee-4e95-9799-a4da4fe761e2
# ╠═5fe506eb-4c28-49cf-9c5e-1413da15cf87
# ╟─fd46025a-26a7-4220-83eb-86e0956d3632
# ╠═2bb45a1a-b7bb-40d7-894f-b4ed178058c1
# ╟─01bfe70d-e264-43bd-996a-edc187784184
# ╠═43204061-7158-4ac9-952c-0c958da17341
# ╠═8631d9dc-d1bb-4b2a-9998-ec02a931e9a7
# ╠═f6bb2ca0-2375-432d-b6f6-336bb334318e
# ╟─747a5517-0875-40d8-85f9-99c549265644
# ╠═84bebf53-f1e7-48d9-a544-5750ce627195
# ╠═ab4b15ff-3fb5-47cc-b6c2-58e298b42cfb
# ╠═f989588b-9811-45d6-b6fe-f6e8d4485e9d
# ╟─ca8122d5-52cf-494f-a788-160b9002333a
# ╟─52380b14-91f2-4473-a152-3cd7cc629ea0
# ╠═63382c3c-6a62-43bc-80f5-c70cbabe59c3
# ╠═f0f0a812-c53a-489a-ad46-48c01f9a6c9e
# ╠═139cf65f-d97d-404d-90dc-d93cf04ee087
# ╠═2b54feef-7447-4999-8599-8a787aaa33bd
# ╠═602b2043-1ea7-4b65-b91c-f4e6afd86f38
# ╠═eebeb094-b34b-4d44-97ca-6db686c5d179
# ╟─7f4fffb1-68c1-4ea2-bba6-b14511ee6fd4
# ╠═a01c3f60-f6e9-46ba-a774-3de875df0e39
# ╠═0d68ec71-3062-463c-bf59-b21bcf20e924
# ╠═2f51d34a-35ef-4737-895b-d2a440ddaaed
# ╠═6123a34b-696c-4c7e-9de9-fa3c21867d3f
# ╟─046a9b0a-fdb9-4dbc-b0ad-03eb66ac8ff9
# ╠═f414d3b4-7fa7-4efe-a225-5fdc4068db31
# ╠═9a90d0f4-4430-4cda-b0f2-b054b3f696e7
# ╠═8ad3a10c-7a39-451b-9337-e2b89cfc2f64
# ╠═579ad49d-d623-46b5-be32-13d82e86b19e
# ╟─aa60a151-4292-447f-9e18-e90c3ea1af31
# ╠═b0a8cdb0-11c6-4819-81f3-3b6f624f00c6
# ╠═4fbab4bb-3a07-47ce-982a-0a36a5311cea
# ╠═055b0d58-cf91-4aa7-aff7-f834eb3912e9
# ╠═58000e73-0428-4da1-9db3-9d9fec184a77
# ╠═76356eee-bdfe-461e-8d72-a46039567b54
# ╠═24f81fa0-b969-4287-a120-b3beb846aa91
# ╠═466e10ad-ec0d-4f7a-9512-a764dbe99519
# ╠═6cdaafff-f8d5-4fa0-9e54-d3c6718e44b0
# ╟─3bc00b30-f83e-4bbb-ba10-c0efa69cf678
# ╠═038b5b99-3f57-4edb-b9b5-26075978b796
# ╠═94869e78-5e8a-4437-95f9-7d72d334db63
# ╠═8e30e576-410d-46d0-8537-3f626b6131bf
# ╠═5ab73cbc-b973-4109-a427-a6a5fff07e99
# ╠═d9682fab-d7bc-480e-b3e7-a2a703c942fe
# ╠═b043b189-e45c-4512-929c-399a12b9e200
# ╠═81f052ce-9c44-11ec-1977-19672ef88a51
# ╠═b8e812d2-ec4b-41a8-bd20-bc4aa66ee04f
# ╟─8b9381c0-dc5e-4f62-9697-e17da2d9b441
# ╟─f0243d2a-5764-4631-ab03-b49a2523874c
# ╠═31ae0a9d-50c4-4188-a263-ac45295460dd
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
