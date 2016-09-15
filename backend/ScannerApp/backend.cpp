#include <QtQml>
#include <QtQml/QQmlContext>
#include "backend.h"
#include "qmlscanner.h"
#include "scannerfilter.h"
#include "qimageitem.h"


void BackendPlugin::registerTypes(const char *uri)
{
    Q_ASSERT(uri == QLatin1String("ScannerApp"));

    qmlRegisterType<QmlScanner>(uri, 1, 0, "Scanner");
    qmlRegisterType<ScannerFilter>(uri, 1, 0, "ScannerFilter");
    qmlRegisterType<QImageItem>(uri, 1, 0, "ImageItem");
}

void BackendPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    QQmlExtensionPlugin::initializeEngine(engine, uri);
}

