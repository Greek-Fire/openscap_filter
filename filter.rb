require 'nokogiri'

doc = Nokogiri::XML(File.open('results_thin.xml'))

test_results = doc.xpath('//xccdf:rule-result', 'xccdf' => 'http://checklists.nist.gov/xccdf/1.2')
score = doc.xpath('//xccdf:score', 'xccdf' => 'http://checklists.nist.gov/xccdf/1.2')

puts score.first.text

pass_list = []
fail_list = []

test_results.each do |result|
    idref     = result['idref'] || 'unknown'
    weight    = result['weight'] || 'unknown'
    severity  = result['severity'] || 'unknown'
    result_elem = result.at_xpath('.//xccdf:result', 'xccdf' => 'http://checklists.nist.gov/xccdf/1.2')

    unless result_elem.nil?
        result_value = result_elem.text
        puts "Rule ID: #{idref}\nResult: #{result_value}\n"
        
        if result_value == 'pass'
            pass_list << idref
        elsif result_value == 'fail'
            fail_list << idref
        end
    end
end

puts "Pass list:\n#{pass_list}\n"
puts "--------------------------------"
puts "Fail list:\n#{fail_list}\n"
