require 'thor'
require 'fileutils'
require 'tempfile'
require 'find'

module Mmcli
 module Cli
   class Application < Thor
     include Thor::Actions

     global_option :h

     desc 'mmcli <manifestname> [options] <filename>', 'Creates <manifestname> manifest if it does not already exists, and adds (-a) or deletes (-d) the specified <filename> from the manifest.'
     option :d
     option :a
     option :l

       def mmcli(manifest)

         if (options[:a] && options[:d])
           puts "You cannot specify both the add and delete option simulatenously."
           return
         end

         if File.exist?(manifest)
           f = File.open(manifest, "r+")
         else
           f = File.new(manifest, "w")
         end

         if options[:d]
           delete(manifest, options[:d], options[:l])
         elsif options[:a]
            add(manifest, options[:a], options[:l])
         end

         if options[:l]
           list(manifest)
         end

         if options[:h]
           help
         end

         f.close
       end

      no_commands {
       def delete (manifest, option_d, option_l = nil)
         txt_file_paths = []
         if option_l
           Find.find(option_l) do |path|
             txt_file_paths << path if path =~ /.*\.txt$/
           end
         else
           Find.find(option_d) do |path|
             txt_file_paths << path if path =~ /.*\.txt$/
           end
         end
         tmp = Tempfile.new("extract")
         open(manifest, "r").each {|l| tmp << l unless (l.chomp == option_d || l.chomp == option_l || l.chomp == txt_file_paths[0]) }
         tmp.close
         FileUtils.mv(tmp.path, manifest)
       end

       def add (manifest, option_a, option_l = nil)
         if option_l
           if File.exist?(option_l)
             File.open(manifest, "a") do |line|
               txt_file_paths = []
               Find.find(option_l) do |path|
                 txt_file_paths << path if path =~ /.*\.txt$/
               end
               line.puts "#{txt_file_paths[0]}"
             end
             puts "Files successfully added to manifest."
           else
             puts "Error: could not find specified files."
           end
         elsif File.exist?(option_a)
            File.open(manifest, "a") do |line|
              txt_file_paths = []
              Find.find(option_a) do |path|
                txt_file_paths << path if path =~ /.*\.txt$/
              end
              line.puts "#{txt_file_paths[0]}"
            end
            puts "Files successfully added to manifest."
          else
            puts "Error: could not find specified files."
          end
       end

       def list(manifest)
         new_array = File.readlines(manifest).sort
          File.open(manifest,"w") do |line|
            new_array.each {|n| line.puts(n)}
          end
          puts File.read(manifest)
       end

       def help
         puts "-l to list the files in the manifest \n -a to add a file or files to the manifest \n -d to delete a file or files from the manifest \n -h for help"
       end
     }

   end
 end
end
