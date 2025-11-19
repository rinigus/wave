add_subdirectory(lib)

add_executable(wave
    main.cpp
)

ecm_add_qml_module(wave
    GENERATE_PLUGIN_SOURCE
    URI org.sailfishos.wave
)

ecm_target_qml_sources(wave
    SOURCES
        qml/Bookmarks.qml
        qml/DownloadQuestion.qml
        qml/Downloads.qml
        qml/ErrorHandler.qml
        qml/FindInPageBar.qml
        qml/HistorySheet.qml
        qml/History.qml
        qml/ListWebView.qml
        qml/Main.qml
        qml/Navigation.qml
        qml/NavigationEntrySheet.qml
        qml/NewTabQuestion.qml
        qml/PermissionQuestion.qml
        qml/Questions.qml
        qml/ShareSheet.qml
        qml/Tabs.qml
        qml/UrlDelegate.qml
        qml/WebView.qml
        qml/WebDeveloperTools.qml

        regex-weburl/RegexWebUrl.js
)

target_link_libraries(wave PRIVATE
    Qt::Core
    Qt::Gui
    Qt::Quick
    Qt::Qml
    Qt::WebEngineCore
    Qt::WebEngineQuick
    KF6::ConfigCore
    KF6::ConfigGui
    KF6::I18n
    KF6::Notifications
    WaveCore
    WaveCoreplugin
)

install(TARGETS wave ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
