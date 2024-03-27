from flask import Flask, render_template, request, redirect, url_for, flash

app = Flask(__name__)
app.secret_key = "supersecretkey"

# Sample User Data
user_data = {
    "shubham.kshirsagar@iitgn.ac.in": "password"
}

@app.route("/")
def login():
    return render_template("login.html")

@app.route("/login", methods=["POST"])
def login_user():
    email = request.form.get("username")
    password = request.form.get("pswrd")

    if email in user_data and user_data[email] == password:
        return """
        <script>
        alert("Login Successful");
        window.location.href = "{}";
        </script>
        """.format(url_for("outlet_management"))
    else:
        return """
        <script>
        alert("Login Failed");
        window.location.href = "/";
        </script>
        """

@app.route("/outlet_management")
def outlet_management():
    return render_template("outlet_management.html")

@app.route("/stakeholder_details")
def  stakeholder_details():
    return render_template("stakeholder_details.html")

@app.route("/Customer_feedback")
def Customer_feedback():
    return render_template("Customer_feedback.html")

@app.route("/Rent_details")
def Rent_details():
    return render_template( "Rent_payment.html" )

@app.route("/Survey_details")
def Survey_details():
    return render_template("survey.html")

if __name__ == "__main__":
    app.run(debug=True)