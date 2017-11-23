# language: ru

Функционал: Работа плагина ограничений выгрузки
    Как Пользователь
    Я хочу выполнять автоматическую синхронизацию конфигурации из хранилища
    Чтобы автоматизировать свою работы с хранилищем с git

Контекст: Тестовый контекст
    Когда Я очищаю параметры команды "gitsync" в контексте
    И Я создаю новый объект ГитРепозиторий
    И Я устанавливаю путь выполнения команды "gitsync" к текущей библиотеке
    И Я добавляю параметр "sync" для команды "gitsync"
    И Я создаю временный каталог и сохраняю его в контекст
    И я скопировал каталог тестового хранилища конфигурации во временный каталог
    И Я сохраняю значение временного каталога в переменной "КаталогХранилища1С"
    И Я создаю временный каталог и сохраняю его в контекст
    И Я сохраняю значение временного каталога в переменной "ПутьКаталогаИсходников"
    И Я создаю тестовой файл AUTHORS
    И Я записываю "0" в файл VERSION
    И Я создаю временный каталог и сохраняю его в контекст
    И Я инициализирую bare репозиторий во временном каталоге
    И Я сохраняю значение временного каталога в переменной "URLРепозитория"
    И я инициализирую связь "ПутьКаталогаИсходников" с внешним репозиторием "URLРепозитория"
    И я включаю отладку лога с именем "oscript.app.GitSync"
    И я включаю отладку лога с именем "oscript.app.gitsync.plugins.limit"
    И Я добавляю позиционный параметр для команды "gitsync" из переменной "КаталогХранилища1С"
    И Я добавляю позиционный параметр для команды "gitsync" из переменной "URLРепозитория"
    И Я добавляю позиционный параметр для команды "gitsync" из переменной "ПутьКаталогаИсходников"

Сценарий: Cинхронизация с использованием limit
    Допустим Я создаю временный каталог и сохраняю его в контекст
    И Я сохраняю значение временного каталога в переменной "ВременнаяДиректория"
    И Я добавляю параметр "-tempdir" для команды "gitsync" из переменной "ВременнаяДиректория"
    И Я добавляю параметр "-limit 1" для команды "gitsync"
    И Я включаю отладку лога с именем "oscript.app.gitsync.plugins.limit"
    И Я добавляю параметр "-plugins limit" для команды "gitsync"
    Когда Я выполняю команду "gitsync"
    Тогда Вывод команды "gitsync" содержит "ИНФОРМАЦИЯ - Синхронизация завершена"
    И Вывод команды "gitsync" не содержит "Внешнее исключение"
    И Код возврата команды "gitsync" равен 0

Сценарий: Cинхронизация c использованием maxversion
    Допустим Я создаю временный каталог и сохраняю его в контекст
    И Я сохраняю значение временного каталога в переменной "ВременнаяДиректория"
    И Я добавляю параметр "-tempdir" для команды "gitsync" из переменной "ВременнаяДиректория"
    И Я добавляю параметр "-maxversion 2" для команды "gitsync"
    И Я включаю отладку лога с именем "oscript.app.gitsync.plugins.limit"
    И Я добавляю параметр "-plugins limit" для команды "gitsync"
    Когда Я выполняю команду "gitsync"
    Тогда Вывод команды "gitsync" содержит "ИНФОРМАЦИЯ - Синхронизация завершена"
    И Вывод команды "gitsync" не содержит "Внешнее исключение"
    И Код возврата команды "gitsync" равен 0

Сценарий: Cинхронизация c использованием minversion
    Допустим Я создаю временный каталог и сохраняю его в контекст
    И Я сохраняю значение временного каталога в переменной "ВременнаяДиректория"
    И Я добавляю параметр "-tempdir" для команды "gitsync" из переменной "ВременнаяДиректория"
    И Я добавляю параметр "-minversion 5" для команды "gitsync"
    И Я включаю отладку лога с именем "oscript.app.gitsync.plugins.limit"
    И Я добавляю параметр "-plugins limit" для команды "gitsync"
    Когда Я выполняю команду "gitsync"
    Тогда Вывод команды "gitsync" содержит "ИНФОРМАЦИЯ - Синхронизация завершена"
    И Вывод команды "gitsync" не содержит "Внешнее исключение"
    И Код возврата команды "gitsync" равен 0
    И Количество коммитов должно быть "5"

Сценарий: Cинхронизация хранилища все вместе
    Допустим Я создаю временный каталог и сохраняю его в контекст
    И Я сохраняю значение временного каталога в переменной "ВременнаяДиректория"
    И Я добавляю параметр "-tempdir" для команды "gitsync" из переменной "ВременнаяДиректория"
    И Я добавляю параметр "-limit 3" для команды "gitsync"
    И Я добавляю параметр "-minversion 2" для команды "gitsync"
    И Я добавляю параметр "-maxversion 4" для команды "gitsync"
    И Я включаю отладку лога с именем "oscript.app.gitsync.plugins.limit"
    И Я добавляю параметр "-plugins limit" для команды "gitsync"
    Когда Я выполняю команду "gitsync"
    Тогда Вывод команды "gitsync" содержит "ИНФОРМАЦИЯ - Синхронизация завершена"
    И Вывод команды "gitsync" не содержит "Внешнее исключение"
    И Код возврата команды "gitsync" равен 0
