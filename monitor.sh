# Function to print header
print_header() {
    printf "name\tCPU\tmem\tmem_pc\tIO\n"
}

# Function to print container stats
print_stats() {
    docker stats --no-stream --format "{{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.MemPerc}}\t{{.NetIO}}"
}

# Main function
main() {
    output_file="docker_stats_$(date +'%Y-%m-%d_%H-%M-%S').log"
    touch "$output_file"
    print_header >> "$output_file"
    while true; do
        print_stats $(docker ps --format "{{.ID}}") >> "$output_file"
        sleep 1
    done
}

main
