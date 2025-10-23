# Module: item_suppliers_model.py

> Path: `PythonCod-master/item_suppliers_model.py`

## 📦 Imports
```python
PySide6.QtCore.QAbstractListModel
PySide6.QtCore.Qt
PySide6.QtCore.Slot
PySide6.QtCore.Signal
database.DatabaseManager
```

## 🧩 Classes

### class ItemSuppliersModel

Модель данных для управления списком поставщиков, связанных с конкретным товаром.

Наследуется от QAbstractListModel. Предоставляет данные о поставщиках для QML-интерфейса,
включая их идентификатор, имя, компанию, email, телефон и веб-сайт. Поддерживает загрузку
данных из базы данных через DatabaseManager и обновление данных при изменении артикула товара.

```python
def __init__(self, article)
```
Инициализация модели поставщиков.

Args:
    article (str, optional): Артикул товара, для которого загружаются поставщики.
                            По умолчанию пустая строка.

```python
def load(self)
```
Загрузка данных поставщиков для текущего артикула.

Сбрасывает модель, получает идентификаторы поставщиков для текущего артикула
из базы данных и загружает полные данные для соответствующих поставщиков.

```python
def roleNames(self)
```
Возвращает сопоставление ролей и их строковых имен для QML.

Returns:
    dict: Словарь вида {роль: b"имя"}, используемый QML для доступа к данным модели.

```python
def rowCount(self, parent)
```
Возвращает количество строк в модели (число поставщиков).

Args:
    parent: Родительский индекс (не используется, по умолчанию None).

Returns:
    int: Количество поставщиков в списке.

```python
def data(self, index, role)
```
Получение данных для указанного индекса и роли.

Args:
    index (QModelIndex): Индекс строки в модели.
    role (int): Роль данных (например, IdRole, NameRole).

Returns:
    Значение, соответствующее роли, или None, если индекс или роль недействительны.

```python
def setArticle(self, article)
```
Устанавливает новый артикул и перезагружает данные поставщиков.

Args:
    article (str): Артикул товара, для которого нужно загрузить поставщиков.

Вызывает метод load() для обновления списка поставщиков.

```python
def get(self, index)
```
Получение данных поставщика по индексу в виде словаря.

Args:
    index (int): Индекс строки в модели.

Returns:
    dict: Словарь с данными поставщика (id, name, company, email, phone, website)
          или словарь с пустыми значениями, если индекс недействителен.

## 📝 Notes
This module was auto-documented.
