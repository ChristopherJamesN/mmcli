require 'thor'
require 'fileutils'
require 'tempfile'

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
         tmp = Tempfile.new("extract")
         open(manifest, "r").each {|l| tmp << l unless l.chomp == file}
         tmp.close
         FileUtils.mv(tmp.path, manifest)
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
       if options[:l]
         new_array = File.readlines(manifest).sort
          File.open(manifest,"w") do |line|
            new_array.each {|n| line.puts(n)}
          end
          puts File.read(manifest)
        end
       puts "-l to list the files in the manifest \n -a to add a file or files to the manifest \n -d to delete a file or files from the manifest \n -h for help" if options[:h]
       f.close
     end
   end
 end
end