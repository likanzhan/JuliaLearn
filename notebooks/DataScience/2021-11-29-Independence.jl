### A Pluto.jl notebook ###
# v0.17.2

using Markdown
using InteractiveUtils

# ╔═╡ 1c13cb6b-8994-47a9-b27a-d4ae14053cf9
using Random; Random.seed!(1)

# ╔═╡ ee68c3e9-f386-4e14-a78b-3f31914c66a8
using SpecialFunctions

# ╔═╡ f9352584-523c-11ec-3358-15d4f17a587c
numbers = 10:25

# ╔═╡ 48cab159-0958-4be4-9854-2d505f38d55d
firstDigit(x) = Int(floor(x/10))

# ╔═╡ e7912062-884f-4fb2-a700-dcdcc6015f8f
round(11/10) # floor, ceil, round, trim

# ╔═╡ b41def87-be84-4744-bc2e-33876970c0d2
typeof(Int32(1.0))

# ╔═╡ aa0364bc-5f06-46cb-9225-6c5f8a9c3d50
190 >> 2 

# ╔═╡ dc33ae02-17f4-491e-b9eb-097bba342558
[bitstring(Int16(190));  bitstring(Int16(190 >> 2))]

# ╔═╡ d0ac71fa-1978-4798-bf0b-69fd2bf5324f
secondDigit(x) = x%10

# ╔═╡ 31f455d8-8582-4f30-b1ca-ba28ff5eec8b
firstDigit.(numbers)

# ╔═╡ e9b6a740-86ad-48a7-b8b0-3f88a56b29f0
secondDigit.(numbers)

# ╔═╡ 95fd874e-6f86-4f34-ad1f-4eef0120cdce
@. secondDigit(numbers)

# ╔═╡ 1864de0f-0379-48c5-aa68-172db325f51e
N = 10^7

# ╔═╡ f622d359-5470-4d43-8fe9-de95357deb7f
numThirteen, numFirstIsOne, numSecondIsThree = [], [], [];

# ╔═╡ affae706-bc6c-4dee-ab10-0d82e4878b80
for _ in 1:N
	X = rand(numbers)
	push!(numThirteen, X == 13)
	push!(numFirstIsOne, firstDigit(X) == 1)
	push!(numSecondIsThree, secondDigit(X) == 3)
end

# ╔═╡ aa241b18-b83b-4223-927f-4b90fd3ba276
md"""
- 选到数字十三的概率为 ： $(sum(numThirteen)/N)
- 第一个字符为1的概率为： $(sum(numFirstIsOne)/N)
- 第二个字符为3的概率为： $(sum(numSecondIsThree)/N)
"""

# ╔═╡ f989729d-1e6a-4c22-a18c-8d152ee20754
let
	numThirteen, numFirstIsOne, numSecondIsThree = 0, 0, 0;
	for _ in 1:N
		X = rand(numbers)
		numThirteen      += X == 13
		numFirstIsOne    += firstDigit(X) == 1
		numSecondIsThree += secondDigit(X) == 3
	end
	(numThirteen, numFirstIsOne, numSecondIsThree) ./ N
end

# ╔═╡ 94be092a-257f-4c49-b239-112c20fb7923
probAgivenB(k) = 1 - 1/(k+1)

# ╔═╡ 5fab0b42-8bf4-4801-acc5-416012cff1cc
probB(k) = 6 / (π*(k+1))^2

# ╔═╡ 43c43cee-1fee-4879-9cc0-f0647be8a68a
sum([probAgivenB(k)*probB(k) for k in 0:10^7])

# ╔═╡ 9c8a2827-82de-4faf-9745-7232e36a5c56
analytic = 1-2zeta(3)/π^2

# ╔═╡ 556d1ac0-f73e-47c7-8014-bf20d371e856
x=4; 4x # 更简洁的写法

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[compat]
SpecialFunctions = "~2.0.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.0"
manifest_format = "2.0"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "f885e7e7c124f8c92650d61b9477b9ac2ee607dd"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.11.1"

[[deps.ChangesOfVariables]]
deps = ["LinearAlgebra", "Test"]
git-tree-sha1 = "9a1d594397670492219635b35a3d830b04730d62"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.1"

[[deps.Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "dce3e3fea680869eaa0b774b2e8343e9ff442313"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.40.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

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

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "642a199af8b68253517b80bd3bfd17eb4e84df6e"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.3.0"

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

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "be9eef9f9d78cecb6f262f3c10da151a6c5ab827"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.5"

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

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00cfd92944ca9c760982747e9a1d0d5d86ab1e5a"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.2"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "e08890d19787ec25029113e88c34ec20cac1c91e"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.0.0"

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
# ╠═f9352584-523c-11ec-3358-15d4f17a587c
# ╠═48cab159-0958-4be4-9854-2d505f38d55d
# ╠═e7912062-884f-4fb2-a700-dcdcc6015f8f
# ╠═b41def87-be84-4744-bc2e-33876970c0d2
# ╠═aa0364bc-5f06-46cb-9225-6c5f8a9c3d50
# ╠═dc33ae02-17f4-491e-b9eb-097bba342558
# ╠═d0ac71fa-1978-4798-bf0b-69fd2bf5324f
# ╠═31f455d8-8582-4f30-b1ca-ba28ff5eec8b
# ╠═e9b6a740-86ad-48a7-b8b0-3f88a56b29f0
# ╠═95fd874e-6f86-4f34-ad1f-4eef0120cdce
# ╠═1864de0f-0379-48c5-aa68-172db325f51e
# ╠═1c13cb6b-8994-47a9-b27a-d4ae14053cf9
# ╠═f622d359-5470-4d43-8fe9-de95357deb7f
# ╠═affae706-bc6c-4dee-ab10-0d82e4878b80
# ╟─aa241b18-b83b-4223-927f-4b90fd3ba276
# ╠═f989729d-1e6a-4c22-a18c-8d152ee20754
# ╠═94be092a-257f-4c49-b239-112c20fb7923
# ╠═5fab0b42-8bf4-4801-acc5-416012cff1cc
# ╠═43c43cee-1fee-4879-9cc0-f0647be8a68a
# ╠═ee68c3e9-f386-4e14-a78b-3f31914c66a8
# ╠═9c8a2827-82de-4faf-9745-7232e36a5c56
# ╠═556d1ac0-f73e-47c7-8014-bf20d371e856
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
