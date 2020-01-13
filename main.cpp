#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <qqmlengine.h>
#include <qqmlcontext.h>
#include <qqml.h>
#include <QtQuick/qquickitem.h>
#include <QtQuick/qquickview.h>
#include <QString>

#include "animalmodel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    AnimalModel model;
    model.addAnimal(Animal("Wolf", "Medium"));
    model.addAnimal(Animal("Polar bear", "Large"));
    model.addAnimal(Animal("Quoll", "Small"));
    model.addAnimal(Animal("Small Pig", "Small"));
    model.addAnimal(Animal("Large Pig", "Large"));
    model.addAnimal(Animal("Dog", "Large"));
    model.addAnimal(Animal("Horse", "Large"));
    model.addAnimal(Animal("Bird", "Large"));
    model.addAnimal(Animal("Snake", "Medium"));
    model.addAnimal(Animal("Bear", "Large"));
    model.addAnimal(Animal("Cattle", "Medium"));
    model.addAnimal(Animal("Cat", "Small"));

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    QQmlContext *ctxt = engine.rootContext();
    ctxt->setContextProperty("animalModel", model.getFilter());
    engine.load(url);

    QObject::connect(engine.rootObjects()[0], SIGNAL(searchBarTextChanged(QString)),
                     &model, SLOT(slotSearchBarTextChanged(const QString&)));

    return app.exec();
}
