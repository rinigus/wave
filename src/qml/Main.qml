import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import QtWebEngine
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root
    title: webView.title || "Wave Browser"
    width: 1024
    height: 768

    WebEngineView {
        id: webView
        anchors.fill: parent
        url: "https://duckduckgo.com"
    }

    footer: QQC2.ToolBar {
        RowLayout {
            anchors.fill: parent
            spacing: Kirigami.Units.smallSpacing

            QQC2.TextField {
                id: addressBar
                Layout.fillWidth: true
                placeholderText: "Enter URL or search term"
                text: webView.url
                onAccepted: {
                    let url = text;
                    if (!url.startsWith("http://") && !url.startsWith("https://")) {
                        url = "https://" + url;
                    }
                    webView.url = url;
                }
            }
        }
    }
}