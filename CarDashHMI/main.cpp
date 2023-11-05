#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QScopedPointer>
#include "weather.h"
#include <QDebug>
#include <QQmlContext>
#include <QQmlEngine>

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterType<Weather>("weather.enum", 1, 0, "WEATHER");
    QScopedPointer<Weather> weather(new Weather);
    engine.rootContext()->setContextProperty("weather",weather.get());

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
