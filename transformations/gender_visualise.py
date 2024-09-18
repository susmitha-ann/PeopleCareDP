import xml.etree.ElementTree as ET
import matplotlib.pyplot as plt
import os

# Step 1: Parse the XML file
def parse_xml(file_path):
    tree = ET.parse(file_path)
    root = tree.getroot()
    return root

# Step 2: Extract gender information of AssistanceSeekers
def get_gender_data(root):
    genders = {'Male': 0, 'Female': 0, 'Other': 0}  # Initialize gender counts

    # Loop through each AssistanceSeeker and count genders
    for seeker in root.findall('.//AssistanceSeeker'):
        gender = seeker.find('gender').text
        if gender in genders:
            genders[gender] += 1
        else:
            genders['Other'] += 1  # Handle other or unspecified genders

    return genders

# Step 3: Create the pie chart and save it
def plot_gender_pie(genders):
    # Labels for the pie chart
    labels = genders.keys()

    # Gender counts
    sizes = genders.values()

    # Plot pie chart
    plt.figure(figsize=(6,6))
    plt.pie(sizes, labels=labels, autopct='%1.1f%%', startangle=140, colors=['skyblue', 'lightcoral', 'lightgreen'])

    # Equal aspect ratio ensures that pie is drawn as a circle.
    plt.axis('equal')

    # Save the pie chart as an image file
    plt.savefig('gender_pie_chart.png')

    # Close the plot
    plt.close()

# Step 4: Generate HTML file with a reference to the saved image
def generate_html():
    image_path = os.path.abspath("gender_pie_chart.png")  # Get the full image path
    html_content = f"""
    <html>
    <head><title>Gender Distribution Pie Chart</title></head>
    <body>
        <h1>Gender Distribution of Assistance Seekers</h1>
        <img src="{image_path}" alt="Pie Chart" />
    </body>
    </html>
    """

    # Save the HTML content to a file
    with open("gender_pie_chart.html", "w") as html_file:
        html_file.write(html_content)

# Main function to run the script
if __name__ == "__main__":
    xml_file = "HealthDatabase.xml"  # Path to your XML file
    root = parse_xml(xml_file)           # Parse the XML

    gender_data = get_gender_data(root)  # Get gender data
    plot_gender_pie(gender_data)         # Save pie chart as image

    generate_html()                      # Generate HTML file
