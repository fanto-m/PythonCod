# Module: categories_model.py

> Path: `PythonCod-master/categories_model.py`

## 📦 Imports
```python
PySide6.QtCore.Qt
PySide6.QtCore.QAbstractListModel
PySide6.QtCore.QModelIndex
PySide6.QtCore.Slot
PySide6.QtCore.Signal
database.DatabaseManager
```

## 🧩 Classes

### class CategoriesModel

Модель данных для управления категориями товаров в Qt/QML-приложении.

Эта модель наследуется от QAbstractListModel и предоставляет интерфейс
для отображения и редактирования категорий через QML. Каждая категория
содержит идентификатор, название, префикс SKU и количество цифр в номере SKU.

Атрибуты ролей:
    IdRole (int): Роль для получения идентификатора категории.
    NameRole (int): Роль для получения названия категории.
    PrefixRole (int): Роль для получения префикса SKU.
    DigitsRole (int): Роль для получения количества цифр в SKU.

Сигналы:
    errorOccurred (str): Сигнал, испускаемый при возникновении ошибки
        в методах добавления, обновления или удаления категории.

```python
def __init__(self, parent)
```
Инициализирует модель категорий.

Подключается к менеджеру базы данных и загружает список категорий.

Args:
    parent (QObject, optional): Родительский объект Qt. По умолчанию None.

```python
def roleNames(self)
```
Возвращает сопоставление ролей и их строковых имён для QML.

Используется QML для доступа к данным модели по именам (например, `model.name`).

Returns:
    dict: Словарь, сопоставляющий роли (int) с байтовыми строками имён.

```python
def rowCount(self, parent)
```
Возвращает количество категорий в модели.

Args:
    parent (QModelIndex, optional): Родительский индекс (игнорируется,
        так как модель плоская). По умолчанию QModelIndex().

Returns:
    int: Количество строк (категорий) в модели.

```python
def data(self, index, role)
```
Возвращает данные для указанного индекса и роли.

Args:
    index (QModelIndex): Индекс запрашиваемого элемента.
    role (int, optional): Роль данных. По умолчанию Qt.DisplayRole.

Returns:
    Любое: Значение данных (id, имя, префикс или цифры SKU) или None,
    если индекс недопустим или роль не поддерживается.

```python
def loadCategories(self)
```
Загружает категории из базы данных и обновляет модель.

Вызывает beginResetModel() и endResetModel() для корректного
уведомления представления об изменении данных.

```python
def addCategory(self, name, sku_prefix, sku_digits)
```
Добавляет новую категорию в базу данных и обновляет модель.

Args:
    name (str): Название новой категории.
    sku_prefix (str): Префикс SKU для категории.
    sku_digits (int): Количество цифр в генерируемом SKU.

При ошибке испускается сигнал errorOccurred с текстом исключения.

```python
def updateCategory(self, category_id, new_name, sku_prefix, sku_digits)
```
Обновляет существующую категорию в базе данных.

Args:
    category_id (int): Идентификатор обновляемой категории.
    new_name (str): Новое название категории.
    sku_prefix (str): Новый префикс SKU.
    sku_digits (int): Новое количество цифр в SKU.

При ошибке испускается сигнал errorOccurred с текстом исключения.

```python
def deleteCategory(self, category_id)
```
Удаляет категорию из базы данных по её идентификатору.

Args:
    category_id (int): Идентификатор удаляемой категории.

При ошибке испускается сигнал errorOccurred с текстом исключения.

```python
def get(self, idx)
```
Возвращает объект категории по индексу для использования в QML.

Args:
    idx (int): Индекс категории в модели.

Returns:
    dict: Словарь с ключами 'id', 'name', 'sku_prefix', 'sku_digits'.
          Если индекс недопустим, возвращается словарь с пустыми значениями
          и id = -1.

```python
def indexOfName(self, name)
```
Возвращает индекс категории по её названию.

Args:
    name (str): Название категории.

Returns:
    int: Индекс категории в списке `_categories`, или -1, если не найдена.

```python
def getCategoryIdByName(self, name)
```
Возвращает идентификатор категории по её названию.

Args:
    name (str): Название категории.

Returns:
    int: Идентификатор категории, или -1, если категория не найдена.

```python
def generateSkuForCategory(self, category_id)
```
Генерирует следующий уникальный SKU для указанной категории.

Args:
    category_id (int): Идентификатор категории.

Returns:
    str: Сгенерированный SKU в формате "PREFIX0001", или пустая строка,
         если генерация не удалась.

## 📝 Notes
This module was auto-documented.
