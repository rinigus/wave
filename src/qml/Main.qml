import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import QtWebEngine
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root
    title: tabsModel.tabs.get(tabsModel.currentIndex) ? tabsModel.tabs.get(tabsModel.currentIndex).title || "Wave Browser" : "Wave Browser"
    width: 1024
    height: 768

    TabsModel {
        id: tabsModel
    }

    StackLayout {
        id: webViews
        anchors.fill: parent
        currentIndex: tabsModel.currentIndex

        Repeater {
            model: tabsModel.tabs
            WebView {
                url: model.url
                onTitleChanged: {
                    tabsModel.tabs.setProperty(index, "title", title);
                }
                onUrlChanged: {
                    tabsModel.tabs.setProperty(index, "url", url.toString());
                }
            }
        }
    }

    footer: QQC2.ToolBar {
        RowLayout {
            anchors.fill: parent
            spacing: Kirigami.Units.smallSpacing

            QQC2.TextField {
                id: addressBar
                Layout.fillWidth: true
                placeholderText: "Enter URL or search term"
                text: tabsModel.tabs.get(tabsModel.currentIndex) ? tabsModel.tabs.get(tabsModel.currentIndex).url : ""
                onAccepted: {
                    let url = text;
                    if (!url.startsWith("http://") && !url.startsWith("https://")) {
                        url = "https://" + url;
                    }
                    tabsModel.tabs.setProperty(tabsModel.currentIndex, "url", url);
                }
            }

            QQC2.ToolButton {
                Layout.preferredWidth: Kirigami.Units.gridUnit * 2
                Layout.preferredHeight: Kirigami.Units.gridUnit * 2

                Rectangle {
                    anchors.centerIn: parent
                    height: Kirigami.Units.gridUnit * 1.25
                    width: Kirigami.Units.gridUnit * 1.25
                    color: "transparent"
                    border.color: Kirigami.Theme.textColor
                    border.width: 1
                    radius: Kirigami.Units.gridUnit / 5

                    QQC2.Label {
                        anchors.centerIn: parent
                        text: tabsModel.tabs.count
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                onClicked: tabsSheet.open()
            }
        }
    }

    QQC2.Drawer {
        id: tabsSheet
        width: Math.min(root.width, root.height) / 3 * 2
        height: root.height

        signal requestSnapshots()
        onOpened: requestSnapshots()

        ListView {
            anchors.fill: parent
            model: tabsModel.tabs
            delegate: QQC2.ItemDelegate {
                width: parent.width
                height: Kirigami.Units.gridUnit * 4

                Column {
                    anchors.fill: parent

                    Rectangle {
                        width: parent.width
                        height: Kirigami.Units.gridUnit * 1.5
                        color: Kirigami.Theme.backgroundColor

                        RowLayout {
                            anchors.fill: parent

                            QQC2.Label {
                                Layout.fillWidth: true
                                text: model.title || "New Tab"
                                elide: Text.ElideRight
                            }

                            QQC2.ToolButton {
                                Layout.preferredWidth: Kirigami.Units.gridUnit * 1.5
                                Layout.preferredHeight: Kirigami.Units.gridUnit * 1.5
                                icon.name: 'tab-close-symbolic'
                                onClicked: tabsModel.closeTab(model.index)
                            }
                        }
                    }

                    Item {
                        width: parent.width
                        height: Kirigami.Units.gridUnit * 2.5
                        clip: true

                        Image {
                            id: tabImage
                            anchors.fill: parent
                            fillMode: Image.PreserveAspectCrop
                            verticalAlignment: Image.AlignTop
                        }

                        ShaderEffectSource {
                            id: shaderItem
                            live: false
                            anchors.fill: parent
                            sourceRect: Qt.rect(0, 0, root.width, root.height)
                            visible: false

                            sourceItem: webViews.children[model.index]

                            Connections {
                                target: tabsSheet
                                function onRequestSnapshots() {
                                    if (shaderItem.sourceItem) {
                                        shaderItem.sourceItem.readyForSnapshot = true;
                                        shaderItem.scheduleUpdate();
                                    }
                                }
                            }

                            onScheduledUpdateCompleted: {
                                if (sourceItem) {
                                    sourceItem.readyForSnapshot = false;
                                    shaderItem.grabToImage(function(result) {
                                        tabImage.source = result.url;
                                    }, Qt.size(Math.round(root.width * 0.3),
                                            Math.round(root.height * 0.3)));
                                }
                            }
                        }
                    }
                }

                onClicked: {
                    tabsModel.setCurrentTab(model.index);
                    tabsSheet.close();
                }
            }

            footer: QQC2.Button {
                width: parent.width
                text: "New Tab"
                onClicked: {
                    tabsModel.addTab("https://duckduckgo.com");
                }
            }
        }
    }
}