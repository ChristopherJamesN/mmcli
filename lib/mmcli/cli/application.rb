require 'thor'
require 'fileutils'

module Mmcli
 module Cli
   class Application < Thor
     include Thor::Actions

     desc 'mmcli <manifestname> [options] <filename>', 'Creates <manifestname> manifest if it does not already exists, and adds (-a) or deletes (-d) the specified <filename> from the manifest.'
     option :l
     option :d
     option :a
     option :h
     def mmcli(manifest, file = nil)
       if File.exist?(manifest)
         f = File.open(manifest, "r+")
       else
         f = File.new(manifest, "w")
       end
       if options[:d]
         File.open("output_file", "w") do |out_file|
            File.foreach(manifest) do |line|
              out_file.puts line unless line.chomp == file
            end
          end
        FileUtils.mv("output_file", manifest)
       elsif options[:a]
         if File.exist?(file)
           File.open(manifest, "a") do |line|
             line.puts "#{file}"
           end
           puts "Files successfully added to manifest."
         else
           puts "Error: could not find specified files."
         end
       end
       puts "#{f.read}" if options[:l]
       puts "-l to list the files in the manifest \n -a to add a file or files to the manifest \n -d to delete a file or files from the manifest \n -h for help" if options[:h]
       f.close
     end
   end
 end
end
