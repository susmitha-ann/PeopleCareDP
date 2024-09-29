from lxml import etree

# Load the XML and XSLT files
xml_file = 'healthdatabase.xml'
xslt_file = 'T4_normalization.xsl'

try:
    # Parse XML and XSLT
    dom = etree.parse(xml_file)
    xslt = etree.parse(xslt_file)
    transform = etree.XSLT(xslt)
    
    # Apply the transformation
    #new_dom = '<?xml-stylesheet type="text/xsl" href="filter-location"?>' + "\n" + transform(dom)
    new_dom = transform(dom)
    if new_dom is None:
        raise ValueError("The transformation returned 'None'. Check your XSLT for errors.")
    # Save the output to a new file
    with open('T4_normalization_output.xml', 'wb') as f:
        f.write(etree.tostring(new_dom, pretty_print=True))
    
    print("Transformation complete. Check normalization_output.xml for results.")
    #normalization_xml_file = 'normalization_output.xml'
    #normalization_dom = etree.parse(normalization_xml_file)
    #filter_xml_file = 'filer-location.html'
except (etree.XMLSyntaxError, etree.XSLTApplyError, ValueError) as e:
    print(f"Error during transformation: {str(e)}")