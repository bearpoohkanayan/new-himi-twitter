const fs = require('fs');
const https = require('https');
const httpProxy = require('http-proxy');

const proxy = httpProxy.createProxyServer({
    target: {
        host: '0.0.0.0',
        port: 4567,
    },
});

const web = (req, res) => {
    proxy.web(req, res);
};

const ws = (req, socket, head) => {
    proxy.ws(req, socket, head);
};

const server = https.createServer(
    {
        key: fs.readFileSync('rootCA-key.pem'),
        cert: fs.readFileSync('rootCA.pem'),
    },
    web,
);

server.on('upgrade', ws);

server.listen(3100, 'localhost', () => {
    console.log("proxy server has started listening on https://localhost:3100, forwarding to http://0.0.0.0:3000");
});