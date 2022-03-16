### A Pluto.jl notebook ###
# v0.18.2

using Markdown
using InteractiveUtils

# ╔═╡ 65c85d2a-a4d0-11ec-1893-b514b0f71b4b
dataRaw = 
"""
Name,Date,Grade,Price
MARYANNA,14/09/2008,A,79700
REBECCA,11/03/2008,B,
ASHELY,5/08/2008,E,24311
KHADIJAH,2/09/2008,,38904
TANJA,1/12/2008,C,47052
JUDIE,17/05/2008,D,34365
NOE,15/08/2008,A,79344
JACALYN,7/10/2008,E,21474
SANDY,5/04/2008,D,
ALEJANDRA,16/12/2008,E,20916
GARY,8/05/2008,C,40081
ROSELEE,29/06/2008,,37661
SAMMIE,5/11/2008,B,61730
,12/12/2008,E,17328
STACEY,24/08/2008,E,24524
RASHIDA,,C,44597
MELINA,22/03/2008,C,41484
CARI,23/12/2008,D,19403
PAIGE,18/07/2008,A,79888
JONNIE,29/03/2008,E,15350
MING,10/11/2008,B,63275
MINERVA,31/07/2008,,45751
ROLF,26/12/2008,D,38267
LUBA,19/07/2008,E,18527
MARISSA,26/09/2008,B,59843
JARRETT,30/11/2008,,41182
COLIN,30/10/2008,E,22953
,1/10/2008,E,20229
ILENE,9/07/2008,E,24609
STARR,26/10/2008,B,63624
KELLYE,28/06/2008,D,31416
JANA,31/10/2008,B,58702
ALEJANDRINA,20/07/2008,E,21775
NOVA,24/06/2008,E,14847
NATALYA,31/08/2008,C,49353
,24/03/2008,E,24633
LEANDRO,18/03/2008,E,23160
MARICA,24/04/2008,C,43187
,13/07/2008,C,46590
MAGARET,1/12/2008,E,19867
MARCELLA,,B,63775
LAMONICA,17/12/2008,E,18790
JUSTINA,19/07/2008,,44818
DELPHINE,21/11/2008,A,77968
PIERRE,4/10/2008,A,77071
SHANELLE,21/03/2008,B,59311
ABBEY,30/09/2008,E,22959
,1/12/2008,B,59571
REANNA,29/07/2008,D,36983
HIROKO,9/10/2008,E,24764
URSULA,6/11/2008,B,58143
KAREEN,22/08/2008,B,59867
,8/07/2008,E,22690
MAX,30/12/2008,A,66994
,19/07/2008,A,77237
DAGMAR,11/12/2008,,64721
LANCE,26/09/2008,A,77852
DREW,1/09/2008,E,17744
EUGENIA,21/09/2008,E,21844
KRISTAL,3/07/2008,D,39815
SHANITA,27/07/2008,,68009
AMIRA,1/11/2008,B,56864
PAM,2/10/2008,E,21269
ARDATH,13/12/2008,A,77062
KAMILAH,1/10/2008,B,
MARILYNN,25/12/2008,D,34159
ODILIA,6/09/2008,D,35782
HORTENCIA,28/04/2008,E,21855
FRANCINE,29/12/2008,,30870
HENRIETTA,20/01/2008,B,
OPAL,18/06/2008,E,24535
QUINN,16/10/2008,E,11401
LANE,5/09/2008,D,38764
,23/09/2008,E,22739
MARY,5/09/2008,C,49847
DANYELL,28/09/2008,D,
STEPHEN,11/02/2008,D,33155
MARGO,23/11/2008,,16976
MANUELA,29/07/2008,E,23329
SLYVIA,27/12/2008,B,
IONE,,D,32972
,7/05/2008,E,14968
KIA,28/08/2008,C,43038
SHONDA,29/08/2008,A,76861
SHARICE,5/11/2008,D,35250
,21/12/2008,D,35296
KATTIE,12/10/2008,C,40210
TAYNA,6/10/2008,E,19153
DANE,15/05/2008,D,37945
CLIFTON,17/10/2008,D,34867
ARDELL,3/03/2008,C,46911
TODD,4/12/2008,B,57588
IGNACIA,14/07/2008,,64343
VALARIE,16/04/2008,C,44873
ROSALYN,30/09/2008,E,23296
DEEANNA,17/04/2008,,17786
BETTE,1/12/2008,E,20481
BROOKS,6/11/2008,C,47930
MAUDIE,28/12/2008,A,76523
PAMELIA,7/05/2008,D,39320
RUDY,30/04/2008,D,37906
KIETH,1/09/2008,C,48826
RICKI,,D,36319
DANETTE,23/03/2008,B,58574
LINDA,20/06/2008,A,79893
BEATRIS,14/11/2008,E,12637
,8/11/2008,C,42163
HERMINE,17/09/2008,D,38799
VIRGEN,4/07/2008,E,20873
ELFRIEDA,10/09/2008,E,23928
ARTURO,9/10/2008,B,62533
JOHNATHAN,18/06/2008,E,23863
VIOLETA,26/04/2008,C,48915
JENIFFER,26/11/2008,D,
,31/10/2008,C,37769
CARLENA,1/07/2008,D,38146
MARI,21/12/2008,B,63060
SPRING,3/03/2008,D,37901
EDMUNDO,19/07/2008,E,24488
RACQUEL,4/09/2008,D,38164
SHARIE,30/06/2008,D,36071
AKIKO,12/11/2008,D,
KIZZIE,21/11/2008,C,
DANITA,14/10/2008,B,54914
RICKIE,30/10/2008,C,42967
JASMINE,13/07/2008,B,57334
ALEXANDRIA,15/11/2008,E,19787
MERIDITH,10/11/2008,C,46235
,20/12/2008,E,19545
LINO,23/10/2008,E,20918
,21/10/2008,E,24175
NINA,22/09/2008,C,43533
,25/04/2008,B,64824
NILSA,5/07/2008,C,47890
SHARITA,20/05/2008,E,21967
,27/07/2008,A,72326
NOAH,10/03/2008,B,59822
SILAS,26/07/2008,D,16522
VELIA,10/10/2008,C,49467
CHARLEY,5/11/2008,D,
ANDREA,17/09/2008,C,49746
YULANDA,27/12/2008,A,71214
CHARLETTE,19/08/2008,C,46964
CHRISTOPER,4/11/2008,C,35449
TAISHA,25/07/2008,C,47515
CAROLINA,21/12/2008,D,28195
DARRELL,30/07/2008,C,46978
DEBRAH,20/06/2008,E,10438
ALLIE,30/11/2008,D,37299
DYAN,9/05/2008,D,38445
CREOLA,26/11/2008,D,38648
ABE,10/07/2008,C,44307
ANTONIO,17/10/2008,E,21374
ELIZEBETH,30/06/2008,E,19906
CAMELIA,27/09/2008,D,37005
SHILA,12/11/2008,E,21797
IRMA,13/09/2008,C,47394
GIL,1/09/2008,D,32371
ELDORA,17/07/2008,E,16196
GWEN,30/08/2008,B,56990
AUGUSTUS,12/08/2008,C,46260
MARY,1/09/2008,D,36148
CHRISTIANA,21/06/2008,E,24381
ELIZBETH,6/07/2008,E,20601
MONTY,10/04/2008,D,35468
CLEVELAND,30/11/2008,B,60869
ZACHARY,2/10/2008,A,76037
KARMA,31/03/2008,C,47754
AUREA,21/06/2008,D,34526
MASON,25/10/2008,D,17379
PORSCHE,22/10/2008,C,43047
DIONNE,12/11/2008,E,19044
RORY,7/10/2008,E,
DONTE,14/08/2008,E,15487
ARVILLA,16/09/2008,E,19660
COLE,15/09/2008,E,24537
,10/08/2008,A,
CRISTY,6/12/2008,C,43025
ELLIS,21/10/2008,A,79231
KAREN,24/03/2008,C,39398
LYNETTA,26/12/2008,C,46980
LARAE,22/10/2008,C,
TRENA,12/06/2008,,37487
RETTA,7/07/2008,E,24073
JEANETTA,29/03/2008,A,73463
SOLANGE,16/11/2008,E,22601
LE,20/07/2008,B,64561
LARRY,14/09/2008,,57075
MENDY,1/09/2008,E,20437
SIDNEY,5/09/2008,D,38977
HENRIETTE,13/08/2008,D,38928
JACKELINE,12/02/2008,E,8257
AZALEE,10/12/2008,C,48429
LORILEE,19/03/2008,E,
PATRINA,20/03/2008,E,20707
DAYSI,12/11/2008,C,39388
CARISA,10/07/2008,E,21586
MARINDA,5/05/2008,D,31062
MERRILEE,6/10/2008,D,35538
RIVA,30/12/2008,E,21842
"""

# ╔═╡ 09915222-fe73-471b-bc2d-f72b1f253455
using DataFrames, CSV

# ╔═╡ 5a5baa31-7c87-41d2-9b87-70b7f3ce13c2
dfFull = CSV.read(IOBuffer(dataRaw), DataFrame)

# ╔═╡ c79e5863-f4bd-4222-8205-6b0d1e8f1064
df = dropmissing(dfFull, :Price) # dropmissing!()

# ╔═╡ 19cb1ad9-31eb-40be-bb8e-efa69be41fae
typeof(df)

# ╔═╡ f842db03-ef3a-4732-94cc-d21113b28a70
gdf = groupby(df, :Grade);

# ╔═╡ 44e137cc-3a39-4353-9e60-16c86fb4dc24
keys(gdf)

# ╔═╡ 9ecb48a8-aae4-4a50-b77f-d872834358c2
gdf[6]

# ╔═╡ 6966c7a9-27ea-49fd-bf98-4e9ce7b6dc17
log(35538)

# ╔═╡ a20943e6-4213-4ed3-9822-695616d5e661
typeof(gdf)

# ╔═╡ 189752a4-9311-43c1-8d70-391f1424642b
using Statistics

# ╔═╡ b56f8098-a912-40ea-a98a-f4593a61863d
combine(gdf, :Price => mean => "均值") # minilanguage

# ╔═╡ 57b60138-b36e-49d8-a8bf-7201f7550a7c
# varinfo(DataFrames)

# ╔═╡ 930fc403-489d-4af8-a59f-5ffe6af6db38
# transform, subset, select, combine 

# ╔═╡ 66d0554b-1aa8-481d-a2d6-498cf0a47ada
md"""
### 为什么样本方差除以 n-1

[帖子](https://likanzhan.github.io/JuliaLearn/notebooks_JuliaBlogs_2022-03-08-Sample_Variance/)
"""

# ╔═╡ 93e636f5-394c-4011-89d9-5a7181ce30fd
using LinearAlgebra

# ╔═╡ c48d3be0-d1a2-40ba-b182-a83951a2207f
function f1(n)
	data = randn(n)           # 标准正态分布的数， μ=0， σ=1
	dev  = data .- mean(data) # 
	devs = dev.^2
	sum(devs)
end

# ╔═╡ 0397717c-0fe4-412e-8ffa-e9743b531e54
mean([f1(17) for i in 1:1000000])

# ╔═╡ 92686bf0-43cd-47d5-99d8-1d7cc5d7c34f
projectionMatrix(n) = Matrix(I, n, n) .- 1 // n 

# ╔═╡ 0dff269c-7265-4b9d-aa53-09942edd8e18
pj = projectionMatrix(5)

# ╔═╡ 22fbefc9-68f4-4034-82f4-9152d1bc894c
dt = collect(1:5)

# ╔═╡ cc36fad1-3b68-4914-8615-019de26f731d
collect(dt')

# ╔═╡ 473ac1d0-a7e9-4216-9a73-ccadec83d3c5
dt'dt == sum(dt .^ 2)

# ╔═╡ 114f7ee6-1d76-4cce-8cf2-ac0361121061
pj * dt == (dt .- mean(dt))

# ╔═╡ 51d038fa-f861-4f9b-9abd-09def6dc024b
a, b = eigen(pj)

# ╔═╡ a91ca513-4d48-460f-89cf-e585866bdb74
a

# ╔═╡ 87c4da47-e9d5-4401-8d0f-1b60764d962b
am = diagm(a)

# ╔═╡ e133b4f2-0620-4cab-bc16-0efe267e4cb9
b

# ╔═╡ cc72f2be-5372-4bd7-a8d7-68d4c8562aa7
b * am * b' ≈ pj

# ╔═╡ 38e351be-f47c-4908-adda-577f33237b62
md"""
$$||PQx||^2 = ||Q\Lambda x||^2 = ||\Lambda x|^2 = x_2^2 + \cdots + x_n^2$$
"""

# ╔═╡ f4bc01a8-bae9-43c1-b7bc-6a2f3bb88b6b
function f2(n)
	X  = randn(n)
	Prj = projectionMatrix(n)
	LV, _ = eigen(Prj)
	LM = diagm(LV)
	LX = LM * X  # Dev = Px == PQx == QΛQ'Qx == QΛx == Λx == x_2 + ... + x_n
	return LX'LX # LX * LX == sum(LX .^ 2)
end

# ╔═╡ d16a1967-02ea-416e-8e8a-81a294e1a886
mean([f2(17) for i in 1:1000000])

# ╔═╡ 37c4cb0b-fe31-4700-828c-b65f674a9c27
md"""
- [原文链接](https://github.com/mitmath/1806/blob/master/notes/Sample%20Variance%20division%20by%20n-1.ipynb)
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[compat]
CSV = "~0.10.3"
DataFrames = "~1.3.2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.2"
manifest_format = "2.0"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.CSV]]
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "SentinelArrays", "Tables", "Unicode", "WeakRefStrings"]
git-tree-sha1 = "9310d9495c1eb2e4fa1955dd478660e2ecab1fbb"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.10.3"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "ded953804d019afa9a3f98981d99b33e3db7b6da"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.0"

[[deps.Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "96b0bc6c52df76506efc8a441c6cf1adcb1babc4"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.42.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "cc70b17275652eb47bc9e5f81635981f13cea5c8"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.9.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Reexport", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "ae02104e835f219b8930c7664b8012c93475c340"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.3.2"

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

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.FilePathsBase]]
deps = ["Compat", "Dates", "Mmap", "Printf", "Test", "UUIDs"]
git-tree-sha1 = "04d13bfa8ef11720c24e4d840c0033d145537df7"
uuid = "48062228-2e41-5def-b9a4-89aafe57970f"
version = "0.9.17"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.InlineStrings]]
deps = ["Parsers"]
git-tree-sha1 = "61feba885fac3a407465726d0c330b3055df897f"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.1.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InvertedIndices]]
git-tree-sha1 = "bee5f1ef5bf65df56bdd2e40447590b272a5471f"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.1.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

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

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "85b5da0fa43588c75bb1ff986493443f821c70b7"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.2.3"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "db3a23166af8aebf4db5ef87ac5b00d36eb771e2"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.0"

[[deps.PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "dfb54c4e414caa595a1f2ed759b160f5a3ddcba5"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.3.1"

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

[[deps.SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "6a2f7d70512d205ca8c7ee31bfa9f142fe74310c"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.3.12"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

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

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits", "Test"]
git-tree-sha1 = "5ce79ce186cc678bbb5c5681ca3379d1ddae11a1"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.7.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "216b95ea110b5972db65aa90f88d8d89dcb8851c"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.6"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.WeakRefStrings]]
deps = ["DataAPI", "InlineStrings", "Parsers"]
git-tree-sha1 = "b1be2855ed9ed8eac54e5caff2afcdb442d52c23"
uuid = "ea10d353-3f73-51f8-a26c-33c1cb351aa5"
version = "1.4.2"

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
# ╟─f5450eab-0f9f-4b7f-9b80-992d3c553ba9
# ╟─65c85d2a-a4d0-11ec-1893-b514b0f71b4b
# ╠═09915222-fe73-471b-bc2d-f72b1f253455
# ╠═5a5baa31-7c87-41d2-9b87-70b7f3ce13c2
# ╠═c79e5863-f4bd-4222-8205-6b0d1e8f1064
# ╠═19cb1ad9-31eb-40be-bb8e-efa69be41fae
# ╠═f842db03-ef3a-4732-94cc-d21113b28a70
# ╠═44e137cc-3a39-4353-9e60-16c86fb4dc24
# ╠═9ecb48a8-aae4-4a50-b77f-d872834358c2
# ╠═6966c7a9-27ea-49fd-bf98-4e9ce7b6dc17
# ╠═a20943e6-4213-4ed3-9822-695616d5e661
# ╠═189752a4-9311-43c1-8d70-391f1424642b
# ╠═b56f8098-a912-40ea-a98a-f4593a61863d
# ╠═57b60138-b36e-49d8-a8bf-7201f7550a7c
# ╠═930fc403-489d-4af8-a59f-5ffe6af6db38
# ╟─66d0554b-1aa8-481d-a2d6-498cf0a47ada
# ╠═93e636f5-394c-4011-89d9-5a7181ce30fd
# ╠═c48d3be0-d1a2-40ba-b182-a83951a2207f
# ╠═0397717c-0fe4-412e-8ffa-e9743b531e54
# ╠═92686bf0-43cd-47d5-99d8-1d7cc5d7c34f
# ╠═0dff269c-7265-4b9d-aa53-09942edd8e18
# ╠═22fbefc9-68f4-4034-82f4-9152d1bc894c
# ╠═cc36fad1-3b68-4914-8615-019de26f731d
# ╠═473ac1d0-a7e9-4216-9a73-ccadec83d3c5
# ╠═114f7ee6-1d76-4cce-8cf2-ac0361121061
# ╠═51d038fa-f861-4f9b-9abd-09def6dc024b
# ╠═a91ca513-4d48-460f-89cf-e585866bdb74
# ╠═87c4da47-e9d5-4401-8d0f-1b60764d962b
# ╠═e133b4f2-0620-4cab-bc16-0efe267e4cb9
# ╠═cc72f2be-5372-4bd7-a8d7-68d4c8562aa7
# ╟─38e351be-f47c-4908-adda-577f33237b62
# ╠═f4bc01a8-bae9-43c1-b7bc-6a2f3bb88b6b
# ╠═d16a1967-02ea-416e-8e8a-81a294e1a886
# ╟─37c4cb0b-fe31-4700-828c-b65f674a9c27
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
