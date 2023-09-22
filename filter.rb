require 'rexml/document'
include REXML

# Parse the results.xml file
file = File.new('results_thin.xml')
doc = Document.new(file)

# Find all <TestResult> elements in the document
test_results = XPath.match(doc, './/xccdf:rule-result', {"xccdf" => "http://checklists.nist.gov/xccdf/1.2"})
score = XPath.match(doc, './/xccdf:score', {"xccdf" => "http://checklists.nist.gov/xccdf/1.2"})

puts score.first.text

pass_list = []
fail_list = []

# Iterate over the test results and extract the result value
test_results.each do |result|
    idref     = result.attributes['idref'] || 'unknown'
    weight    = result.attributes['weight'] || 'unknown'
    severity  = result.attributes['severity'] || 'unknown'
    result_elem = XPath.first(result, './/xccdf:result', {"xccdf" => "http://checklists.nist.gov/xccdf/1.2"})
    
    if !result_elem.nil?
        result_value = result_elem.text
        puts "Rule ID: #{idref}\nResult: #{result_value}\n"
        
        if result_value == 'pass'
            pass_list << idref
        elsif result_value == 'fail'
            fail_list << idref
        end
    end
end

# Print the pass and fail lists
puts "Pass list:\n#{pass_list}\n"
puts "--------------------------------"
puts "Fail
