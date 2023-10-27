from flask import Flask, request

app = Flask(__name__)

@app.route("/")
def index():
    celsius = request.args.get("celsius", "")
    if celsius:
        fahrenheit = fahrenheit_from(celsius)
    else:
        fahrenheit = ""
    return """
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
                <strong>Fahrenheit:</strong> {}&deg;F
            </div>
        </body>
        </html>
    """.format(fahrenheit)

def fahrenheit_from(celsius):
    """Convert Celsius to Fahrenheit degrees."""
    try:
        fahrenheit = float(celsius) * 9 / 5 + 32
        fahrenheit = round(fahrenheit, 3)  # Round to three decimal places
        return str(fahrenheit)
    except ValueError:
        return "Invalid input"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080, debug=True)
