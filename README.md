# Meal Planner

## Getting Started

### Getting Started with PostgreSQL

1. Download and install PostgreSQL: https://www.postgresql.org/download/
2. To use `psql`, add the PostgreSQL installation directory (e.g. `C:\Program Files\PostgreSQL\16\bin`) to your PATH (Windows: Windows+Start "environment variables" > Environment Variables > User variable = Path > Edit... > New > OK > OK > OK)
3. Restart your terminal.
4. Verify Postgres is installed with `psql -U postgres` and the password you used in the installation wizard (`\q` to quit).

### Getting Started with DBeaver

1. Download DBeaver.
2. Create a new PostgreSQL connection.

### Parsing Text from Images with Tesseract and Pillow

Tesseract download
- Windows download: https://github.com/UB-Mannheim/tesseract/wiki
- Other download options: https://tesseract-ocr.github.io/tessdoc/Installation.html
- Source: https://github.com/tesseract-ocr/tesseract?tab=readme-ov-file

Install Tesseract using the installation wizard (this executable you've downloaded).

Installing:
- `pip install pytesseract`
- `pip install pillow`

If in main.py you see a warning `Import "pytesseract" could not be resolved`, Ctrl+Shift+P and Python: Select Interpreter to the global installation.

### Formatting Parsed Text with OpenAI

Install: `pip install openai`

API reference: https://platform.openai.com/docs/api-reference/introduction

Set your organization ID as an environment variable `OPENAI_ORGANIZATION_ID`
Set your API key as an environment variable `OPENAI_API_KEY`
