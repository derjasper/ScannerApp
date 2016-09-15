#include "qmlscanner.h"


void QmlScanner::processImage() {
    if (m_busy)
        return;

    if (m_image.toString() == "")
        return;

    m_busy = true;
    busyChanged();

    thread.start();
}

void QmlScanner::processingFinished(const QImage& image) {
    processed(image);

    m_busy = false;
    busyChanged();
}

void QmlScanner::saveImage(QString path) {
     //imwrite( path, gray_image );
    // TODO save

    imageSaved(QUrl(path));
}



