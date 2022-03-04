### A Pluto.jl notebook ###
# v0.18.1

using Markdown
using InteractiveUtils

# ╔═╡ eb30c73f-4f60-4fc4-8166-1da11585e628
using PlutoUI

# ╔═╡ 858936b7-5ac7-42c0-8aa9-df1cbfe9d1f6
md"""
### 引用不总产生 `Expr` 类型
"""

# ╔═╡ 8c57aa1f-5c18-4292-b62c-f4909d1d4818
md"""
代码引用是通过 `:( )` 来实现的， 例如： 
"""

# ╔═╡ c8715a3a-9b04-11ec-04de-eb78afd78215
typeof( :(1) ),
typeof( :(:x) ),
typeof( :(x) ),
typeof( :(1 + x) ),
typeof( quote 1 + x end )

# ╔═╡ ef39222a-0c18-4eae-b883-88eff1015077
md"""
### 不同类型的 `Expr` 类型
"""

# ╔═╡ 9f26dc3f-509f-451c-b0ef-b70aee06bfc0
with_terminal() do
	dump( :(1 + x) ) 
end

# ╔═╡ 898c0633-f722-4c84-b568-06795c047e6a
with_terminal() do
	dump( :( sin(x) ) ) 
end

# ╔═╡ f4091b2c-24c1-423d-af18-16cee421c552
with_terminal() do
	dump( :( x == y ) )
end

# ╔═╡ af589ba9-02e0-4334-8b3c-c9fec4d4635f
with_terminal() do
	dump(
    quote
        let x = 1
            x + 1
        end
    end
	)
end

# ╔═╡ ad714b6b-5f1a-4027-962c-dcd5d43a98ed
import MacroTools: rmlines

# ╔═╡ 3dd1474b-43d0-4aab-b27e-2256a0fe3156
with_terminal() do
	dump(
		rmlines(
	    quote
	        let x = 1
	            x + 1
	        end
	    end
		)
	)
end

# ╔═╡ 6eda4169-a034-42a9-a15b-4157421e7cba
md"""
对象 `Expr` 的类型是非常多的， 这个 [gist](https://gist.github.com/johnmyleswhite/17d8e897e995874ce04f2fc102b59991) 列出了Julia基础包中 `Expr` 的类型及相对频率。 Julia [编译器](https://github.com/JuliaLang/julia/blob/a645d7f256c2d1634869fa927c90d4e282ff0a47/src/ast.scm#L75) 给出了所有可能类型。
"""

# ╔═╡ 8362af9b-534f-429a-9f7c-c79eef64840d
:(x - y) == Expr(:call, :-, :x, :y)

# ╔═╡ dd8be7b8-a8b8-4629-97f3-3748e79761fa
:(sin(x)) == Expr(:call, :sin, :x)

# ╔═╡ b6e13d5e-7937-4918-a44d-fdf24e39785b
:(1 + sin(x)) == Expr(:call, :+, 1, Expr(:call, :sin, :x))

# ╔═╡ 80d488fa-8588-486a-b9ec-26544d2449bc
md"""
### 引用和伪引用
"""

# ╔═╡ 268e84f3-bd32-4e9d-9d65-ee72a5d3d00c
md"""
由 `:( )` 和 `quote`  定义的引用和宏对其参数的引用是不同的。 前者执行的是伪引用 （[quasiquotation](https://courses.cs.washington.edu/courses/cse341/04wi/lectures/14-scheme-quote.html)）， 而后者则是真的引用。 二者的区别在于对插入（[interpolation](https://docs.julialang.org/en/v1/manual/metaprogramming/#man-expression-interpolation-1)）的处理。 在伪引用中， 美元符号 `$` 可被用于在引用表达式内插入值。 而在真正引用中， 美元符号只是被调用而不会执行插入操作。 例如：
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

# ╔═╡ 8919b66e-4f3e-474b-8a9e-8d1afa7ab757
(
:(1 + $x),                       # 伪引用
Expr(:call, :+, 1, Expr(:$, :x)) # 真引用
)

# ╔═╡ ceb8e016-9225-4560-b97a-fdfbdf2d3cdd
:x, typeof( :(x) )

# ╔═╡ 0bb9c96e-be5b-45b3-954f-23a41a895c48
:(:x), typeof( :(:x) )

# ╔═╡ 8802e2e4-11ea-48d8-929b-145944f4c4d8
macro true_quote(e)
	QuoteNode(e)
end

# ╔═╡ c27aafb7-b211-4a6e-b013-01a98bb57a54
let y = :x
	(
		@true_quote(1 + $y),
		:(1 + $y),
	)
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
# ╟─858936b7-5ac7-42c0-8aa9-df1cbfe9d1f6
# ╠═8c57aa1f-5c18-4292-b62c-f4909d1d4818
# ╠═c8715a3a-9b04-11ec-04de-eb78afd78215
# ╟─ef39222a-0c18-4eae-b883-88eff1015077
# ╠═9f26dc3f-509f-451c-b0ef-b70aee06bfc0
# ╠═898c0633-f722-4c84-b568-06795c047e6a
# ╠═f4091b2c-24c1-423d-af18-16cee421c552
# ╠═af589ba9-02e0-4334-8b3c-c9fec4d4635f
# ╠═ad714b6b-5f1a-4027-962c-dcd5d43a98ed
# ╠═3dd1474b-43d0-4aab-b27e-2256a0fe3156
# ╟─6eda4169-a034-42a9-a15b-4157421e7cba
# ╠═8362af9b-534f-429a-9f7c-c79eef64840d
# ╠═dd8be7b8-a8b8-4629-97f3-3748e79761fa
# ╠═b6e13d5e-7937-4918-a44d-fdf24e39785b
# ╟─80d488fa-8588-486a-b9ec-26544d2449bc
# ╟─268e84f3-bd32-4e9d-9d65-ee72a5d3d00c
# ╠═ed3ea5e5-7aaa-4738-8cb3-31015308812f
# ╠═5fad2af8-e8b6-4eff-99a0-04c5080f044b
# ╠═4e17c358-6788-4b98-a650-70f785698fb3
# ╠═8919b66e-4f3e-474b-8a9e-8d1afa7ab757
# ╠═ceb8e016-9225-4560-b97a-fdfbdf2d3cdd
# ╠═0bb9c96e-be5b-45b3-954f-23a41a895c48
# ╠═8802e2e4-11ea-48d8-929b-145944f4c4d8
# ╠═c27aafb7-b211-4a6e-b013-01a98bb57a54
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
