function fish_startup_benchmark --description "Benchmark fish shell startup time"
    set -l iterations 10
    set -l compare false
    set -l show_cache false

    # Parse arguments
    argparse 'n/iterations=' 'c/compare' 's/show-cache' 'h/help' -- $argv
    or return 1

    if set -q _flag_help
        echo "Usage: fish_startup_benchmark [-n NUM] [-c] [-s]"
        echo "  -n, --iterations NUM  Number of iterations (default: 10)"
        echo "  -c, --compare         Compare cached vs uncached"
        echo "  -s, --show-cache      Show cached files"
        return 0
    end

    set -q _flag_iterations; and set iterations $_flag_iterations
    set -q _flag_compare; and set compare true
    set -q _flag_show_cache; and set show_cache true

    # Show cached files if requested
    if $show_cache
        echo "Cached files in $__fish_cache_dir:"
        for f in $__fish_cache_dir/*.fish
            if test -f $f
                printf "  %s (%s)\n" (basename $f) (du -h $f | cut -f1)
            end
        end
        echo
    end

    # Run benchmark
    set -l times
    echo "Running $iterations iterations..."

    for i in (seq $iterations)
        set -l start (date +%s%N)
        fish -ic exit 2>/dev/null
        set -l end (date +%s%N)
        set -a times (math "($end - $start) / 1000000")
        printf "."
    end
    echo

    # Calculate statistics
    set -l sorted (printf '%s\n' $times | sort -n)
    set -l min $sorted[1]
    set -l max $sorted[-1]
    set -l sum 0
    for t in $times
        set sum (math "$sum + $t")
    end
    set -l avg (math "$sum / $iterations")

    echo
    echo "With cache:"
    printf "  Min: %.2f ms\n" $min
    printf "  Max: %.2f ms\n" $max
    printf "  Avg: %.2f ms\n" $avg

    # Compare with uncached if requested
    if $compare
        set -l cache_backup (mktemp -d)
        cp -r $__fish_cache_dir/* $cache_backup/ 2>/dev/null

        set -l uncached_times
        echo
        echo "Running $iterations uncached iterations..."

        for i in (seq $iterations)
            rm -rf $__fish_cache_dir
            mkdir -p $__fish_cache_dir
            set -l start (date +%s%N)
            fish -ic exit 2>/dev/null
            set -l end (date +%s%N)
            set -a uncached_times (math "($end - $start) / 1000000")
            printf "."
        end
        echo

        # Restore cache
        rm -rf $__fish_cache_dir
        mkdir -p $__fish_cache_dir
        cp -r $cache_backup/* $__fish_cache_dir/ 2>/dev/null
        rm -rf $cache_backup

        # Calculate uncached statistics
        set -l uncached_sorted (printf '%s\n' $uncached_times | sort -n)
        set -l uncached_min $uncached_sorted[1]
        set -l uncached_max $uncached_sorted[-1]
        set -l uncached_sum 0
        for t in $uncached_times
            set uncached_sum (math "$uncached_sum + $t")
        end
        set -l uncached_avg (math "$uncached_sum / $iterations")

        echo
        echo "Without cache:"
        printf "  Min: %.2f ms\n" $uncached_min
        printf "  Max: %.2f ms\n" $uncached_max
        printf "  Avg: %.2f ms\n" $uncached_avg

        echo
        set -l savings (math "$uncached_avg - $avg")
        set -l pct (math "100 * $savings / $uncached_avg")
        printf "Savings: %.2f ms (%.1f%% faster)\n" $savings $pct
    end
end
