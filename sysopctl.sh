#!/bin/bash
# sysopctl - v0.1.0
# A system management utility for Linux systems

VERSION="v0.1.0"

# Function to display help
show_help() {
    echo "sysopctl - A system resource management tool"
    echo "Usage: sysopctl [command] [options]"
    echo "Commands:"
    echo "  service list            List all active services"
    echo "  service start <name>    Start a service"
    echo "  service stop <name>     Stop a service"
    echo "  system load             Display system load"
    echo "  disk usage              Show disk usage"
    echo "  process monitor         Monitor system processes"
    echo "  logs analyze            Analyze recent logs"
    echo "  backup <path>           Backup system files from <path>"
    echo "  --help                  Show this help message"
    echo "  --version               Show command version"
}

# Function to show version
show_version() {
    echo "sysopctl version $VERSION"
}

# List running services
list_services() {
    systemctl list-units --type=service
}

# Start a service
start_service() {
    systemctl start "$1"
    echo "Started service: $1"
}

# Stop a service
stop_service() {
    systemctl stop "$1"
    echo "Stopped service: $1"
}

# Show system load
system_load() {
    uptime
}

# Show disk usage
disk_usage() {
    df -h
}

# Monitor system processes
process_monitor() {
    top
}

# Analyze system logs
logs_analyze() {
    journalctl -p crit
}

# Backup system files
backup_files() {
    rsync -a "$1" /backup/
    echo "Backup of $1 completed."
}

# Parse command-line arguments
case "$1" in
    --help)
        show_help
        ;;
    --version)
        show_version
        ;;
    service)
        case "$2" in
            list)
                list_services
                ;;
            start)
                start_service "$3"
                ;;
            stop)
                stop_service "$3"
                ;;
            *)
                echo "Invalid service command"
                ;;
        esac
        ;;
    system)
        case "$2" in
            load)
                system_load
                ;;
            *)
                echo "Invalid system command"
                ;;
        esac
        ;;
    disk)
        case "$2" in
            usage)
                disk_usage
                ;;
            *)
                echo "Invalid disk command"
                ;;
        esac
        ;;
    process)
        case "$2" in
            monitor)
                process_monitor
                ;;
            *)
                echo "Invalid process command"
                ;;
        esac
        ;;
    logs)
        case "$2" in
            analyze)
                logs_analyze
                ;;
            *)
                echo "Invalid logs command"
                ;;
        esac
        ;;
    backup)
        backup_files "$2"
        ;;
    *)
        echo "Unknown command"
        show_help
        ;;
esac
