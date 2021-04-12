#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "conversationinfo.h"
#include "conversationmodel.h"

#define VER_MAJ      1
#define VER_MIN      0

#define QML_REGISTERTYPE(NS, T) qmlRegisterType<T>(NS, VER_MAJ, VER_MIN, #T);

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QML_REGISTERTYPE("mock.model", ConversationModel)

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}
