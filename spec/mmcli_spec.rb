RSpec.describe Mmcli do
  it "has a version number" do
    expect(Mmcli::VERSION).not_to be nil
  end

  it "1. Can create and/or update the provided manifest file." do
  end

  it "2. Each path in the manifest file should be on a separate line." do
  end

  it "3. Can list items in the manifest file in a case-insensitive alphabetical order." do
  end

  it "4. When the add option is specified, the specified path(s) should be added to the manifest file only if all the paths are files that actually exist.  It should fail otherwise." do
  end

  it "5. When the delete option is specified, the specified path(s) should be removed from the manifest file or ignored if they are not in the manifest." do
  end

  it "6. Does not accept the delete and add option at the same time." do
  end

  it "7. Can accept the list(-l) option with any other option.  If list is specified, it shows the manifest content after executing the other actions." do
  end

  it "8. Can print a success message if it executed successfully." do
  end

  it "9. Can print a failure message if it failed to execute." do
  end




end
