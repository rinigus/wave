add_executable(wave
    main.cpp
)

ecm_add_qml_module(wave
    GENERATE_PLUGIN_SOURCE
    URI org.sailfishos.wave
)

ecm_target_qml_sources(wave
    SOURCES
        qml/Main.qml
        qml/WebView.qml
        qml/TabsModel.qml
)

target_link_libraries(wave PRIVATE
    Qt::Core
    Qt::Gui
    Qt::Quick
    Qt::Qml
    Qt::WebEngineCore
    Qt::WebEngineQuick
)

install(TARGETS wave ${KDE_INSTALL_TARGETS_DEFAULT_ARGS})
