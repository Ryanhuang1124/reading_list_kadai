For developing , follow the steps:

1.Generate your own SECRET_KEY from terminal by the command : "openssl rand -hex 32".
2.In the file "keys.py.example",input your SECREY_KEY and change the file name to "keys.py".
3.Type "uvicorn main:app --reload" to terminal to start the server.
