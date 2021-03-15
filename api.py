import flask
from flask import request, jsonify
from flask import send_file

app = flask.Flask(__name__)
app.config["DEBUG"] = True

# Create some test data for our catalog in the form of a list of dictionaries.
books = [
    {'id': 0,
     'title': 'A Fire Upon the Deep',
     'author': 'Vernor Vinge',
     'first_sentence': 'The coldsleep itself was dreamless.',
     'year_published': '1992'},
    {'id': 1,
     'title': 'The Ones Who Walk Away From Omelas',
     'author': 'Ursula K. Le Guin',
     'first_sentence': 'With a clamor of bells that set the swallows soaring, the Festival of Summer came to the city Omelas, bright-towered by the sea.',
     'published': '1973'},
    {'id': 2,
     'title': 'Dhalgren',
     'author': 'Samuel R. Delany',
     'first_sentence': 'to wound the autumnal city.',
     'published': '1975'}
]

@app.route('/api',methods=['GET'])
def hello_world():
    d={}
    d['Query']= str(request.args['Query'])
    return jsonify(d)


@app.route('/', methods=['GET'])
def home():
    return '''<h1>Testing</h1>
<p>API</p>'''


@app.route('/api/v1/resources/books/all', methods=['GET'])
def api_all():
    return jsonify(books)


@app.route('/api/v1/resources/books', methods=['GET'])
def api_id():
    # Check if an ID was provided as part of the URL.
    # If ID is provided, assign it to a variable.
    # If no ID is provided, display an error in the browser.
    if 'id' in request.args:
        id = int(request.args['id'])
    else:
        return "Error: No id field provided. Please specify an id."

    # Create an empty list for our results
    results = []

    # Loop through the data and match results that fit the requested ID.
    # IDs are unique, but other fields might return many results
    for book in books:
        if book['id'] == id:
            results.append(book)

    # Use the jsonify function from Flask to convert our list of
    # Python dictionaries to the JSON format.
    return jsonify(results)

@app.route('/get_image')
def get_image():
    return send_file('cat.jpg', mimetype='image/gif')

@app.route('/hi')
def hi():
    return jsonify(message='hi you')

@app.route('/img', methods = ['GET', 'POST'])
def post_image(img_file):
    """ post image and return the response """
    img = open(img_file, 'rb').read()
    response = requests.post(URL, data=img, headers=headers)
    return response

@app.route('/parameters')
def parameters():
    name=request.args.get('name')
    age= int(request.args.get('age'))
    if age<18:
        return jsonify(message='sorry you arent old enough'+name),404
    else:
        return jsonify(message='congradulations')

@app.route('/values/<string:name>/<int:age>')
def values(name:str,age:int):
    if age<18:
        return jsonify(message='sorry you arent old enough '+name),404
    else:
        return jsonify(message='congradulations')
    

app.run()