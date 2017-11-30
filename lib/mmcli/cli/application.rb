require 'thor'
require 'fileutils'
require 'tempfile'
require 'find'

module Mmcli
 module Cli
   class Application < Thor
     include Thor::Actions

     class_option :h
     class_option :l, :type => :array, :lazy_default => []
     class_option :d, :type => :array, :lazy_default => []
     class_option :a, :type => :array, :lazy_default => []

     desc 'mmcli <manifestname> [options] <filename>', 'Creates <manifestname> manifest if it does not already exists, and adds (-a) or deletes (-d) the specified <filename> from the manifest.'

       def mmcli(manifest = "pwd.man")

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
           if options[:l] && options[:d].length == 0
             options[:l].each do |option_l|
               delete(manifest, option_l, options[:d])
             end
           else
             options[:d].each do |option_d|
               delete(manifest, option_d, options[:l])
             end
           end
         elsif options[:a]
           if options[:l] && options[:a].length == 0
             options[:l].each do |option_l|
              add(manifest, option_l, options[:a])
             end
           else
             options[:a].each do |option_a|
              add(manifest, option_a, options[:l])
             end
           end
         end

         if options[:l]
           list(manifest)
         end

         if options[:h]
           help
         end

         f.close
       end
       #default_task :mmcli

      no_commands {
       def delete (manifest, option_d, option_l = nil)
         txt_file_paths = []
         if File.exist?(option_d)
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
         if File.exist?(option_a)
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
         puts "Usage: mmcli mmcli <manifestname> [options] <filename>\n-l to list the files in the manifest \n-a to add a file or files to the manifest \n-d to delete a file or files from the manifest \n-h for help"
       end
     }

   end
 end
end
