// CreateSpecificationMode.qml - Updated with SpecificationItemsTable
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "./" as Local

Rectangle {
    id: root

    // Theme must be loaded first
    Local.Theme_CSM {
        id: theme
    }

    color: theme.background

    signal backToMain()

    property int currentSpecId: -1
    property string currentSpecName: ""
    property bool isEditMode: currentSpecId !== -1
    property bool hasChanges: false

    // Calculation properties
    property real materialsCost: 0
    property real laborCost: 0
    property real overheadCost: 0
    property real totalCost: 0

    function calculateCosts() {
        materialsCost = specificationItemsModel.getTotalMaterialsCost() || 0
        laborCost = parseFloat(laborCostField.text) || 0
        var overheadPercent = parseFloat(overheadField.text) || 0
        if (isNaN(laborCost) || isNaN(overheadPercent)) {
            console.warn("Invalid input in laborCostField or overheadField")
            laborCost = 0
            overheadPercent = 0
        }
        overheadCost = materialsCost * (overheadPercent / 100)
        totalCost = materialsCost + laborCost + overheadCost
    }

    function clearForm() {
        currentSpecId = -1
        currentSpecName = ""
        nameField.text = ""
        descriptionField.text = ""
        laborCostField.text = "0"
        overheadField.text = "0"
        statusComboBox.currentIndex = 0
        specificationItemsModel.clear()
        hasChanges = false
        calculateCosts()
    }

    // Connect to model's totalCostChanged signal
    Connections {
        target: specificationItemsModel
        function onTotalCostChanged() {
            calculateCosts()
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // ========================================
        // HEADER
        // ========================================
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 60
            color: theme.primary

            RowLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 15

                Button {
                    text: "← Главное меню"
                    onClicked: {
                        if (hasChanges) {
                            confirmExitDialog.open()
                        } else {
                            clearForm()
                            backToMain()
                        }
                    }

                    background: Rectangle {
                        color: parent.down ? theme.primaryDark : (parent.hovered ? theme.primaryHover : "transparent")
                        radius: 4
                        border.color: theme.textWhite
                        border.width: 2
                    }

                    contentItem: Text {
                        text: parent.text
                        color: theme.textWhite
                        font.pointSize: 11
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Text {
                    text: isEditMode ? "Редактирование спецификации" : "Создание спецификации"
                    font.pointSize: 18
                    font.bold: true
                    color: theme.textWhite
                    Layout.fillWidth: true
                }

                Text {
                    text: "📋"
                    font.pointSize: 24
                }
            }
        }

        // ========================================
        // MAIN CONTENT
        // ========================================
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            contentWidth: availableWidth

            ColumnLayout {
                width: Math.min(parent.width - 20, 1400)
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 15
                anchors.topMargin: 15

                // --- BASIC INFO SECTION ---
                GroupBox {
                    Layout.fillWidth: true
                    title: "Основная информация"
                    font.pointSize: 11
                    font.bold: true

                    background: Rectangle {
                        color: theme.white
                        border.color: theme.border
                        radius: 6
                        y: parent.topPadding - parent.bottomPadding
                    }

                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 10

                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 10

                            // Name field
                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 4

                                Text {
                                    text: "Название изделия *"
                                    font.pointSize: 10
                                    font.bold: true
                                }

                                TextField {
                                    id: nameField
                                    Layout.fillWidth: true
                                    placeholderText: "Например: Изделие А-123"
                                    font.pointSize: 10
                                    onTextChanged: hasChanges = true

                                    background: Rectangle {
                                        color: theme.white
                                        border.color: nameField.activeFocus ? theme.primary : theme.border
                                        border.width: nameField.activeFocus ? 2 : 1
                                        radius: 4
                                    }
                                }
                            }

                            // Status
                            ColumnLayout {
                                Layout.preferredWidth: 200
                                spacing: 4

                                Text {
                                    text: "Статус"
                                    font.pointSize: 10
                                    font.bold: true
                                }

                                ComboBox {
                                    id: statusComboBox
                                    Layout.fillWidth: true
                                    model: ["черновик", "утверждена", "архив"]
                                    currentIndex: 0
                                    font.pointSize: 10
                                    onCurrentIndexChanged: hasChanges = true

                                    background: Rectangle {
                                        color: theme.white
                                        border.color: statusComboBox.activeFocus ? theme.primary : theme.border
                                        border.width: statusComboBox.activeFocus ? 2 : 1
                                        radius: 4
                                    }
                                }
                            }
                        }

                        // Description
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 4

                            Text {
                                text: "Описание"
                                font.pointSize: 10
                                font.bold: true
                            }

                            ScrollView {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 80
                                clip: true

                                TextArea {
                                    id: descriptionField
                                    placeholderText: "Подробное описание изделия..."
                                    wrapMode: TextEdit.Wrap
                                    font.pointSize: 10
                                    selectByMouse: true
                                    onTextChanged: hasChanges = true

                                    background: Rectangle {
                                        color: theme.white
                                        border.color: descriptionField.activeFocus ? theme.primary : theme.border
                                        border.width: descriptionField.activeFocus ? 2 : 1
                                        radius: 4
                                    }
                                }
                            }
                        }
                    }
                }

                // --- MATERIALS SECTION ---
                GroupBox {
                    Layout.fillWidth: true
                    title: "Материалы и комплектующие"
                    font.pointSize: 11
                    font.bold: true

                    background: Rectangle {
                        color: theme.white
                        border.color: theme.border
                        radius: 6
                        y: parent.topPadding - parent.bottomPadding
                    }

                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 10

                        // Status indicator
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 30
                            color: "#e3f2fd"
                            radius: 4
                            visible: itemsTable.rowCount > 0

                            Text {
                                anchors.centerIn: parent
                                text: "📦 Добавлено позиций: " + itemsTable.rowCount + " | Стоимость материалов: " + materialsCost.toFixed(2) + " ₽"
                                font.pointSize: 10
                                font.bold: true
                                color: theme.primary
                            }
                        }

                        Button {
                            text: "➕ Добавить позицию из склада"
                            Layout.fillWidth: true
                            font.pointSize: 10

                            background: Rectangle {
                                color: parent.down ? theme.successDark : (parent.hovered ? theme.successHover : theme.success)
                                radius: 4
                            }

                            contentItem: Text {
                                text: parent.text
                                color: theme.textWhite
                                font: parent.font
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }

                            onClicked: {
                                addItemDialog.open()
                            }
                        }

                        // Use the new SpecificationItemsTable component
                        Local.SpecificationItemsTable {
                            id: itemsTable
                            Layout.fillWidth: true
                            Layout.preferredHeight: 500
                            theme: root.theme  // Pass theme explicitly
                            model: specificationItemsModel

                            onItemQuantityChanged: function(row, newQuantity) {
                                specificationItemsModel.updateQuantity(row, newQuantity)
                                hasChanges = true
                            }

                            onItemRemoved: function(row) {
                                specificationItemsModel.removeItem(row)
                                hasChanges = true
                            }
                        }
                    }
                }

                // --- COSTS SECTION ---
                GroupBox {
                    Layout.fillWidth: true
                    title: "Калькуляция стоимости"
                    font.pointSize: 11
                    font.bold: true

                    background: Rectangle {
                        color: theme.white
                        border.color: theme.border
                        radius: 6
                        y: parent.topPadding - parent.bottomPadding
                    }

                    GridLayout {
                        anchors.fill: parent
                        columns: 2
                        rowSpacing: 10
                        columnSpacing: 15

                        // Labor cost
                        Text {
                            text: "Стоимость работы (₽):"
                            font.pointSize: 10
                        }
                        TextField {
                            id: laborCostField
                            Layout.fillWidth: true
                            text: "0"
                            font.pointSize: 10
                            horizontalAlignment: Text.AlignRight
                            validator: DoubleValidator { bottom: 0; decimals: 2 }
                            onTextChanged: {
                                hasChanges = true
                                calculateCosts()
                            }

                            background: Rectangle {
                                color: theme.white
                                border.color: laborCostField.activeFocus ? theme.primary : theme.border
                                border.width: laborCostField.activeFocus ? 2 : 1
                                radius: 4
                            }
                        }

                        // Overhead percentage
                        Text {
                            text: "Накладные расходы (%):"
                            font.pointSize: 10
                        }
                        TextField {
                            id: overheadField
                            Layout.fillWidth: true
                            text: "0"
                            font.pointSize: 10
                            horizontalAlignment: Text.AlignRight
                            validator: DoubleValidator { bottom: 0; top: 100; decimals: 2 }
                            onTextChanged: {
                                hasChanges = true
                                calculateCosts()
                            }

                            background: Rectangle {
                                color: theme.white
                                border.color: overheadField.activeFocus ? theme.primary : theme.border
                                border.width: overheadField.activeFocus ? 2 : 1
                                radius: 4
                            }
                        }

                        // Divider
                        Rectangle {
                            Layout.columnSpan: 2
                            Layout.fillWidth: true
                            height: 2
                            color: theme.tableHeader
                        }

                        // Cost breakdown
                        Text {
                            text: "Материалы:"
                            font.pointSize: 10
                            color: theme.textSecondary
                        }
                        Text {
                            text: materialsCost.toFixed(2) + " ₽"
                            font.pointSize: 10
                            font.bold: true
                            horizontalAlignment: Text.AlignRight
                            Layout.fillWidth: true
                            color: theme.textPrimary
                        }

                        Text {
                            text: "Работа:"
                            font.pointSize: 10
                            color: theme.textSecondary
                        }
                        Text {
                            text: laborCost.toFixed(2) + " ₽"
                            font.pointSize: 10
                            font.bold: true
                            horizontalAlignment: Text.AlignRight
                            Layout.fillWidth: true
                            color: theme.textPrimary
                        }

                        Text {
                            text: "Накладные:"
                            font.pointSize: 10
                            color: theme.textSecondary
                        }
                        Text {
                            text: overheadCost.toFixed(2) + " ₽"
                            font.pointSize: 10
                            font.bold: true
                            horizontalAlignment: Text.AlignRight
                            Layout.fillWidth: true
                            color: theme.textPrimary
                        }

                        // Total
                        Rectangle {
                            Layout.columnSpan: 2
                            Layout.fillWidth: true
                            height: 2
                            color: theme.textSuccess
                        }

                        Text {
                            text: "ИТОГО:"
                            font.pointSize: 12
                            font.bold: true
                            color: theme.textSuccess
                        }
                        Text {
                            text: totalCost.toFixed(2) + " ₽"
                            font.pointSize: 14
                            font.bold: true
                            horizontalAlignment: Text.AlignRight
                            Layout.fillWidth: true
                            color: theme.textSuccess
                        }
                    }
                }

                // --- ACTION BUTTONS ---
                RowLayout {
                    Layout.fillWidth: true
                    Layout.topMargin: 10
                    Layout.bottomMargin: 15
                    spacing: 10

                    Button {
                        text: "💾 Сохранить"
                        Layout.fillWidth: true
                        Layout.preferredHeight: 45
                        enabled: nameField.text.trim().length > 0 && itemsTable.rowCount > 0
                        font.pointSize: 11

                        background: Rectangle {
                            color: {
                                if (!parent.enabled) return theme.disabled
                                if (parent.down) return theme.successDark
                                if (parent.hovered) return theme.successHover
                                return theme.success
                            }
                            radius: 4
                        }

                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: parent.enabled ? theme.textWhite : theme.textPlaceholder
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        onClicked: {
                            // Debug: print items before save
                            specificationItemsModel.debugPrintItems()

                            var specId = specificationsModel.saveSpecification(
                                currentSpecId,
                                nameField.text,
                                descriptionField.text,
                                statusComboBox.currentText,
                                laborCost,
                                parseFloat(overheadField.text) || 0
                            )

                            if (specId > 0) {
                                hasChanges = false
                                notificationDialog.dialogType = "success"
                                notificationDialog.message = "Спецификация успешно сохранена!"
                                notificationDialog.showCancelButton = false
                                notificationDialog.open()
                            } else {
                                notificationDialog.dialogType = "error"
                                notificationDialog.message = "Ошибка при сохранении спецификации!"
                                notificationDialog.showCancelButton = false
                                notificationDialog.open()
                            }
                        }
                    }

                    Button {
                        text: "📄 Экспорт в Excel"
                        Layout.fillWidth: true
                        Layout.preferredHeight: 45
                        enabled: currentSpecId > 0
                        font.pointSize: 11

                        background: Rectangle {
                            color: {
                                if (!parent.enabled) return theme.disabled
                                if (parent.down) return theme.infoDark
                                if (parent.hovered) return theme.infoHover
                                return theme.info
                            }
                            radius: 4
                        }

                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: parent.enabled ? theme.textWhite : theme.textPlaceholder
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        onClicked: {
                            var result = specificationsModel.exportToExcel(currentSpecId)
                            notificationDialog.dialogType = result ? "success" : "error"
                            notificationDialog.message = result ? "Успешно экспортировано в Excel!" : "Ошибка при экспорте в Excel!"
                            notificationDialog.showCancelButton = false
                            notificationDialog.open()
                        }
                    }

                    Button {
                        text: "📕 Экспорт в PDF"
                        Layout.fillWidth: true
                        Layout.preferredHeight: 45
                        enabled: currentSpecId > 0
                        font.pointSize: 11

                        background: Rectangle {
                            color: {
                                if (!parent.enabled) return theme.disabled
                                if (parent.down) return theme.dangerDark
                                if (parent.hovered) return theme.dangerHover
                                return theme.danger
                            }
                            radius: 4
                        }

                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: parent.enabled ? theme.textWhite : theme.textPlaceholder
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        onClicked: {
                            var result = specificationsModel.exportToPDF(currentSpecId)
                            notificationDialog.dialogType = result ? "success" : "error"
                            notificationDialog.message = result ? "Успешно экспортировано в PDF!" : "Ошибка при экспорте в PDF!"
                            notificationDialog.showCancelButton = false
                            notificationDialog.open()
                        }
                    }

                    Button {
                        text: "🗑️ Очистить"
                        Layout.preferredWidth: 100
                        Layout.preferredHeight: 45
                        font.pointSize: 11

                        background: Rectangle {
                            color: parent.down ? theme.neutralDark : (parent.hovered ? theme.neutralHover : theme.neutral)
                            radius: 4
                        }

                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: theme.textWhite
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        onClicked: {
                            if (hasChanges) {
                                confirmClearDialog.open()
                            } else {
                                clearForm()
                            }
                        }
                    }
                }

                Item { Layout.preferredHeight: 20 }
            }
        }
    }

    // ========================================
    // DIALOGS
    // ========================================

    // Add item from warehouse dialog
    Dialog {
        id: addItemDialog
        title: "Добавить позицию из склада"
        modal: true
        width: 700
        height: 500
        anchors.centerIn: parent

        ColumnLayout {
            anchors.fill: parent
            spacing: 10

            TextField {
                id: searchField
                Layout.fillWidth: true
                placeholderText: "Поиск товара..."
                font.pointSize: 10
                onTextChanged: {
                    // Filter warehouse items
                    itemsModel.setFilterString(text)
                }
                background: Rectangle {
                    color: theme.white
                    border.color: searchField.activeFocus ? theme.primary : theme.border
                    border.width: searchField.activeFocus ? 2 : 1
                    radius: 4
                }
            }

            ListView {
                id: warehouseListView
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                model: itemsModel

                delegate: Rectangle {
                    width: warehouseListView.width
                    height: 80
                    color: mouseArea.containsMouse ? theme.tableAlternate : theme.white
                    border.color: theme.border
                    border.width: 1

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            // Prepare data with safe defaults
                            let articleValue = model.article || ""
                            let nameValue = model.name || ""
                            let unitValue = model.unit || "шт."
                            let priceValue = (model.price !== undefined && model.price !== null) ? parseFloat(model.price) : 0.0
                            let imageValue = model.image_path || ""
                            let categoryValue = model.category || ""
                            let statusValue = model.status || "active"

                            specificationItemsModel.addItem(
                                articleValue,
                                nameValue,
                                1.0,  // default quantity
                                unitValue,
                                priceValue,
                                imageValue,
                                categoryValue,
                                statusValue

                            )
                            hasChanges = true
                            addItemDialog.close()
                            searchField.text = ""
                        }
                    }

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 10

                        // Image viewer
                        Rectangle {
                            Layout.preferredWidth: 60
                            Layout.preferredHeight: 60
                            color: theme.background
                            border.color: theme.border
                            border.width: 1
                            radius: 4

                            Image {
                                anchors.fill: parent
                                anchors.margins: 2
                                source: model.image_path ? "../images/" + model.image_path : ""
                                fillMode: Image.PreserveAspectFit
                                smooth: true
                                visible: model.image_path && model.image_path !== ""
                            }

                            Text {
                                anchors.centerIn: parent
                                text: "📦"
                                font.pointSize: 24
                                visible: !model.image_path || model.image_path === ""
                                color: theme.textPlaceholder
                            }
                        }

                        // Item details
                        ColumnLayout {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            spacing: 2

                            Text {
                                text: model.name
                                font.pointSize: 10
                                font.bold: true
                                elide: Text.ElideRight
                                Layout.fillWidth: true
                            }
                            Text {
                                text: "Артикул: " + model.article + " | На складе: " + model.stock + " " + model.unit
                                font.pointSize: 9
                                color: theme.textSecondary
                            }

                            Text {
                                text: "Категория: " + (model.category || "Не указана")
                                font.pointSize: 8
                                color: theme.textPlaceholder
                                visible: model.category !== undefined
                            }
                        }

                        // Price
                        Text {
                            text: model.price.toFixed(2) + " ₽"
                            font.pointSize: 11
                            font.bold: true
                            color: theme.textPrimary
                            Layout.alignment: Qt.AlignVCenter
                        }
                    }
                }

                Label {
                    anchors.centerIn: parent
                    visible: warehouseListView.count === 0
                    text: "Товары не найдены"
                    font.pointSize: 10
                    color: theme.textPlaceholder
                }

                ScrollBar.vertical: ScrollBar {
                    policy: ScrollBar.AsNeeded
                }
            }
        }

        footer: DialogButtonBox {
            Button {
                text: "Закрыть"
                onClicked: {
                    addItemDialog.close()
                    searchField.text = ""
                }

                background: Rectangle {
                    color: parent.down ? theme.neutralDark : (parent.hovered ? theme.neutralHover : theme.neutral)
                    radius: 4
                }

                contentItem: Text {
                    text: parent.text
                    color: theme.textWhite
                    font: parent.font
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }

    // Universal notification dialog
    Local.NotificationDialog {
        id: notificationDialog
        onAccepted: {}
        onRejected: {}
    }

    // Confirm exit dialog
    Local.NotificationDialog {
        id: confirmExitDialog
        dialogType: "warning"
        message: "У вас есть несохраненные изменения. \n Выйти без сохранения?"
        showCancelButton: true
        onAccepted: {
            clearForm()
            backToMain()
        }
    }

    // Confirm clear dialog
    Local.NotificationDialog {
        id: confirmClearDialog
        dialogType: "warning"
        message: "Вы уверены, что хотите очистить форму? \n Все несохраненные данные будут потеряны."
        showCancelButton: true
        onAccepted: {
            clearForm()
        }
    }
}