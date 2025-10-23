# Module: suppliers_model.py

> Path: `PythonCod-master/suppliers_model.py`

## 📦 Imports
```python
PySide6.QtCore.QAbstractListModel
PySide6.QtCore.Qt
PySide6.QtCore.Slot
PySide6.QtCore.Signal
database.DatabaseManager
```

## 🧩 Classes

### class SuppliersModel

Модель данных для управления списком поставщиков в Qt/QML-приложении.

Наследуется от QAbstractListModel. Предоставляет данные о поставщиках для QML-интерфейса,
включая их идентификатор, имя, компанию, email, телефон и веб-сайт. Поддерживает
загрузку, добавление, обновление и удаление поставщиков через DatabaseManager.
Испускает сигнал errorOccurred при возникновении ошибок.

```python
def __init__(self, parent)
```
Инициализация модели поставщиков.

Args:
    parent (QObject, optional): Родительский объект Qt. По умолчанию None.

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
    parent (QModelIndex, optional): Родительский индекс (не используется). По умолчанию None.

Returns:
    int: Количество поставщиков в списке.

```python
def data(self, index, role)
```
Получение данных для указанного индекса и роли.

Args:
    index (QModelIndex): Индекс строки в модели.
    role (int): Роль данных (например, IdRole, NameRole). По умолчанию Qt.DisplayRole.

Returns:
    Значение, соответствующее роли, или None, если индекс или роль недействительны.

```python
def loadSuppliers(self)
```
Загружает всех поставщиков из базы данных.

Сбрасывает модель, загружает данные поставщиков через DatabaseManager
и обновляет внутренний список _suppliers.

```python
def addSupplier(self, name, company, email, phone, website)
```
Добавляет нового поставщика в базу данных.

Args:
    name (str): Имя поставщика.
    company (str): Название компании.
    email (str): Электронная почта.
    phone (str): Телефон.
    website (str): Веб-сайт.

Вызывает метод добавления в DatabaseManager и перезагружает список поставщиков.
При ошибке испускает сигнал errorOccurred.

```python
def updateSupplier(self, supplier_id, name, company, email, phone, website)
```
Обновляет данные существующего поставщика.

Args:
    supplier_id (int): Идентификатор поставщика.
    name (str): Имя поставщика.
    company (str): Название компании.
    email (str): Электронная почта.
    phone (str): Телефон.
    website (str): Веб-сайт.

Вызывает метод обновления в DatabaseManager и перезагружает список поставщиков.
При ошибке испускает сигнал errorOccurred.

```python
def deleteSupplier(self, supplier_id)
```
Удаляет поставщика из базы данных.

Args:
    supplier_id (int): Идентификатор поставщика.

Вызывает метод удаления в DatabaseManager и перезагружает список поставщиков.
При ошибке испускает сигнал errorOccurred.

```python
def get(self, idx)
```
Возвращает данные поставщика по указанному индексу.

Args:
    idx (int): Индекс строки в модели.

Returns:
    dict: Словарь с данными поставщика (id, name, company, email, phone, website)
          или словарь с пустыми значениями, если индекс недействителен.

```python
def getSupplierIdByName(self, name)
```
Возвращает идентификатор поставщика по его имени.

Args:
    name (str): Имя поставщика.

Returns:
    int: Идентификатор поставщика или -1, если поставщик не найден.

```python
def getSupplierIdByCompany(self, company)
```
Возвращает идентификатор поставщика по названию компании.

Args:
    company (str): Название компании.

Returns:
    int: Идентификатор поставщика или -1, если поставщик не найден.

```python
def bindSuppliersToItem(self, article, supplier_ids)
```
Привязывает список поставщиков к товару.

Args:
    article (str): Артикул товара.
    supplier_ids (list): Список идентификаторов поставщиков.

Вызывает метод DatabaseManager для привязки поставщиков к товару.
При ошибке испускает сигнал errorOccurred.

## 📝 Notes
This module was auto-documented.
