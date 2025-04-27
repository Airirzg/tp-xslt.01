# Infinity Book - XML/XSLT Book Catalog

A French book catalog website built using XML, XSLT, and CSS technologies. The application displays a collection of classic French literature with search functionality and styling.

![Book Catalog Screenshot](https://i.imgur.com/placeholder.jpg)

## Features

- **Data Display**: Books shown in a styled table with columns for title, author, year, genre, quantity, and price
- **Search**: Filter books by author name or publication year
- **Sorting**: Books sorted alphabetically by title
- **Currency**: Prices shown in Algerian Dinars (DA)
- **Responsive Design**: Layout adapts to different screen sizes

## Project Structure

- **livres.xml**: XML data file containing structured information about books
- **livres.xsl**: XSLT transformation file that converts XML to HTML
- **style.css**: CSS styling for the web interface
- **server.js**: Node.js server for local development
- **index.html**: JavaScript-based search interface for reliable parameter handling
- **favicon.ico**: Website favicon

## Recent Updates

We've made several improvements to the book catalog application:

### Search Functionality Improvements
- Fixed search functionality for both author and year fields
- Implemented a JavaScript-based approach for reliable XSLT parameter handling
- Added search results count to provide feedback on query matches

### Server Enhancements
- Added proper handling for favicon.ico requests to prevent 500 errors
- Improved URL parameter handling for better search functionality
- Enhanced error handling for file not found and server errors

### UI Improvements
- Added favicon links in the XSLT template for better browser compatibility
- Maintained search form state to preserve user input after searches
- Improved search results display with proper filtering

For more details on the updates, see [UPDATES.md](UPDATES.md).

## How to Run

1. Install Node.js if not already installed
2. Clone this repository:

```bash
git clone https://github.com/Airirzg/tp-xslt.01.git
```

3. Navigate to the project directory:

```bash
cd tp-xslt.01
```

4. Run the server:

```bash
node server.js
```

5. Open a browser and go to `http://localhost:8000`

## Technical Implementation

The project uses a hybrid approach for XML/XSLT processing:
1. Server-side handling of static files and error management
2. Client-side JavaScript for reliable XSLT parameter processing
3. CSS for styling and visual enhancements

## Search Implementation

The search functionality works in two ways:
1. **Direct XML/XSLT**: Parameters passed via URL to the XSLT processor
2. **JavaScript Enhancement**: For browsers with limited XSLT support, the index.html page uses JavaScript to explicitly set XSLT parameters

This dual approach ensures maximum compatibility across different browsers and environments.
