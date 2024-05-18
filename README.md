# How to build
Running the following command in the project root will generate the `public` folder:

> ENV=local emacs --script publish.el

# Serve the files
Easiest is to use httpd within emacs call `httpd-serve-directory`and select `public` dir generated above.
