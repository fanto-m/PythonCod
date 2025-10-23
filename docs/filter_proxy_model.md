# Module: filter_proxy_model.py

> Path: `PythonCod-master/filter_proxy_model.py`

## 📦 Imports
```python
PySide6.QtCore.QSortFilterProxyModel
PySide6.QtCore.Slot
PySide6.QtCore.QSettings
PySide6.QtCore.Property
PySide6.QtCore.Qt
items_model.ItemsModel
```

## 🧩 Classes

### class FilterProxyModel

Прокси-модель для фильтрации и сортировки данных из ItemsModel.

Эта модель расширяет QSortFilterProxyModel, предоставляя функциональность
для фильтрации данных по указанному полю и строке фильтра, а также
для сортировки данных. Поддерживает сохранение и загрузку настроек
фильтрации через QSettings. Также предоставляет методы для добавления,
обновления и удаления элементов, перенаправляя их в исходную модель.

```python
def __init__(self, parent)
```
Инициализация прокси-модели.

Args:
    parent: Родительский объект (по умолчанию None).

```python
def get_filter_string(self)
```
Получение текущей строки фильтра.

Returns:
    str: Текущая строка фильтра.

```python
def get_filter_field(self)
```
Получение текущего поля фильтрации.

Returns:
    str: Текущее поле фильтрации.

```python
def _loadSettings(self)
```
Загрузка настроек фильтрации из QSettings.

Загружает сохраненные значения поля фильтрации и строки фильтра.
Если настройки отсутствуют, используются значения по умолчанию.

```python
def _saveSettings(self)
```
Сохранение настроек фильтрации в QSettings.

Сохраняет текущее поле фильтрации и строку фильтра.

```python
def setFilterString(self, filterString)
```
Установка строки фильтра.

Args:
    filterString (str): Новая строка фильтра.

Обновляет строку фильтра, вызывает инвалидацию фильтра и сохраняет настройки.

```python
def setFilterField(self, field)
```
Установка поля фильтрации.

Args:
    field (str): Новое поле для фильтрации.

Обновляет поле фильтрации, вызывает инвалидацию фильтра и сохраняет настройки.

```python
def setSort(self, role_name, order)
```
Установка сортировки данных.

Args:
    role_name (str): Имя роли (поля) для сортировки.
    order (str): Порядок сортировки ("ascending" или "descending").

Устанавливает роль сортировки и порядок, затем сортирует данные.
Выводит отладочную информацию о значениях в отсортированных строках.

```python
def filterAcceptsRow(self, sourceRow, sourceParent)
```
Проверка, проходит ли строка фильтр.

Args:
    sourceRow (int): Индекс строки в исходной модели.
    sourceParent: Родительский индекс в исходной модели.

Returns:
    bool: True, если строка проходит фильтр, иначе False.

Проверяет, содержит ли значение в указанном поле фильтрации подстроку
из строки фильтра. Выводит отладочную информацию о результате.

```python
def addItem(self, article, name, description, image_path, category_id, price, stock, status, unit, manufacturer, document)
```
Добавление нового элемента в исходную модель.

Args:
    article (str): Артикул элемента.
    name (str): Название элемента.
    description (str): Описание элемента.
    image_path (str): Путь к изображению.
    category_id (int): Идентификатор категории.
    price (float): Цена элемента.
    stock (int): Количество на складе.
    status (str): Статус элемента.
    unit (str): Единица измерения.
    manufacturer (str): Производитель.
    document (str): Документ, связанный с элементом.

Returns:
    Результат выполнения метода addItem исходной модели или сообщение об ошибке.

Выполняет безопасное преобразование типов и вызывает метод добавления
в исходной модели. Выводит отладочную информацию.

```python
def updateItem(self, proxy_row, article, name, description, image_path, category_id, price, stock, status, unit, manufacturer, document)
```
Обновление существующего элемента в исходной модели.

Args:
    proxy_row (int): Индекс строки в прокси-модели.
    article (str): Артикул элемента.
    name (str): Название элемента.
    description (str): Описание элемента.
    image_path (str): Путь к изображению.
    category_id (int): Идентификатор категории.
    price (float): Цена элемента.
    stock (int): Количество на складе.
    status (str): Статус элемента.
    unit (str): Единица измерения.
    manufacturer (str): Производитель.
    document (str): Документ, связанный с элементом.

Выполняет преобразование индекса из прокси-модели в исходную,
проверяет валидность индексов и вызывает метод обновления
в исходной модели. Выводит отладочную информацию.

```python
def deleteItem(self, proxy_row)
```
Удаление элемента из исходной модели.

Args:
    proxy_row (int): Индекс строки в прокси-модели.

Выполняет преобразование индекса из прокси-модели в исходную,
проверяет валидность индексов и вызывает метод удаления
в исходной модели. Выводит отладочную информацию.

## 📝 Notes
This module was auto-documented.
