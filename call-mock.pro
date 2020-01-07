QT += core winextras qml quickcontrols2 quick quickwidgets widgets xml multimedia multimediawidgets network webenginewidgets svg sql

CONFIG += suppress_vcproj_warnings c++17 qtquickcompiler

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += ./main.cpp \
           ./animalmodel.cpp

RESOURCES += ./ressources.qrc \
             ./qml.qrc

QML2_IMPORT_PATH = C:/Qt/5.9.4/msvc2017_64/qml

QTQUICK_COMPILER_SKIPPED_RESOURCES += ressources.qrc

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += ./animalmodel.h
