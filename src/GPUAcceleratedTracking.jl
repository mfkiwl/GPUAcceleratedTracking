module GPUAcceleratedTracking

using
    BenchmarkTools,
    CUDA,
    GNSSSignals,
    StructArrays,
    StaticArrays,
    Parameters,
    Tracking,
    Statistics,
    Dates,
    DataFrames,
    Query,
    PrettyTables,
    Plots,
    PGFPlotsX
    
import Unitful: MHz, kHz, Hz, s, ms, dBHz, ustrip, NoUnits
import Tracking: TrackingState, NumAnts, NumAccumulators

struct KernelAlgorithm{x}
end

KernelAlgorithm(x) = KernelAlgorithm{x}()

const GNSSDICT = Dict(
    "GPSL1" => GPSL1,
    "GPSL5" => GPSL5,
    "GalileoE1B" => GalileoE1B
)

const ALGODICT = Dict(
    # "1_3_pure"                  => 1300,
    # "1_3_pure_textmem"          => 1301,
    # "1_3_cplx"                  => 1320,
    # "1_3_cplx_textmem"          => 1321,
    "1_3_cplx_multi"            => 1320,
    # "1_3_cplx_multi_textmem"    => 1321,
    "1_4_cplx_multi"            => 1420,
    "1_4_cplx_multi_textmem"    => 1421,
    "2_3_cplx_multi"            => 2330,
    "2_3_cplx_multi_textmem"    => 2331,
    "2_4_cplx_multi"            => 2430,
    "2_4_cplx_multi_textmem"    => 2431
)

include("algorithms.jl")
include("reduction.jl")
include("gen_signal.jl")
include("benchmarks.jl")
include("plots.jl")
include("results.jl")

export 
    gen_signal, 
    run_track_benchmark,
    run_kernel_benchmark,
    eval_results,
    plot_min_exec_time,
    reduce_3,
    reduce_4,
    reduce_cplx_3,
    reduce_cplx_4,
    reduce_cplx_multi_3,
    reduce_cplx_multi_4,
    gen_code_replica_kernel!,
    gen_code_replica_strided_kernel!,
    gen_code_replica_texture_mem_kernel!,
    gen_code_replica_texture_mem_strided_kernel!,
    downconvert_strided_kernel!,
    downconvert_and_accumulate_strided_kernel!,
    downconvert_and_correlate_kernel_1!,
    downconvert_and_correlate_kernel_2!,
    downconvert_and_correlate_kernel_3!,
    downconvert_and_correlate_kernel_4!,
    downconvert_and_correlate_kernel_5!,
    downconvert_and_correlate_kernel_6!,
    downconvert_and_correlate_strided_kernel_2!
    # downconvert_and_correlate_isolated_kernel_5!,
    downconvert_and_correlate_strided_kernel_5!,
    cpu_reduce_partial_sum,
    cuda_reduce_partial_sum,
    kernel_algorithm,
    KernelAlgorithm

end