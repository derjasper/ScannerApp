#include "scannerfilter.h"

#include <QImage>

#include <QDebug>

QVideoFrame ScannerFilterRunnable::run(QVideoFrame *input, const QVideoSurfaceFormat &surfaceFormat, RunFlags flags) {
    if(input->isValid() && m_filter->updatingEdges()) {
        m_filter->edgesUpdated();

        input->map(QAbstractVideoBuffer::ReadOnly);
        //cv::Mat cvImg = cv::Mat(input->height(),input->width(), CV_8UC3 /*CV_16SC3*/, input->bits(), input->bytesPerLine());

        // TODO conversion...

        QImage wrapper( input->bits(),
                    input->width(),
                    input->height(),
                    input->bytesPerLine(),
                    QVideoFrame::imageFormatFromPixelFormat(input->pixelFormat()));

        qDebug() << input->pixelFormat() << QVideoFrame::imageFormatFromPixelFormat(input->pixelFormat());

        if (wrapper.isNull()) {
            qDebug() << "null";
            if (input->handleType() == QAbstractVideoBuffer::NoHandle)
                input->unmap();
            return *input;
        }

        //QImage img = wrapper.convertToFormat(QImage::Format_RGB32).rgbSwapped();
        //cv::Mat cvImg(img.height(), img.width(), CV_8UC4, (void *) img.bits(), img.bytesPerLine());
        //wrapper.rgbSwapped();
        //cv::Mat cvImg(wrapper.height(), wrapper.width(), CV_8UC4, (void *) wrapper.bits(), wrapper.bytesPerLine());

        QImage rgb = wrapper.convertToFormat(QImage::Format_RGB888);
        cv::Mat cvImg(rgb.height(), rgb.width(), CV_8UC3, (void*) rgb.scanLine(0), rgb.bytesPerLine());

        qDebug() << "C2";

        std::vector<cv::Point2f> square = scanner::find_square(cvImg); // TODO thread

        if (input->handleType() == QAbstractVideoBuffer::NoHandle)
            input->unmap();

        qDebug() << "C3";

        QPolygonF polygon;
        for (unsigned int i=0;i<square.size();i++)
            polygon << QPointF(square[i].x, square[i].y);

        qDebug() << "C4";

        m_filter->finished(polygon);
    }

    return *input;
}
