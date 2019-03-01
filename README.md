# Autolisp Utilities

These are commands I wrote to help me in my specific work within AutoCAD. Feel free to play around with them and make improvements as you see necesarry. Also, if you have requests for more commands, let me know

## Getting Started

You can copy and paste these commands directly into the command line of AutoCAD (2016 or newer), and they will be available in that drawing as long as you have it open. alternatively, you can go run the appload command. From there, click on the contents button in the lower right corner (in the box entitled startup suite), click the plus button, and point it towards the .lsp file.This way, the commands will be available everytime you are using AutoCAD, across every drawing.

### Prerequisites

Most of these commands will run on any OS that can run AutoCAD (AKA Mac OS and Windows). There are some that will only run in Windows, unfortunately

### Installing

A step by step series of examples that tell you how to get a development env running

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

If a command starts with (defun c:....) then the command can be run directly from the command line. If it starts any other way (i.e. (defun CAB:...)), you have to call it with parentheses and any required arguments.
As an example, objgroup can be run by typing objgroup into the command line, but to run CAB:recordCommand, you type in (CAB:recordCommand foo bar), where foo and bar are the expected input arguments, into the command line.

## Contributing

Please feel free to submit pull requests.


## Authors

* **Christopher Brisco** - *Initial work* - [A-Nony-Mus](https://github.com/A-Nony-Mus)


## License

This project is licensed under the GPL License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to Lee Mac (http://www.lee-mac.com) whose site helped me understand AutoLisp much better
