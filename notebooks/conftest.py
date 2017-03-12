""" py.test config file.

Use to run session wide setup fixture.

# Basic skeleton from http://stackoverflow.com/questions/14399908/\
#    py-test-setup-teardown-for-whole-test-suite
"""

import subprocess
import pytest

print("in conftest")

@pytest.fixture(scope="session", autouse=True)
def setup(request):
    """session wide setup fixture"""
    def teardown():
        """tear down function - called at end of test session"""
        print("Session fixture teardown")

    command = ["echo", "session start up"]
    command_proc = subprocess.Popen(command,
                                    #stdout=open(os.devnull),
                                    #stderr=open(os.devnull),
                                    shell=False)
    request.addfinalizer(teardown)
