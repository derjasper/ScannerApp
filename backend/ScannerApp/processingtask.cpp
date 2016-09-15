#include "processingtask.h"

#include <scanner.h>
#include <cvmatandqimage.h>

#include <QDebug>

// from: http://stackoverflow.com/questions/15043152/rotate-opencv-matrix-by-90-180-270-degrees
void rot90(cv::Mat &matImage, int rotflag){
  //1=CW, 3=CCW, 2=180
  if (rotflag == 1){
    transpose(matImage, matImage);
    flip(matImage, matImage,1); //transpose+flip(1)=CW
  } else if (rotflag == 3) {
    transpose(matImage, matImage);
    flip(matImage, matImage,0); //transpose+flip(0)=CCW
  } else if (rotflag ==2){
    flip(matImage, matImage,-1);    //flip(-1)=180
  }
}

void ProcessingTask::doWork() {
    if (!m_isTransformed) {
        m_transformed = cv::imread(m_url.toLocalFile().toStdString().c_str(), 1);
        m_transformed = scanner::process(m_transformed);
        m_isTransformed = true;
    }

    m_final = m_transformed.clone();
    scanner::adjust(m_final,m_mode);
    rot90(m_final,m_rotation);

    QImage result = QtOcv::mat2Image(m_final);

    workFinished(result);
}
