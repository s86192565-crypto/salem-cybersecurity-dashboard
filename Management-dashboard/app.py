import os
import mysql.connector
from dotenv import load_dotenv
from flask import Flask, jsonify, send_from_directory

load_dotenv()
app = Flask(__name__)

def run_sql(query):
    connection = mysql.connector.connect(
        host=os.getenv("DB_HOST"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        database=os.getenv("DB_NAME")
    )
    try:
        cursor = connection.cursor(dictionary=True)
        cursor.execute(query)
        return cursor.fetchall()
    finally:
        connection.close()

@app.route("/")
def home():
    return send_from_directory("static", "index.html")

@app.route("/api/vulnerabilities")
def get_vulns():
    query = """
        SELECT c.Company_Name AS client, 
               v.Vuln_Name AS vulnerability,
               v.Severity AS severity, 
               t.Team_Name AS team,
               r.Fix_Method AS method
        FROM Vulnerabilities v
        JOIN Clients c ON v.commercial_register_id = c.commercial_register_id
        JOIN Remediation r ON v.Vuln_ID = r.Vuln_ID
        JOIN Team_and_difficultys t ON r.Team_ID = t.Team_ID
        ORDER BY t.Team_Name
    """
    data = run_sql(query)
    return jsonify(data)

if __name__ == "__main__":
    app.run(debug=True)