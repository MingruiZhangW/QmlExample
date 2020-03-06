#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <qqmlengine.h>
#include <qqmlcontext.h>
#include <qqml.h>
#include <QtQuick/qquickitem.h>
#include <QtQuick/qquickview.h>
#include <QQuickStyle>
#include <QString>
#include <QObject>
#include <QTranslator>
#include <QDate>
#include <QLibraryInfo>

#include "animalmodel.h"

int main(int argc, char *argv[])
{
    qDebug()<< QLocale().name();

    QGuiApplication::setApplicationName("Call-mock");
    QGuiApplication::setOrganizationDomain("ming.net");
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    // add chinese translations
    auto appDir = qApp->applicationDirPath() + "/translations";
    QTranslator qtTranslator_lang;
    if(QLocale().name() == "zh_CN"){
        qDebug()<< appDir;
        qDebug()<< qtTranslator_lang.load("call-mock_zh_CN.qm", ":/translations");
        qDebug()<< app.installTranslator(&qtTranslator_lang);
    }

    qDebug() << qtTranslator_lang.translate("main", "Add Account", 0);

    Service myService;

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

    QQuickStyle::setStyle("Universal");
    //QQuickStyle::setStyle("Material");

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    QQmlContext *ctxt = engine.rootContext();
    ctxt->setContextProperty("animalModel", model.getFilter());
    ctxt->setContextProperty("myService", &myService);
    engine.load(url);
    engine.retranslate();

    QObject::connect(engine.rootObjects()[0], SIGNAL(searchBarTextChanged(QString)),
                     &model, SLOT(slotSearchBarTextChanged(const QString&)));
    QObject::connect(engine.rootObjects()[0], SIGNAL(changeLabelTextButtonClicked(QString)),
                     &myService, SLOT(trigger_clbk(QString)));
    return app.exec();
}
