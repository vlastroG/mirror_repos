# Описание
Клонирует репозитории с github и пушит master ветку каждого из них на gitlab в соответствующие репозитории

# Настройка и запуск
1. В файл config.txt написать репозитории список обрабатываемых репозиториев.
Каждая строка в файле вида "https://github.com/vlastroG/git_fun.git https://oauth2:TOKEN@gitlab.com/vlastro/git_fun.git"
2. Добавить токет для пуша в секрет "push_secret" docker:
```
    docker swarm init
```
```
    echo gitlab_token_value | docker secret create push_secret -
```
4. Собрать image:
```
    docker build -t mirror-test .
```
5. Задеплоить сервис:
```
    docker stack deploy --compose-file=docker-compose.yml secret_test
```
"secret_test" - префикс в названии сервиса
