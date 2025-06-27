// Import the HTTP module
const http = require('http');

const greetingService = "http://localhost:5000/greeting";
const planetService = "http://localhost:8080/planet";

// Create a server object
const server = http.createServer((request, response) => {

  const greeting = new Promise((resolve, reject) => {
    http.get(greetingService, greetResponse => {
      if (greetResponse.statusCode !== 200) {
        reject("Received HTTP " + greetResponse.statusCode + " from " + greetingService);
      } else {
        let data = [];
        greetResponse.on('data', chunk => {
          data.push(chunk);
        });
        greetResponse.on('end', () => {
          resolve(Buffer.concat(data).toString().trim());
        });
      }
    }).on('error', err => {
      reject("Error when calling " + greetingService + ": " + err.errors);
    })
  });

  const planet = new Promise((resolve, reject) => {
    http.get(planetService, planetResponse => {
      if (planetResponse.statusCode !== 200) {
        reject("Received HTTP " + planetResponse.statusCode + " from " + planetService);
      } else {
        let data = [];
        planetResponse.on('data', chunk => {
          data.push(chunk);
        });
        planetResponse.on('end', () => {
          resolve(Buffer.concat(data).toString().trim());
        });
      }
    }).on('error', err => {
      reject("Error when calling " + planetService + ": " + err.errors);
    })
  });

  Promise.allSettled([greeting, planet]).then(results => {
    if (results[0].status !== 'fulfilled') {
      response.writeHead(500, {'Content-Type': 'text/plain'});
      response.end('Internal server error: ' + results[0].reason);
    } else if (results[1].status !== 'fulfilled') {
      response.writeHead(500, {'Content-Type': 'text/plain'});
      response.end('Internal server error: ' + results[1].reason);
    } else {
      response.writeHead(200, {'Content-Type': 'text/plain'});
      response.end(results[0].value + ', ' + results[1].value + '!\n');
    }
  });
});

// Define the port to listen on const PORT = 3000;

const PORT = 8081;

// Start the server and listen on the specified port
server.listen(PORT, 'localhost', () => {
  console.log(`Server running at http://localhost:${PORT}/`);
});