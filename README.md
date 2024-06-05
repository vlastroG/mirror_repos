# Описание
Клонирует репозитории с github и пушит master ветку каждого из них на gitlab в соответствующие репозитории

# Настройка и запуск
1. В файл config.txt написать репозитории список обрабатываемых репозиториев. Каждая строка в файле вида "github_url_repo gitlab_url_repo". Пробел - разделитель.
2. Добавить токет для пуша на gitlab в секрет "gitlab_secret" docker:
```
    docker swarm init
```
```
    echo gitlab_token_value | docker secret create gitlab_secret -
```
4. Собрать image:
```
    docker build -t mirror-test .
```
5. Задеплоить сервис:
```
    docker stack deploy --compose-file=docker-compose.yml secret_test
```
