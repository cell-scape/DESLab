#! /usr/bin/env julia

using Plots

bit_len(f) = length(read(open(f))) * 8
bit_diff(f1, f2) = count('1', join(bitstring(b) for b in read(open(f1)) .⊻ read(open(f2))))


function main()
    F0 = "F0"
    F0_len = bit_len(F0)
    nfiles = 11
    files = ["F$(i)" for i in 1:nfiles]
    bit_differences = [bit_diff(F0, Fn) for Fn in files]
    diff_ratios = [diff / F0_len for diff in bit_differences]

    #=
    p1 = scatter(1:nfiles, bit_differences,
                 title="Bit Difference in DES Encrypted Image by Bit Difference in Key",
                 xlabel="Key Bit Difference",
                 ylabel="Image Bit Differnence",
                 legend=false)
    p2 = scatter(1:nfiles, diff_ratios,
                 title="Bit Difference Ratio by Bit Difference in Key",
                 xlabel="Key Bit Difference",
                 ylabel="Bit difference / Bit length",
                 legend=false)
    plot(p1, p2, size=(2000, 1000))
    =#

    println("Absolute bit differences:\n$(bit_differences)")
    println("Mean Absolute Difference: $(mean(bit_differences))\n")
    println("Bit difference ratios:\n$(diff_ratios)")
    println("Average bit difference ratio: $(mean(diff_ratios))")
end

main()
