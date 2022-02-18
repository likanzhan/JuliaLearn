### A Pluto.jl notebook ###
# v0.18.0

using Markdown
using InteractiveUtils

# ╔═╡ f5450eab-0f9f-4b7f-9b80-992d3c553ba9


# ╔═╡ e52fb531-f61c-48ee-a89c-75d709aff352
md"""
### 什么是闭包
"""

# ╔═╡ 19db28b8-8e35-11ec-2874-9baeb6e306eb
md"""
闭包 （closures） 为一个可被调用的对象。 该对象某些字段存储了某些捕获变量 (captured variable)。 例如：
"""

# ╔═╡ b1d97bad-e368-4385-9137-248cc1decc51
begin
	
# 定义一个名为 `myType` 组合类型， 该类型有一个字段 `x`， 用于存储捕获变量。	
struct myType1
	x
end

# 定义名为 `myObject1` 的函数， 函数名称 `myObject1` 的类型为 `myType1`:
(myObject1::myType1)(y) = myObject1.x + y

end

# ╔═╡ cca38e2d-b60d-4a15-8d9e-702d1fd8c39b
md"""
创立一个类型为 `myType1` 的对象 `myFun1`：
"""

# ╔═╡ f00824df-f1f5-4e75-bf32-2cde8157759e
myFun1 = myType1(1)

# ╔═╡ 173804dd-d9c9-46c5-8940-bf5a7489827d
md"""
因为对象的类型为 `myType`， 所以该对象可以调用 `myFun` 定义的方法：
"""

# ╔═╡ cd997ceb-5dcf-4c03-9baa-c2b5c9cc8d76
myFun1(100)

# ╔═╡ ca345408-7039-4fda-a475-74424b4a311f
md"""
因为对象 `myObject` 的类型为 `myType`。 该对象还有一个字段 `x`, 其存储值即为捕获变量。
"""

# ╔═╡ acd5a05c-b591-4735-9d1c-2fe131fa00ea
[typeof(myFun1), propertynames(myFun1), myFun1.x]

# ╔═╡ 239e731d-5e24-45f2-938f-3536a6ae1cb1
md"""
对象 `myObject` 既能作为函数名称被调用， 其字段又存储了相关信息， 被称为闭包 (Closure)。 另外，捕获变量是可以被更新的， 例如：
"""

# ╔═╡ 7af9f469-729c-497d-8cc5-8017f23a12cf
begin	
	struct myType2
		x::AbstractVector
	end

	function (myObject2::myType2)(y)
		push!(myObject2.x, y)
		return y
	end
end

# ╔═╡ 532ce315-de12-4ac5-8192-e2871c7da0ef
myFun2 = myType2([1])

# ╔═╡ feb25e4d-c6a8-4e1a-acb4-603fa2d108c2
myFun2.x

# ╔═╡ 33a3ec76-a89f-4412-a678-983bab4d2489
[myFun2(10), myFun2.x]

# ╔═╡ f9401e24-31a9-46e0-9360-262cfac67d7f
[myFun2(100), myFun2.x]

# ╔═╡ dbcb4507-2548-486e-95dc-3e50775d1849
[myFun2(100), myFun2.x]

# ╔═╡ b8a11358-bdfc-457c-a384-24546cfb33df
md"""
函数和闭包: 在嵌套函数中，若下层函数中包含自由变量，该自由变量需要在上层函数域中获得赋值，此时该自由变量就会并变成捕获变量。此处上层函数实际上是产生闭包的句法糖 (Syntactic Sugar)。 例如下面的代码 ([官方文档](https://docs.julialang.org/en/v1/devdocs/functions/#Closures))

```julia
function adder(x)
    return y -> x + y
end
```
大体上会被底层化为

```julia
struct ##1{T}
    x::T
end

(_::##1)(y) = _.x + y

function adder(x)
    return ##1(x)
end
```

例如：
"""

# ╔═╡ 30473e78-4b06-4be4-a508-491db3787d5a
f1(x) = y -> x + y

# ╔═╡ 37c8baf2-d4c5-4e38-8f7a-e962a2f6d741
f2 = f1(10) # 闭包

# ╔═╡ e4771b91-cfcf-4748-9111-fd433e6adb78
[typeof(f2), propertynames(f2), f2(20), f2.x]

# ╔═╡ 83d4d90e-475f-4fe7-a9f1-dc6e819d068f
md"""
我们可以用下面的方式运行该函数：
"""

# ╔═╡ 9667af3b-db43-4dfd-a2d9-6b3a92ea95a5
eval(Expr(:new, typeof(f2), 22))

# ╔═╡ d8aeb420-4bea-426d-a38e-ffcaba27da79
eval(Expr(:new, typeof(f2), 10))(20)

# ╔═╡ 0d80fdbb-974c-4fe9-bf70-fdb20777f60a
md"""
又例如：
"""

# ╔═╡ ff168444-5ec2-4bed-8330-50556b416cd2
function f3()
	x = 1
	return (y, z) -> x + y + z
end

# ╔═╡ 3864c5b5-543b-48d2-bc09-7fa6ae224e7b
f3().x

# ╔═╡ 10d36758-a879-4b27-93be-6d0fe2f6138a
 f4 = f3()

# ╔═╡ a1603d93-7f38-41c1-8493-b0da82ad96db
f4.x

# ╔═╡ f5b9b9ed-00cd-4d6c-8bf4-e4b5f28c7861
f4(2, 3)

# ╔═╡ c1682a46-b5ca-4f06-94b8-f576f6b8a1ef
f4.x

# ╔═╡ 8f5f490a-cc99-4e7e-a3de-1d69c9269c5f
md"""
进一步阅读： [__What is a "closure" in Julia?__](https://stackoverflow.com/questions/70969919/what-is-a-closure-in-julia)
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.2"
manifest_format = "2.0"

[deps]
"""

# ╔═╡ Cell order:
# ╟─f5450eab-0f9f-4b7f-9b80-992d3c553ba9
# ╟─e52fb531-f61c-48ee-a89c-75d709aff352
# ╟─19db28b8-8e35-11ec-2874-9baeb6e306eb
# ╠═b1d97bad-e368-4385-9137-248cc1decc51
# ╟─cca38e2d-b60d-4a15-8d9e-702d1fd8c39b
# ╠═f00824df-f1f5-4e75-bf32-2cde8157759e
# ╟─173804dd-d9c9-46c5-8940-bf5a7489827d
# ╠═cd997ceb-5dcf-4c03-9baa-c2b5c9cc8d76
# ╟─ca345408-7039-4fda-a475-74424b4a311f
# ╠═acd5a05c-b591-4735-9d1c-2fe131fa00ea
# ╟─239e731d-5e24-45f2-938f-3536a6ae1cb1
# ╠═7af9f469-729c-497d-8cc5-8017f23a12cf
# ╠═532ce315-de12-4ac5-8192-e2871c7da0ef
# ╠═feb25e4d-c6a8-4e1a-acb4-603fa2d108c2
# ╠═33a3ec76-a89f-4412-a678-983bab4d2489
# ╠═f9401e24-31a9-46e0-9360-262cfac67d7f
# ╠═dbcb4507-2548-486e-95dc-3e50775d1849
# ╟─b8a11358-bdfc-457c-a384-24546cfb33df
# ╠═30473e78-4b06-4be4-a508-491db3787d5a
# ╠═37c8baf2-d4c5-4e38-8f7a-e962a2f6d741
# ╠═e4771b91-cfcf-4748-9111-fd433e6adb78
# ╟─83d4d90e-475f-4fe7-a9f1-dc6e819d068f
# ╠═9667af3b-db43-4dfd-a2d9-6b3a92ea95a5
# ╠═d8aeb420-4bea-426d-a38e-ffcaba27da79
# ╟─0d80fdbb-974c-4fe9-bf70-fdb20777f60a
# ╠═ff168444-5ec2-4bed-8330-50556b416cd2
# ╠═3864c5b5-543b-48d2-bc09-7fa6ae224e7b
# ╠═10d36758-a879-4b27-93be-6d0fe2f6138a
# ╠═a1603d93-7f38-41c1-8493-b0da82ad96db
# ╠═f5b9b9ed-00cd-4d6c-8bf4-e4b5f28c7861
# ╠═c1682a46-b5ca-4f06-94b8-f576f6b8a1ef
# ╟─8f5f490a-cc99-4e7e-a3de-1d69c9269c5f
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
