require_relative "../../lib/cinchcli"

parsed_cli_args = CinchCliBuilder.new("../json_files/non_array_commands_field.json",ARGV)
