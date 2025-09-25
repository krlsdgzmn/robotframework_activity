import random

import requests
import urllib3

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)


class UsersLibrary:
    def _generate_birthday(self):
        year = random.randint(1950, 2003)
        month = random.randint(1, 12)
        day = random.randint(1, 28)
        return f"{month:02d}-{day:02d}-{year}"

    def _generate_state(self, address):
        return address["street"][0]+address["suite"][0]+address["city"][0]

    def get_random_users(self):
        response = requests.get(
            "https://jsonplaceholder.typicode.com/users", verify=False
        )
        users = response.json()
        for user in users:
            user["first_name"] = user["name"].split(" ")[0]
            user["last_name"] = " ".join(user["name"].split(" ")[1:])
            user["birthday"] = self._generate_birthday()
            user["address"]["state"] = self._generate_state(user["address"])
            user["password"] = user["last_name"]+user["birthday"]

        return users
