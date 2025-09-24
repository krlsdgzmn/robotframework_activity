import requests
import urllib3

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)


class UsersLibrary:
    def get_random_users(self):
        response = requests.get(
            "https://jsonplaceholder.typicode.com/users", verify=False
        )
        return response.json()
