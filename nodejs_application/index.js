const express = require('express');
const app = express();
const port = 8080;

app.get('/', (req, res) => {
    const celsius = req.query.celsius || '';
    const fahrenheit = celsius ? fahrenheitFrom(celsius) : '';
    res.send(`
        <!DOCTYPE html>
        <html>
        <head>
            <title>Celsius to Fahrenheit Converter</title>
        </head>
        <body>
            <h1>Celsius to Fahrenheit Converter</h1>
            <form action="" method="get">
                <label for="celsius">Enter Celsius temperature:</label>
                <input type="text" name="celsius" id="celsius" placeholder="e.g., 25">
                <input type="submit" value="Convert to Fahrenheit">
            </form>
            <div id="result">
                <strong>Fahrenheit:</strong> ${fahrenheit}&deg;F
            </div>
        </body>
        </html>
    `);
});

function fahrenheitFrom(celsius) {
    try {
        const fahrenheit = (parseFloat(celsius) * 9 / 5) + 32;
        return fahrenheit.toFixed(3);
    } catch (error) {
        return 'Invalid input';
    }
}

app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
