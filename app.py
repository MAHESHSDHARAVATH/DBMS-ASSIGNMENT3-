from flask import Flask, render_template, request, redirect, url_for, flash
from flask_mysqldb import MySQL

app = Flask(__name__)

# MySQL configurations
app.config['MYSQL_HOST'] = 'localhost'  # MySQL host
app.config['MYSQL_USER'] = 'root'   # MySQL username
app.config['MYSQL_PASSWORD'] = 'P@ssw0rd!SK123'  # MySQL password
app.config['MYSQL_DB'] = 'Outlet_Management'  # MySQL database name

mysql = MySQL(app)

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
    cur = mysql.connection.cursor()
    query = "SELECT Outlet_ID, Outlet_name, Location_name, Contact_No, timings, Ratings FROM Outlet"
    cur.execute(query)
    outlets = cur.fetchall()  # Fetch all rows
    cur.close()
    return render_template("outlet_management.html", outlets=outlets)

@app.route("/stakeholder_details")
def  stakeholder_details():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM stakeholder")  # Adjust 'stakeholders' to your table name
    data = cur.fetchall()
    cur.close()
    return render_template("stakeholder_details.html", data=data)

@app.route("/Customer_feedback")
def Customer_feedback():
    cur = mysql.connection.cursor()
    # SQL query to join Customer_feedback with Outlet on Outlet_ID and select necessary columns
    query = """
    SELECT o.Outlet_name, cf.Customer_email, cf.Customer_rating
    FROM Customer_feedback cf
    JOIN Outlet o ON cf.Outlet_ID = o.Outlet_ID
    """
    cur.execute(query)
    feedback_data = cur.fetchall()  # Fetch all rows of joined tables
    cur.close()
    return render_template("Customer_feedback.html", feedback_data=feedback_data)

@app.route("/Rent_details")
def Rent_details():
    cur = mysql.connection.cursor()
    query = """
    SELECT Rent_payment.Outlet_ID, Outlet.Outlet_name, Rent_payment.Mode_of_payment, 
           Rent_payment.Paid_amount, Rent_payment.Rent_from_date, Rent_payment.Rent_to_date, 
           Rent_payment.Due_amount
    FROM Rent_payment
    INNER JOIN Outlet ON Rent_payment.Outlet_ID = Outlet.Outlet_ID
    """
    cur.execute(query)
    rent_payments = cur.fetchall()
    cur.close()
    return render_template("Rent_payment.html", rent_payments=rent_payments)

@app.route("/Survey_details")
def Survey_details():
    cur = mysql.connection.cursor()
    query = """
    SELECT O.Outlet_ID, O.Outlet_name, S.Date_of_survey, S.Description, S.Warning_issued, S.Penalty_amount
    FROM  Survey S
    INNER JOIN Outlet O ON S.Outlet_ID = O.Outlet_ID;  
    """
    cur.execute(query)
    surveys = cur.fetchall()
    cur.close()
    return  render_template("survey.html",surveys=surveys)

if __name__ == "__main__":
    app.run(debug=True)