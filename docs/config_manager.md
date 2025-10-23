# Module: config_manager.py

> Path: `PythonCod-master/config_manager.py`

## 📦 Imports
```python
json
os
PySide6.QtCore.QObject
PySide6.QtCore.Signal
PySide6.QtCore.Slot
PySide6.QtCore.Property
```

## 🧩 Classes

### class ConfigManager

Менеджер конфигурации приложения.

Сохраняет настройки в JSON-файл и предоставляет привязки к свойствам Qt для QML.
Поддерживает реактивное обновление интерфейса при изменении настроек.

Сигналы:
    vatIncludedChanged(bool): Изменилось включение НДС в цены.
    defaultCurrencyChanged(str): Изменилась валюта по умолчанию.
    vatRateChanged(float): Изменилась ставка НДС (в процентах).

```python
def __init__(self, config_path, parent)
```
Инициализирует менеджер конфигурации.

Загружает настройки из файла или создаёт файл с настройками по умолчанию.

Args:
    config_path (str, optional): Путь к файлу конфигурации. По умолчанию "config.json".
    parent (QObject, optional): Родительский объект Qt. По умолчанию None.

```python
def _load_default_config(self)
```
Возвращает словарь настроек по умолчанию.

Returns:
    dict: Словарь с ключами:
        - "vat_included" (bool)
        - "vat_rate" (float)
        - "default_currency" (str)
        - "decimal_places" (int)
        - "theme" (str)

```python
def _load_config(self)
```
Загружает конфигурацию из файла или создаёт файл с настройками по умолчанию.

Если файл существует — читает его и объединяет с настройками по умолчанию
(для поддержки новых параметров при обновлении приложения).
Если файл отсутствует — создаёт его.

```python
def _save_config(self)
```
Сохраняет текущую конфигурацию в JSON-файл.

Использует читаемый формат (indent=4, ensure_ascii=False).

```python
def _get_vat_included(self)
```
Возвращает флаг включения НДС в цены.

Returns:
    bool: True, если НДС включён в отображаемые цены.

```python
def _set_vat_included(self, value)
```
Устанавливает флаг включения НДС и сохраняет конфигурацию.

Args:
    value (bool): Новое значение флага.

```python
def _get_vat_rate(self)
```
Возвращает текущую ставку НДС.

Returns:
    float: Ставка НДС в процентах (например, 20.0).

```python
def _set_vat_rate(self, value)
```
Устанавливает новую ставку НДС и сохраняет конфигурацию.

Args:
    value (float): Новая ставка НДС в процентах.

```python
def _get_default_currency(self)
```
Возвращает валюту по умолчанию.

Returns:
    str: Код валюты (например, "RUB", "USD", "EUR").

```python
def _set_default_currency(self, value)
```
Устанавливает валюту по умолчанию и сохраняет конфигурацию.

Args:
    value (str): Новый код валюты.

```python
def getSetting(self, key)
```
Возвращает значение настройки по ключу.

Args:
    key (str): Имя параметра конфигурации.

Returns:
    Любое: Значение параметра или None, если ключ не найден.

```python
def setSetting(self, key, value)
```
Устанавливает значение настройки по ключу и сохраняет конфигурацию.

Args:
    key (str): Имя параметра.
    value (Any): Новое значение параметра.

```python
def calculatePriceWithoutVAT(self, price_with_vat)
```
Рассчитывает цену без НДС по цене с НДС.

Args:
    price_with_vat (float): Цена с НДС.

Returns:
    float: Цена без НДС, округлённая до 2 знаков.

```python
def calculatePriceWithVAT(self, price_without_vat)
```
Рассчитывает цену с НДС по цене без НДС.

Args:
    price_without_vat (float): Цена без НДС.

Returns:
    float: Цена с НДС, округлённая до 2 знаков.

```python
def resetToDefaults(self)
```
Сбрасывает все настройки к значениям по умолчанию.

Перезаписывает конфигурацию и испускает все сигналы изменения.

## 📝 Notes
This module was auto-documented.
