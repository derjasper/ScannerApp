#ifndef QMLSCANNER_H
#define QMLSCANNER_H

#include <QObject>
#include <QImage>
#include <QThread>
#include <QUrl>

#include "processingtask.h"

#include <QDebug>

class QmlScanner : public QObject
{
    Q_OBJECT
    Q_PROPERTY( bool busy READ busy NOTIFY busyChanged )
    Q_PROPERTY( int mode READ mode WRITE setMode NOTIFY modeChanged() )
    Q_PROPERTY( QUrl image READ image WRITE setImage NOTIFY imageChanged() )
    Q_PROPERTY( int rotation READ rotation WRITE setRotation NOTIFY rotationChanged() )

public:
    explicit QmlScanner(QObject *parent = 0) : QObject(parent), m_busy(false), m_mode(0), m_image(""), m_rotation(0) {
        task.moveToThread(&thread);
        connect( &thread, SIGNAL(started()), &task, SLOT(doWork()) );
        connect( &task, SIGNAL(workFinished(QImage)), &thread, SLOT(quit()) );
        connect( &task, SIGNAL(workFinished(QImage)), this, SLOT(processingFinished(QImage)) );
    }
    ~QmlScanner() {}

    void setMode(int m) {
        m_mode = m;
        modeChanged();

        task.setMode(m_mode);
        processImage();
    }
    void setImage(QUrl url) {
        m_image = url;
        imageChanged();

        task.setUrl(m_image);
        processImage();
    }
    void setRotation(int rot) {
        m_rotation = rot;
        rotationChanged();

        task.setRotation(m_rotation);
        processImage();
    }

    void processImage();

    Q_INVOKABLE void saveImage(QString path);

Q_SIGNALS:
    void busyChanged();
    void modeChanged();
    void imageChanged();
    void rotationChanged();

    void imageSaved(QUrl path);

    void processed(const QImage& image);

public slots:
    void processingFinished(const QImage& image);

protected:
    bool busy() {return m_busy;}
    int mode() {return m_mode;}
    QUrl image() {return m_image;}
    int rotation() {return m_rotation;}
    bool m_busy;
    int m_mode;
    QUrl m_image;
    int m_rotation;

    QThread thread;
    ProcessingTask task;

};

#endif // QMLSCANNER_H
