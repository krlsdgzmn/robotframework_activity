import requests
import urllib3

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)


class UsersLibrary:
    def get_random_users(self):
        response = requests.get(
            "https://jsonplaceholder.typicode.com/users", verify=False
        )
        users = response.json()
        for user in users:
            user["first_name"] = user["name"].split(" ")[0]
            user["last_name"] = user["name"].split(" ")[1]

        return users
