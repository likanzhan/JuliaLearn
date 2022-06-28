### A Pluto.jl notebook ###
# v0.19.9

using Markdown
using InteractiveUtils

# ╔═╡ d1303f54-9d1e-492f-97d4-1bd747f5b025
md"""
#### 先看两个例子
"""

# ╔═╡ a8c14b06-dc71-4688-ad0e-6172bdc9a783
function test1(A)
    n = size(A, 2)
    for k in 1:n
        for i in k+1:n
            A[i, k] /= A[k, k]
        end
    end
    A
end

# ╔═╡ d66b5e3b-53ae-43c4-a578-73e0460757f5
function test2(A)
    n = size(A, 2)
    for k in 1:n
        A[k+1:n, k] ./= A[k,k]
    end
    A
end

# ╔═╡ f5892677-a7e2-4428-a1c5-a9a43b8b0266
A = rand(10000, 10000);

# ╔═╡ 21086989-1e7a-4315-8699-65d63c34dc51
B, C, D, E, F = copy(A), copy(A), copy(A), copy(A), copy(A);

# ╔═╡ 24681ebd-4116-4c66-ad35-c926b9e9aeb1
@allocated test1(B)

# ╔═╡ 4cbc2d17-34e9-4bc7-bbe0-abad1b3bb198
@allocated test2(C)

# ╔═╡ fd3c70da-923a-4adf-aa9a-40c90e5f2c98
B == C

# ╔═╡ 6e39a11f-c293-4730-91a2-6c86a3b2357f
md"""
#### 为什么版本二比版本一占用内存？
"""

# ╔═╡ 90ff3380-2386-4c90-a173-e769575010a6
md"""
在 Julia 语言中 `A[k+1:n, k]` 执行的函数是 `getindex`。 如果 `getindex` 需要获取 `>1` 个数值， 那么他就需指派一个新的数组， 并把数值复制到这个数组中。

```julia
A[k+1:n, k] ./= A[k,k]
A[k+1:n, k]  .= A[k+1:n, k] ./ A[k,k]
broadcast!(/, A[k+1:n, k], A[k+1:n, k], A[k,k])

broadcast!(/, @view(A[k+1:n, k]), A[k+1:n, k], A[k,k])
```

"""

# ╔═╡ 9e52903d-e798-49a3-8624-858a1d70084d
md"""

与此相对， 函数 `view` 则不产生复制。 `@view` 和 `@views` 的区别在于：前者用括号对方括号句法执行 `view` 而不是 `getindex`；而后者则是对所有方括号句法执行 `view`。例如，

```julia
broadcast!(/, @view(A[k+1:n, k]), @view(A[k+1:n, k]), A[k,k])
A[k+1:n, k] .= @view(A[k+1:n, k]) ./ A[k,k]

@view(A[k+1:n, k]) ./= A[k,k]
@views A[k+1:n, k] ./= A[k,k]
```
"""

# ╔═╡ e45c7a19-e8de-4fb4-970c-412f1fded5e0
md"""
下面是一个不占用内存的版本：
"""

# ╔═╡ 2a33f660-6021-4f90-8bc6-e54068ce16da
function test2_fix(A)
    n = size(A, 2)
    for k in 1:n
		A[k+1:n, k] .= @view(A[k+1:n, k]) ./ A[k,k]
    end
    A
end

# ╔═╡ 98d8fe71-9c0b-46a9-8d27-3867ae1e746f
@allocated test2_fix(E)

# ╔═╡ Cell order:
# ╟─f5450eab-0f9f-4b7f-9b80-992d3c553ba9
# ╟─d1303f54-9d1e-492f-97d4-1bd747f5b025
# ╠═a8c14b06-dc71-4688-ad0e-6172bdc9a783
# ╠═d66b5e3b-53ae-43c4-a578-73e0460757f5
# ╠═f5892677-a7e2-4428-a1c5-a9a43b8b0266
# ╠═21086989-1e7a-4315-8699-65d63c34dc51
# ╠═24681ebd-4116-4c66-ad35-c926b9e9aeb1
# ╠═4cbc2d17-34e9-4bc7-bbe0-abad1b3bb198
# ╠═fd3c70da-923a-4adf-aa9a-40c90e5f2c98
# ╟─6e39a11f-c293-4730-91a2-6c86a3b2357f
# ╟─90ff3380-2386-4c90-a173-e769575010a6
# ╟─9e52903d-e798-49a3-8624-858a1d70084d
# ╟─e45c7a19-e8de-4fb4-970c-412f1fded5e0
# ╠═2a33f660-6021-4f90-8bc6-e54068ce16da
# ╠═98d8fe71-9c0b-46a9-8d27-3867ae1e746f
