# Toodoo - a simple todo-list-app with Flutter

## Setup

### Database

Jsonserver was used for the database of this app. Follow the steps to setup the database on your local network and over the internet through **ngrok**. 

Setup your project. Navigate to your project folder and paste in

```python
npm init
```

Then install **jsonserver**

```python
npm install --save jsonserver
```

Edit **package.json** and modify the scripts field

```python
...
"scripts":{
"json:server": "json-server --watch db.json"
},
...
```

Create a new file **db.json** and paste in text below.

```python
{
    "todos": [
        {
            "id": "1",
            "title": "Walk the dogs",
            "description": "walk lil Aki and do 5 laps",
            "done": "true",
            "expanded": "false"
        },
        {
            "id": "2",
            "title": "Study for Calculus exam",
            "description": "Study limits, infinite series, limits at infinity.",
            "done": "true",
            "expanded": "true"
        }
    ]
}
```

To run your server type in

```python
npm run json:server
```

To make your database available beyound your local server, download **ngrok**. Unzip it to install

```python
unzip /path/to/ngrok.zip
```

Create an ngrok account and get your auth token then onnect your account

```python
ngrok authtoken YOUR_AUTH_TOKEN_HERE
```

Now do the command to expose your [localhost](http://localhost) and port. Remember that this has underlying risks.

```python
ngrok http 3000
```

Your rest api can now be accessed anywhere through the outputted url. Copy and save this url, we will use this in the app later.

### Flutter app setup

Flutter is used for this app, to setup Flutter, follow the instructions [here](https://docs.flutter.dev/get-started/install). First, clone this repository

```python
git clone https://github.com/jamescasia/toodoo.git
```

Navigate to lib\services and create a file called Env.dart. Paste in the following:

```python
class Environment {
  static String URL = "DATABASE_URL_FROM_PREVIOUS_STEPS";
}
```

Then on the terminal

```python
flutter build apk --release
```

This will build the apk. When it’s done, navigate to **toodoo\build\app\outputs\apk\release** and copy the **app-release.apk** on your device or emulator.

Enjoy and be more productive with **Toodoo**