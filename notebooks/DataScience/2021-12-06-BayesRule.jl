### A Pluto.jl notebook ###
# v0.17.3

using Markdown
using InteractiveUtils

# ╔═╡ 3fa1cb6c-57ba-11ec-2c5c-b7abde85aab5
using Random

# ╔═╡ 9abd6b98-b43e-452f-bcf9-db60849db35f
using PlutoUI

# ╔═╡ debdf0d4-50e6-491a-bcb8-c723efe27d52
with_terminal(() -> versioninfo())

# ╔═╡ bb053ceb-dd52-4950-8966-43322bd05f1c
N = 10^5

# ╔═╡ febf80b7-6958-4648-9598-c30b211f8472
p₁, ϵ₀, ϵ₁ = .7, .1, .05 #\epsilon

# ╔═╡ 8c80a6be-b896-4ce8-9d59-18a2f18f229f
# @doc xor # exclusive or

# ╔═╡ 3e50b67a-ea5c-4e1f-8955-b9d09f9f8d49
# @doc | # inclusive or

# ╔═╡ c5cc273c-4867-41bb-a297-1f92ec165ed6
[true | true; xor(true, true)]

# ╔═╡ c16127e6-241b-4173-afbc-3ed74488fa48
# cond ? A : B 等价于： if cond; return A; else return B end

# ╔═╡ 2062fde5-c7b4-4555-a2ac-dc8a97f09466
Random.seed!(0)

# ╔═╡ 82500cb3-7717-4a57-84ac-ad5c74bdf709
TxData = rand(N) .< p₁;

# ╔═╡ 9bb83079-6ce5-46da-90d8-28e2af4bfc35
flipWithProb(bit, prob) = rand() < prob ? Bool(xor(bit, 1)) : Bool(bit);

# ╔═╡ 1c57f28f-63df-45af-9c01-d796d76d44b7
RxData = [ !x ? flipWithProb(x, ϵ₀) : flipWithProb(x, ϵ₁) for x in TxData];

# ╔═╡ 8f896959-1275-4ac2-aec2-80e3ce1e6a08
# x == 0 等价于 ！x

# ╔═╡ dc544ae1-a0ce-44b0-b065-97b0c55c9092
begin
	numTx1, totalRx1 = 0, 0
	for i in 1:N
		if RxData[i] == 1
			global totalRx1 += 1
			global numTx1 += TxData[i] 
		end
	end
end

# ╔═╡ 2669a026-9266-4d42-931d-d6555a818827
[sum(RxData) == totalRx1; sum(TxData[RxData]) == numTx1]

# ╔═╡ ec17fee7-0a20-4eb5-b810-5a6281ff8f5e
numTx1 / totalRx1

# ╔═╡ 38d8ebbe-f97b-4545-9828-280f932724ea
0.7(1 - ϵ₁) / (0.7(1 - ϵ₁) + 0.3ϵ₀)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[compat]
PlutoUI = "~0.7.21"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.0"
manifest_format = "2.0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "abb72771fd8895a7ebd83d5632dc4b989b022b5b"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

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
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

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

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "ae4bbcadb2906ccc085cf52ac286dc1377dceccc"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.1.2"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "b68904528fd538f1cb6a3fbc44d2abdc498f9e8e"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.21"

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

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╠═3fa1cb6c-57ba-11ec-2c5c-b7abde85aab5
# ╠═9abd6b98-b43e-452f-bcf9-db60849db35f
# ╠═debdf0d4-50e6-491a-bcb8-c723efe27d52
# ╠═bb053ceb-dd52-4950-8966-43322bd05f1c
# ╠═febf80b7-6958-4648-9598-c30b211f8472
# ╠═8c80a6be-b896-4ce8-9d59-18a2f18f229f
# ╠═3e50b67a-ea5c-4e1f-8955-b9d09f9f8d49
# ╠═c5cc273c-4867-41bb-a297-1f92ec165ed6
# ╠═c16127e6-241b-4173-afbc-3ed74488fa48
# ╠═2062fde5-c7b4-4555-a2ac-dc8a97f09466
# ╠═82500cb3-7717-4a57-84ac-ad5c74bdf709
# ╠═9bb83079-6ce5-46da-90d8-28e2af4bfc35
# ╠═1c57f28f-63df-45af-9c01-d796d76d44b7
# ╠═8f896959-1275-4ac2-aec2-80e3ce1e6a08
# ╠═dc544ae1-a0ce-44b0-b065-97b0c55c9092
# ╠═2669a026-9266-4d42-931d-d6555a818827
# ╠═ec17fee7-0a20-4eb5-b810-5a6281ff8f5e
# ╠═38d8ebbe-f97b-4545-9828-280f932724ea
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
