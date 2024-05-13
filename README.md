# CodePariksha
Quiz app for software engineering concepts


## Run local
```bash
flutter run -d Chrome
```

### Pages
- select tech to learn
- question/answer

### Sample GPT4all API request
```bash
curl --location 'http://localhost:4891/v1/completions' \
--header 'Content-Type: application/json' \
--data '{
    "temperature": 0.7,
    "model": "Nous-Hermes-2-Mistral-7B-DPO.Q4_0.gguf",
    "prompt": "Create a simple multiple choice question on c++",
    "max_tokens": 256
}'
```
