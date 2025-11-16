import QtQuick
import QtWebEngine

WebEngineView {
    id: webView
    focus: true
    profile: root.defaultProfile

    property bool readyForSnapshot: false

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