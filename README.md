# puppet-codeception

This is a little puppet module I created for testing the open source CMS TYPO3 with codeception.
You can also use it to test other PHP scripts with codeception.

I tested this actualy only on ubuntu 16.04.

## Note

The module comes with codeception and a chromedriver. So you are able to write acceptance tests from the beginning.
For new projects you can just enter ```codecept bootstrap``` and you are ready to go.

For acceptance tests we use the chromedriver for the google chrome browser. If you want to use other browsers
you need to install the geckodriver e.g. first.

To start the chrome we also added a script. Just enter ```chrome-start``` and you can run the codeception tests.
The script creates a file with the pid of the chrome process. The file is located in your home folder. When your done enter ```chrome-stop``` to stop the process. The chromedriver runs on port ```9515```.

### TYPO3 special

The TYPO3 team release a testing framework since version 8 and they also offer codeception tests with a whole
suite for the core. To run TYPO3 tests you need to start a listener first. We also added a small script for that usecase.

```start-typo3-listener```

And like the chrome we have a stop script, when your work is done.

```stop-typo3-listener```

**!! Important !!**

The chrome script can be started from everywhere, but the TYPO3 listener is relevant for the concrete TYPO3
instance. So please execute the script from the TYPO3 instance web root.

We are saving the current process id so that we know if a script is running. When you want to run multiple
TYPO3 instances on one server you can not execute the acceptance tests in parallel. First finish one instance, stop the
listener and then start a new listener from the web root of the new instance.

## Disclamer

I am not a DevOps guy. So be patient with me if something is done wrong and open an issue or send a PR.
I just want to share my little helper.

## Troubleshooting

* The TYPO3 acceptance tests are failing and the screenshot shows only "File not found"? Then you probably have a process that uses the port 8000. Check this with ```sudo netstat -plnt``` ... when you have a process that is not php, try to stop that. Otherwise the start-typo3-listener can not start.

## Links

* [Codeception](http://codeception.com/)
* [Chromedriver](https://sites.google.com/a/chromium.org/chromedriver/)
* [TYPO3](https://typo3.org)
* [TYPO3 acceptance tests](https://wiki.typo3.org/Acceptance_testing)
