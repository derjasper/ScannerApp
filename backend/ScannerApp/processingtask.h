#ifndef PROCESSINGTASK_H
#define PROCESSINGTASK_H

#include <QUrl>
#include <QObject>
#include <QImage>

#include <opencv2/opencv.hpp>


class ProcessingTask : public QObject {
    Q_OBJECT
    public:
        ProcessingTask() :
            m_url(""),m_mode(0), m_rotation(0), m_isTransformed(false) {}
        ~ProcessingTask() {}

        void setUrl(QUrl url) {
            m_url = url;
            m_isTransformed = false;
        }

        void setMode(int mode) {
            m_mode = mode;
        }

        void setRotation(int rotation) {
            m_rotation = rotation;
        }

    public slots:
        void doWork();

    signals:
        void workFinished(QImage result);

    private:
        QUrl m_url;
        int m_mode;
        int m_rotation;
        bool m_isTransformed;
        cv::Mat m_transformed;
        cv::Mat m_final;
};

#endif // PROCESSINGTASK_H
