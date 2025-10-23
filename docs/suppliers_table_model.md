# Module: suppliers_table_model.py

> Path: `PythonCod-master/suppliers_table_model.py`

## 📦 Imports
```python
PySide6.QtCore.QAbstractTableModel
PySide6.QtCore.Qt
PySide6.QtCore.Slot
PySide6.QtCore.Signal
database.DatabaseManager
```

## 🧩 Classes

### class SuppliersTableModel

Табличная модель данных для управления списком поставщиков в Qt/QML-приложении.

Наследуется от QAbstractTableModel. Предоставляет данные о поставщиках для табличного представления
в QML, включая идентификатор, имя, компанию, email, телефон и веб-сайт. Поддерживает выбор
поставщиков с помощью флажков, загрузку данных, добавление, обновление, удаление и привязку
поставщиков к товарам через DatabaseManager. Испускает сигнал errorOccurred при ошибках.

```python
def __init__(self, parent)
```
Инициализация табличной модели поставщиков.

Args:
    parent (QObject, optional): Родительский объект Qt. По умолчанию None.

```python
def load(self)
```
Загружает всех поставщиков из базы данных для режима управления.

Сбрасывает модель, загружает данные поставщиков через DatabaseManager,
преобразует идентификаторы в целые числа и очищает множество выбранных поставщиков.

```python
def loadForArticle(self, article)
```
Загружает поставщиков с предварительно отмеченными для режима привязки к товару.

Args:
    article (str): Артикул товара.

Сбрасывает модель, загружает всех поставщиков и отмечает тех, которые уже привязаны к указанному артикулу.

```python
def roleNames(self)
```
Возвращает сопоставление ролей и их строковых имен для QML.

Returns:
    dict: Словарь вида {роль: b"имя"}, включая CheckStateRole для флажков.

```python
def columnCount(self, parent)
```
Возвращает количество столбцов в таблице.

Args:
    parent (QModelIndex, optional): Родительский индекс (не используется). По умолчанию None.

Returns:
    int: Количество столбцов (7: флажок, ID, ФИО, компания, email, телефон, сайт).

```python
def rowCount(self, parent)
```
Возвращает количество строк в модели (число поставщиков).

Args:
    parent (QModelIndex, optional): Родительский индекс (не используется). По умолчанию None.

Returns:
    int: Количество поставщиков в списке.

```python
def headerData(self, section, orientation, role)
```
Возвращает заголовки столбцов для табличного представления.

Args:
    section (int): Индекс столбца.
    orientation (Qt.Orientation): Ориентация (горизонтальная или вертикальная).
    role (int): Роль данных. По умолчанию Qt.DisplayRole.

Returns:
    str: Заголовок столбца или None, если роль или индекс недействительны.

```python
def data(self, index, role)
```
Получение данных для указанного индекса и роли.

Args:
    index (QModelIndex): Индекс строки и столбца в модели.
    role (int): Роль данных (например, IdRole, NameRole, CheckStateRole). По умолчанию Qt.DisplayRole.

Returns:
    Значение, соответствующее роли, или None, если индекс недействителен.

```python
def setData(self, index, value, role)
```
Устанавливает данные для указанного индекса и роли.

Args:
    index (QModelIndex): Индекс строки и столбца в модели.
    value: Значение для установки (ожидается integer для CheckStateRole).
    role (int): Роль данных. По умолчанию Qt.EditRole.

Returns:
    bool: True, если данные успешно установлены, иначе False.

Поддерживает только изменение состояния флажка (CheckStateRole).

```python
def flags(self, index)
```
Возвращает флаги для указанного индекса.

Args:
    index (QModelIndex): Индекс строки и столбца в модели.

Returns:
    Qt.ItemFlags: Флаги, определяющие поведение элемента (выбираемый, включаемый, с флажком для первого столбца).

```python
def getSelectedSupplierIds(self)
```
Возвращает список идентификаторов выбранных поставщиков.

Returns:
    list: Список ID поставщиков, отмеченных флажками.

```python
def bindSuppliersToItem(self, article, supplier_ids)
```
Привязывает список поставщиков к товару.

Args:
    article (str): Артикул товара.
    supplier_ids (list): Список идентификаторов поставщиков.

Вызывает метод DatabaseManager для привязки и обновляет состояние флажков.
При ошибке испускает сигнал errorOccurred.

```python
def getSupplierRow(self, row)
```
Возвращает данные поставщика по указанной строке.

Args:
    row (int): Индекс строки в модели.

Returns:
    dict: Словарь с данными поставщика (id, name, company, email, phone, website)
          или словарь с id=-1, если строка недействительна.

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

Вызывает метод DatabaseManager и перезагружает таблицу.
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

Вызывает метод DatabaseManager и перезагружает таблицу.
При ошибке испускает сигнал errorOccurred.

```python
def deleteSupplier(self, supplier_id)
```
Удаляет поставщика из базы данных.

Args:
    supplier_id (int): Идентификатор поставщика.

Вызывает метод DatabaseManager и перезагружает таблицу.
При ошибке испускает сигнал errorOccurred.

## 📝 Notes
This module was auto-documented.
