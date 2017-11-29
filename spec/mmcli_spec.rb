RSpec.describe Mmcli do

  it "has a version number" do
    expect(Mmcli::VERSION).not_to be nil
  end

  describe ".mmcli" do

    it "Can create and/or update the provided manifest file." do
      args = ["mmcli", "-a", "b1.txt"]
      options = Mmcli::Cli::Application.start(args)
      expect(options).to eq({ "a" => true })
    end

    it "Each path in the manifest file should be on a separate line." do
    end

    it "Can list items in the manifest file in a case-insensitive alphabetical order." do
    end

    it "When the add option is specified, the specified path(s) should be added to the manifest file only if all the paths are files that actually exist.  It should fail otherwise." do
    end

    it "When the delete option is specified, the specified path(s) should be removed from the manifest file or ignored if they are not in the manifest." do
    end

    it "Does not accept the delete and add option at the same time." do
    end

    it "Can accept the list(-l) option with any other option.  If list is specified, it shows the manifest content after executing the other actions." do
    end

    it "Can print a success message if it executed successfully." do
    end

    it "Can print a failure message if it failed to execute." do
    end

  end
end
