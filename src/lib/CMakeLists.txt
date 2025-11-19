add_library(WaveCore STATIC)

ecm_add_qml_module(WaveCore
    URI org.sailfishos.wave.core
    GENERATE_PLUGIN_SOURCE

    SOURCES
        bookmarkshistorymodel.cpp
        browsermanager.cpp
        dbmanager.cpp
        downloadmanager.cpp
        iconimageprovider.cpp
        settingshelper.cpp
        sqlquerymodel.cpp
        tabsmodel.cpp
        urlobserver.cpp
        urlutils.cpp
        useragent.cpp
        wavewebprofile.cpp
)

kconfig_add_kcfg_files(WaveCore GENERATE_MOC wavesettings.kcfgc)

target_include_directories(WaveCore PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_compile_definitions(WaveCore PRIVATE -DQT_NO_CAST_FROM_ASCII)
target_link_libraries(WaveCore PUBLIC
    Qt::Core
    Qt::Qml
    Qt::Sql
    KF6::ConfigCore
    KF6::ConfigGui
    KF6::I18n
    KF6::Notifications
)

install(FILES wavesettings.kcfg DESTINATION ${KDE_INSTALL_KCFGDIR})

target_link_libraries(WaveCore PRIVATE Qt::WebEngineCore Qt::WebEngineQuick)
