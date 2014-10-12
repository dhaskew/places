
describe EnoteParser do
  it "should parse an enote" do
    note = File.read("spec/support/test_note.xml")
    parsed_note = EnoteParser.parse note
    expect( parsed_note.visits.count ).to eq 8
    expect( parsed_note.locations.count ).to eq 6
    expect( parsed_note.locations[0] ).to eq parsed_note.visits[0]
    expect( parsed_note.visits[0][:name]).to eq "Elaine Quinilty"
    expect( parsed_note.visits[0][:address]).to eq "25105 Plantation Dr NE, Atlanta, GA"
    expect( parsed_note.visits[1][:name]).to eq "Moe's"
    expect( parsed_note.visits[1][:address]).to eq "2311 North Druid Hills Rd NE, Atlanta, GA"
    expect( parsed_note.visits[0][:mins]).to eq 1169
    expect( parsed_note.visits[1][:mins]).to eq 7
  end
end

