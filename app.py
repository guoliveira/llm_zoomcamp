import streamlit as st
from assistant import create_assistant
from db_save import save_conversation

assistant = create_assistant()

st.title("Course Assistant")

user_input = st.text_input("Enter your question:")

if st.button("Ask"):
    with st.spinner("Processing..."):
        answer = assistant.rag(user_input)
        st.success("Completed!")
        st.write(answer)

        record = assistant.last_call

        conversation_id = save_conversation(record, user_input, "llm-zoomcamp")
        st.session_state.conversation_id = conversation_id