#ifndef SCANNER_H
#define	SCANNER_H

#include <vector>
#include <opencv2/opencv.hpp>


namespace scanner {
    std::vector<cv::Point2f> find_square(const cv::Mat& image);
    cv::Mat transform(const cv::Mat& image, const std::vector<cv::Point2f>&);
    
    cv::Mat process(const cv::Mat& image);
    void adjust(cv::Mat& image, int mode);
};

#endif	/* SCANNER_H */

