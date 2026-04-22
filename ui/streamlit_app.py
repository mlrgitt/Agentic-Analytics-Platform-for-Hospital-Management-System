import streamlit as st
from cortex_agent.agent import generate_sql, run_query

st.title("Hospital AI Analytics")

query = st.text_input("Ask a question")

if query:
    sql = generate_sql(query)
    st.write("Generated SQL:", sql)

    result = run_query(sql)
    st.write(result)