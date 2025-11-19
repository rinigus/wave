cmake_minimum_required(VERSION 3.16.0)

project(wave VERSION 1.0.0)

set(KF_MIN_VERSION "5.240")
set(QT_MIN_VERSION "6.4")

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

################# Disallow in-source build #################

if("${CMAKE_SOURCE_DIR}" STREQUAL "${CMAKE_BINARY_DIR}")
   message(FATAL_ERROR "This application requires an out of source build. Please create a separate build directory.")
endif()

include(FeatureSummary)

################# set KDE specific information #################

find_package(ECM ${KF_MIN_VERSION} REQUIRED NO_MODULE)

# where to look first for cmake modules, before ${CMAKE_ROOT}/Modules/ is checked
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${ECM_MODULE_PATH})

include(ECMSetupVersion)
include(ECMGenerateHeaders)
include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDEClangFormat)
include(ECMPoQmTools)
include(ECMFindQmlModule)
include(ECMQmlModule)
include(KDECompilerSettings NO_POLICY_SCOPE)

ecm_setup_version(${PROJECT_VERSION}
    VARIABLE_PREFIX WAVE
    VERSION_HEADER ${CMAKE_CURRENT_BINARY_DIR}/version.h
)

find_package(Qt6 ${QT_MIN_VERSION} REQUIRED COMPONENTS Core Gui Quick Qml Sql WebEngineCore WebEngineQuick)
find_package(KF6 ${KF_MIN_VERSION} REQUIRED COMPONENTS Kirigami Config I18n Notifications OPTIONAL_COMPONENTS QQC2DesktopStyle)
set_package_properties(KF6QQC2DesktopStyle PROPERTIES TYPE RUNTIME)

find_package(Qt6WebEngineCore REQUIRED)
find_package(Qt6WebEngineQuick REQUIRED)

add_definitions(-DQT_NO_FOREACH -DQT_NO_URL_CAST_FROM_STRING)
kde_enable_exceptions()

add_subdirectory(src)

#install(PROGRAMS org.sailfishos.wave.desktop DESTINATION ${KDE_INSTALL_APPDIR})

feature_summary(WHAT ALL INCLUDE_QUIET_PACKAGES FATAL_ON_MISSING_REQUIRED_PACKAGES)

file(GLOB_RECURSE ALL_CLANG_FORMAT_SOURCE_FILES src/*.cpp src/*.h)
kde_clang_format(${ALL_CLANG_FORMAT_SOURCE_FILES})
