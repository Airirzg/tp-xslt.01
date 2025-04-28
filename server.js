const http = require('http');
const fs = require('fs');
const path = require('path');
const url = require('url');

const server = http.createServer((req, res) => {
    // Parse the URL and query parameters
    const parsedUrl = url.parse(req.url, true);
    const pathname = parsedUrl.pathname;
    const query = parsedUrl.query;
    
    console.log('Request URL:', req.url);
    console.log('Pathname:', pathname);
    console.log('Query parameters:', query);
    
    let filePath = '.' + pathname;
    if (filePath === './') {
        filePath = './index.html';
    }

    // Handle favicon.ico request
    if (pathname === '/favicon.ico') {
        // Check if favicon exists
        if (fs.existsSync('./favicon.ico')) {
            res.writeHead(200, {'Content-Type': 'image/x-icon'});
            fs.createReadStream('./favicon.ico').pipe(res);
        } else {
            // Return empty response to prevent 500 error
            res.writeHead(204);
            res.end();
        }
        return;
    }

    const extname = path.extname(filePath);
    let contentType = 'text/html';
    
    switch (extname) {
        case '.xml':
            contentType = 'application/xml';
            break;
        case '.xsl':
            contentType = 'application/xml';
            break;
        case '.css':
            contentType = 'text/css';
            break;
        case '.ico':
            contentType = 'image/x-icon';
            break;
    }

    fs.readFile(filePath, (error, content) => {
        if (error) {
            if (error.code === 'ENOENT') {
                res.writeHead(404);
                res.end('File not found');
            } else {
                res.writeHead(500);
                res.end('Error: ' + error.code);
            }
        } else {
            // Special handling for XML files with query parameters
            if (extname === '.xml' && Object.keys(query).length > 0) {
                // Make sure the XML stylesheet reference includes the query parameters
                let contentStr = content.toString();
                
                // Check if there's an xml-stylesheet processing instruction
                if (contentStr.includes('<?xml-stylesheet')) {
                    // Get the current href value
                    const hrefMatch = contentStr.match(/href="([^"]+)"/);
                    if (hrefMatch && hrefMatch[1]) {
                        const xslFile = hrefMatch[1];
                        
                        // Build query string from parameters
                        const queryParams = [];
                        for (const key in query) {
                            if (query[key]) {
                                queryParams.push(`${key}=${encodeURIComponent(query[key])}`);
                            }
                        }
                        
                        const queryString = queryParams.length > 0 ? `?${queryParams.join('&')}` : '';
                        
                        // Replace the href with one that includes query parameters
                        const newStylesheetRef = `<?xml-stylesheet type="text/xsl" href="${xslFile}${queryString}"?>`;
                        contentStr = contentStr.replace(/(<\?xml-stylesheet[^?]+\?>)/, newStylesheetRef);
                        
                        res.writeHead(200, { 'Content-Type': contentType });
                        res.end(contentStr, 'utf-8');
                        return;
                    }
                }
            }
            
            // Default handling for all other files
            res.writeHead(200, { 'Content-Type': contentType });
            res.end(content, 'utf-8');
        }
    });
});

server.listen(8003, () => {
    console.log('Server running at http://localhost:8000/');
});