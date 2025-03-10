from flask import Flask, url_for
from markupsafe import escape
import os
app = Flask(__name__)

@app.route('/')
def index():
    return 'hello world'

with app.test_request_context():
    print(url_for('index'))

app.add_url_rule('/', view_func=index)

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="10.0.0.168", port=port)
