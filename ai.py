import os
from openai import OpenAI

organization_id = os.environ.get('OPENAI_ORGANIZATION_ID')

client = OpenAI(
  organization=organization_id,
)

completion = client.chat.completions.create(
  model="gpt-4o",
  messages=[
    {"role": "system", "content": "You are a helpful assistant."},
    {"role": "user", "content": "Hello!"}
  ]
)

print(completion.choices[0].message)
