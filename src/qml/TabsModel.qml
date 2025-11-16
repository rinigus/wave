import QtQuick

QtObject {
    property ListModel tabs: ListModel {
        ListElement { url: "https://duckduckgo.com"; title: "DuckDuckGo" }
    }

    property int currentIndex: 0

    function addTab(url) {
        tabs.append({ url: url, title: "New Tab" });
        currentIndex = tabs.count - 1;
    }

    function closeTab(index) {
        if (tabs.count > 1) {
            tabs.remove(index);
            if (currentIndex >= index && currentIndex > 0) {
                currentIndex--;
            }
        }
    }

    function setCurrentTab(index) {
        if (index >= 0 && index < tabs.count) {
            currentIndex = index;
        }
    }
}