For developing , follow the steps below:

1.Generate your own SECRET_KEY from terminal by the command : "openssl rand -hex 32".
2.In the file "keys.py.example",input your SECREY_KEY and change the file name to "keys.py".
3.Input your db URL to "database.py".
4.Run "pip install -r requirements.txt" to install packages.
5.Run "uvicorn main:app --reload" to start the server.
