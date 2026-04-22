import snowflake.connector

def get_schema():
    conn = snowflake.connector.connect(...)
    cur = conn.cursor()
    cur.execute("SELECT column_name FROM semantic_metadata")
    return [row[0] for row in cur.fetchall()]

def generate_sql(user_query):
    if "visits" in user_query:
        return "SELECT * FROM GOLD.patient_summary LIMIT 10"
    return "SELECT * FROM GOLD.patient_summary LIMIT 5"

def run_query(sql):
    conn = snowflake.connector.connect(...)
    cur = conn.cursor()
    cur.execute(sql)
    return cur.fetchall()

if __name__ == "__main__":
    query = input("Ask: ")
    sql = generate_sql(query)
    result = run_query(sql)
    print(result)