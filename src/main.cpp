#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtWebEngineQuick>

int main(int argc, char *argv[])
{
    QCoreApplication::setApplicationName(QStringLiteral("Wave Browser"));
    QCoreApplication::setApplicationVersion(QStringLiteral("1.0.0"));
    QCoreApplication::setOrganizationName(QStringLiteral("org.sailfishos"));

    QtWebEngineQuick::initialize();

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.loadFromModule("org.sailfishos.wave", "Main");

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}