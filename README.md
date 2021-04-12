# QmlExample

## Call Mock
A DPI Awareness Qml based application UI example

- Interaction between C++ and Qml
- Usage of model, delegate ...

### Environment
- Qt 5.9.4 and upper
- Install MSVC_2017_64 under Qt modules
- Windows 10 +

### Translations

> To see chinese translations, following command are needed
```
lrelease.exe .\translations\call-mock_zh_CN.ts
```
A .qm file will be generated

- How .ts file is generated
```
lupdate.exe .\qml.qrc .\animalmodel.h -ts .\call-mock_zh_CN.ts
```

## Abstractitemmodel Usage Mock
A usage example of QAbstractitemmodel

### Environment
- Qt 5.15.0 and upper
- Install MSVC_2019_64 under Qt modules
- Windows 10 +
