add_library(WaveCore STATIC)

ecm_add_qml_module(WaveCore
    URI org.sailfishos.wave.core
    GENERATE_PLUGIN_SOURCE

    SOURCES
        settingshelper.cpp
        useragent.cpp
)

target_include_directories(WaveCore PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_compile_definitions(WaveCore PRIVATE -DQT_NO_CAST_FROM_ASCII)
target_link_libraries(WaveCore PUBLIC
    Qt::Core
    Qt::Qml
    Qt::Sql
)

target_link_libraries(WaveCore PRIVATE Qt::WebEngineCore Qt::WebEngineQuick)
