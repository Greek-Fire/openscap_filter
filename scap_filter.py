import xml.etree.ElementTree as ET

# Parse the results.xml file
tree = ET.parse('results_thin.xml')
root = tree.getroot()


# Find all <TestResult> elements in the document
test_results = root.findall('.//{http://checklists.nist.gov/xccdf/1.2}rule-result')
score = root.findall('.//{http://checklists.nist.gov/xccdf/1.2}score')

print(score[0].text)

pass_list = []
fail_list = []

# Iterate over the test results and extract the result value
for result in test_results:
    idref     = result.attrib.get('idref','unkown')
    weight    = result.attrib.get('weight','unkown')
    severity  = result.attrib.get('severity','unkown')
    result_elem = result.find('.//{http://checklists.nist.gov/xccdf/1.2}result')
    #cce_id = result.find('.//{http://checklists.nist.gov/xccdf/1.2}ident')
    #if cce_id is not None:
    #    print(cce_id.text)

    if result_elem is not None:
        result_value = result_elem.text
        print(f"Rule ID: {idref}\nResult: {result_value}\n")

        if result_value == 'pass':
            pass_list.append(idref)
        elif result_value == 'fail':
            fail_list.append(idref)


# Print the pass and fail lists
print(f"Pass list:\n{pass_list}\n")
print("--------------------------------")
print(f"Fail list:\n{fail_list}\n")
