#!/run/current-system/sw/bin/bash

# Base URL for the links (adjust this if necessary)
# Fetch the HTML content and extract links from the table
curl $1 | \
gawk '
# Flag to indicate if we are inside a table
/<table/ { in_table = 1 }
/<\/table>/ { in_table = 0 }
# If we are inside a table, look for <a> tags
in_table && /<a href=/ {
    # Extract the URL
    match($0, /<a href="([^"]+)"/, url)
	print url[1]
}
'|uniq>a.out
book=$(awk -F"/" '{print $4;exit}' a.out)
echo $book
awk -F"/" '{print $4;exit}' a.out | xargs mkdir -p
cd $book
input=$(realpath a.out)
while IFS= read -r line ; do
    display_name=$(awk -F"/" '{print $7;exit}' <<<$line)
    # Use curl to download the content and save it to a file named after the display name
    curl --skip-existing -o "${display_name}.html" "https://www.royalroad.com$line"
done <$input
cd ..
rm a.out
