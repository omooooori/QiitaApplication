#include "CameraControl.h"


CameraControl::CameraControl(QObject *parent)
    : QObject(parent)
    , timerDuration_()
    , isRedEye_(true)
    , isFrontCamera_(true)
    , isCameraMode_(true)
    , flashType_(0)
    , whiteBalance_(0)
{}


void CameraControl::setTimerDuration(int timerDuration)
{
    if (timerDuration_ == timerDuration)
        return;

    timerDuration_ = timerDuration;
    emit timerDurationChanged();
}


void CameraControl::setIsRedEye(bool isRedEye)
{
    if (isRedEye_ == isRedEye)
        return;

    isRedEye_ = isRedEye;
    emit isRedEyeChanged();
}


void CameraControl::setIsFrontCamera(bool isFrontCamera)
{
    if (isFrontCamera_ == isFrontCamera)
        return;

    isFrontCamera_ = isFrontCamera;
    emit isFrontCameraChanged();
}


void CameraControl::setIsCameraMode(bool isCameraMode)
{
    if (isCameraMode_ == isCameraMode)
        return;

    isCameraMode_ = isCameraMode;
    emit isCameraModeChanged();
}


void CameraControl::setFlashType(int flashType)
{
    if (flashType_ == flashType)
        return;

    flashType_ = flashType;
    emit flashTypeChanged();
}


void CameraControl::setWhiteBalance(int whiteBalance)
{
    if (whiteBalance_ == whiteBalance)
        return;

    whiteBalance_ = whiteBalance;
    emit whiteBalanceChanged();
}


QString CameraControl::getFlashName(int ft)
{
    switch (ft) {
    case flashOff:
        return "flash-off";
    case flashAuto:
        return "flash-auto";
    case flashOn:
        return "flash";
    default:
        return "";
    }
}


QString CameraControl::getWhiteBalance(int wb)
{
    switch (wb) {
    case wbAuto:
        return "wb-auto";
    case wbCloudy:
        return "wb-cloudy";
    case wbFluorescent:
        return "wb-fluorescent";
    case wbSunlight:
        return "wb-sunlight";
    case wbTungsten:
        return "wb-tungsten";
    default:
        return "";
    }
}

