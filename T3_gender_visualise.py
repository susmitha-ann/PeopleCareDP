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
    
def get_seeker_type_data(root):
    user_type= {'Elderly': 0, 'Handicap': 0, 'Postpartum': 0} # Initialize seeker_type counts

    # Loop through each AssistanceSeeker and count genders
    for seeker in root.findall('.//typeOfSeeker/Elderly'):
        user_type["Elderly"] += 1
    for seeker in root.findall('.//typeOfSeeker/Handicap'):
        user_type["Handicap"] += 1
    for seeker in root.findall('.//typeOfSeeker/postpartum'):
        user_type["Postpartum"] += 1
        #if seeker_type in user_type:
        #    user_type[seeker_type] += 1
        #else:
        #    user_type['Other'] += 1  # Handle other or unspecified seeker_type
    print(user_type)
    return user_type
    
def plot_seekertype_pie(user_type_data):
    # Labels for the pie chart
    labels = user_type_data.keys()

    # Gender counts
    sizes = user_type_data.values()

    # Plot pie chart
    plt.figure(figsize=(4,4))
    plt.pie(sizes, labels=labels, autopct='%1.1f%%', startangle=140, colors=['skyblue', 'lightgreen', 'lightcoral'])

    # Equal aspect ratio ensures that pie is drawn as a circle.
    plt.axis('equal')

    # Save the pie chart as an image file
    plt.savefig('seekertype_chart.png')

    # Close the plot
    plt.close()

# Create the pie chart and save it
def plot_gender_pie(genders):
    # Labels for the pie chart
    labels = genders.keys()

    # Gender counts
    sizes = genders.values()

    # Plot pie chart
    plt.figure(figsize=(4,4))
    plt.pie(sizes, labels=labels, autopct='%1.1f%%', startangle=140, colors=['skyblue', 'lightcoral', 'lightgreen'])

    # Equal aspect ratio ensures that pie is drawn as a circle.
    plt.axis('equal')

    # Save the pie chart as an image file
    plt.savefig('gender_pie_chart.png')

    # Close the plot
    plt.close()

# Generate HTML file with a reference to the saved image
def generate_html():
    image_path = os.path.abspath("gender_pie_chart.png")  # Get the full image path
    image_path2 = os.path.abspath("seekertype_chart.png")
    html_content = f"""
    <html>
    <head><title>Gender Distribution Pie Chart</title></head>
    <body>
        <h1>Gender Distribution of Assistance Seekers</h1>
        <img src="{image_path}" alt="Pie Chart" />
        <h1>User Type Distribution of Assistance Seekers</h1>
        <img src="{image_path2}" alt="Pie Chart" />
    </body>
    </html>
    """

    # Save the HTML content to a file
    with open("T3_gender_pie_chart.html", "w") as html_file:
        html_file.write(html_content)

# Main function to run the script
if __name__ == "__main__":
    xml_file = "HealthDatabase.xml"  # Path to your XML file
    root = parse_xml(xml_file)           # Parse the XML
    user_type_data = get_seeker_type_data(root)
    gender_data = get_gender_data(root)  # Get gender data
    plot_gender_pie(gender_data)         # Save pie chart as image
    plot_seekertype_pie(user_type_data)         # Save pie chart as image

    generate_html()                      # Generate HTML file