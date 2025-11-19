#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtWebEngineQuick>

#include <KLocalizedContext>
#include <KLocalizedString>

#include "wavesettings.h"
#include "iconimageprovider.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setApplicationName(QStringLiteral("Wave Browser"));
    QCoreApplication::setApplicationVersion(QStringLiteral("1.0.0"));
    QCoreApplication::setOrganizationName(QStringLiteral("org.sailfishos"));
    KLocalizedString::setApplicationDomain("wave");

    QtWebEngineQuick::initialize();

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextObject(new KLocalizedContext(&engine));
    engine.addImageProvider(IconImageProvider::providerId(), new IconImageProvider(&engine));

    engine.loadFromModule("org.sailfishos.wave", "Main");

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    return app.exec();
}