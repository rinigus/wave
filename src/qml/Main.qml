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
        focus: true

        settings {
            // Load larger touch icons
            touchIconsEnabled: true
            // Disable scrollbars on mobile
            showScrollBars: false
            // Generally allow screen sharing, still needs permission from the user
            screenCaptureEnabled: true
            // Enables a web page to request that one of its HTML elements be made to occupy the user's entire screen
            fullScreenSupportEnabled: true
            // Turns on printing of CSS backgrounds when printing a web page
            printElementBackgrounds: false
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