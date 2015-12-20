# Cinchcli
A very opinionated Ruby library for parsing CLI input. Extracted from my simple_configure project.

## What exactly is Cinchcli?
Cinchcli at its core is a command line parsing library combined with a little bit of magic. It takes a very declarative approach to building CLI tools. You describe your CLI tool in a JSON file. Cinchcli takes that json file and Ruby's `ARGV` as parameters and builds a scaffold for your CLI tool. It outputs a Hash of options parsed from the CLI input if the CLI input is valid or else it outputs a help message. It allows you to focus only on the core of your CLI tool instead of focusing on parsing CLI options. 

## Installation
You can install Cinchcli by running
```
gem install cinchcli
```

## Documentation
To use Cinchcli in a project, first install it and then require the `cinchcli` module
```ruby
require 'simple_cli`
```

This should provide you access to the `Cinchcli` module. `Cinchcli` module has a `CinchCliBuilder` class that can be used to develop a CLI parser. `CinchCliBuilder` takes in two arguments. First one is a json file and the second one is the `ARGV` parameter from Ruby. Here is a simple CLI tool using this method

```ruby
#!/usr/bin/env ruby

# This code was taken from https://github.com/lsegal/yard/blob/master/bin/yard. The code is licensed under the MIT License.

# We do all this work just to find the proper load path
path = __FILE__
while File.symlink?(path)
  path = File.expand_path(File.readlink(path), File.dirname(path))
end
$:.unshift(File.join(File.dirname(File.expand_path(path)), '..', 'lib'))

require 'testcli'
require 'simple_cli'

parsed_cli_args = CinchCliBuilder.new("testcli.json",ARGV)
TestCli.run(parsed_cli_args)
```

### JSON File Format

This file is at the heart of Cinchcli. You declare all the parts of your CLI tool in this JSON file. This file helps the `CinchCliBuilder` to extract information from the CLI input and present it to the tool in a meaningful way. The following are the available options that can be included inside the JSON file. 

1. **name** - required - Name of the command line tool. This will be displayed in the automatically generated help message. 
2. **description** - required - Description of the command line tool. This will be displayed in the automatically generated help message. 
3. **commands** - required - This parameter should be a JSON object with all the commands in the command line tool. 

## Errors
Cinchcli is built from the ground up to make your command line tool error free. It will do a lot of error checking while your tool is in development. So you might run into the following errors when you use Cinchcli with your CLI tool. The error messages are in the process of being rewritten to make it explicit that these are errors caused by developers not the users. 

### JSONFileNonExistantError
This error indicates that the JSON file provided doesn't exist. With out the JSON file, `simple_cli` cannot proceed any further. 

### UnParsableJSONError
This error indicates that the JSON file provided is not a valid JSON. Please use a tool like http://jsonlint.com/ to fix the problems with your JSON. 

### EmptyJSONError
This error indicates that the JSON file provided is empty.There is nothing in a empty JSON file to configure `simple_cli`. So please add some configurations into that JSON file. 

### NoNameError
This error indicates that the `name` parameter is missing from the JSON file. The `name` parameter is very important because it will be displayed in the automatically generated help message. 
