#ifndef SCANNERFILTER_H
#define SCANNERFILTER_H

#include <QObject>
#include <QAbstractVideoFilter>
#include <QVideoFilterRunnable>
#include <QVideoFrame>
#include <QVideoSurfaceFormat>
#include <vector>
#include <opencv2/opencv.hpp>
#include "scanner.h"

class ScannerFilter;

class ScannerFilterRunnable : public QVideoFilterRunnable {
public:
    ScannerFilterRunnable(ScannerFilter *filter) : m_filter(filter) {}
     ~ScannerFilterRunnable() {}

    QVideoFrame run(QVideoFrame *input, const QVideoSurfaceFormat &surfaceFormat, RunFlags flags);

private:
     ScannerFilter *m_filter;

};

class ScannerFilter : public QAbstractVideoFilter {
    Q_OBJECT

public:
    ScannerFilter () : m_updateEdges(false) {

    }

    QVideoFilterRunnable *createFilterRunnable() { return new ScannerFilterRunnable(this); }
    Q_INVOKABLE void updateEdges() { m_updateEdges = true; }
    bool updatingEdges() { return m_updateEdges; }
    void edgesUpdated() { m_updateEdges = false; }
signals:
    void finished(QPolygonF result);
private:
    bool m_updateEdges;
};





#endif // SCANNERFILTER_H
