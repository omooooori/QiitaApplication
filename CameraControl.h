#ifndef CAMERACONTROL_H
#define CAMERACONTROL_H

#include <QObject>

class CameraControl : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int  timerDuration       READ timerDuration WRITE setTimerDuration NOTIFY timerDurationChanged)
    Q_PROPERTY(bool isRedEye            READ isRedEye      WRITE setIsRedEye      NOTIFY isRedEyeChanged)
    Q_PROPERTY(bool isFrontCamera       READ isFrontCamera WRITE setIsFrontCamera NOTIFY isFrontCameraChanged)
    Q_PROPERTY(bool isCameraMode        READ isCameraMode  WRITE setIsCameraMode  NOTIFY isCameraModeChanged)
    Q_PROPERTY(int  flashType           READ flashType     WRITE setFlashType     NOTIFY flashTypeChanged)
    Q_PROPERTY(int  whiteBalance        READ whiteBalance  WRITE setWhiteBalance  NOTIFY whiteBalanceChanged)

public:
    explicit CameraControl(QObject *parent = nullptr);

    enum EFlashType {
        flashOff = 0,
        flashAuto,
        flashOn
    };
    Q_ENUMS(EFlashType)

    enum EWhiteBalance {
        wbAuto = 0,
        wbCloudy,
        wbFluorescent,
        wbSunlight,
        wbTungsten
    };
    Q_ENUMS(EWhiteBalance)

    int  timerDuration() const { return timerDuration_; }
    bool isRedEye()      const { return isRedEye_; }
    bool isFrontCamera() const { return isFrontCamera_; }
    bool isCameraMode()  const { return isCameraMode_; }
    int  flashType()     const { return flashType_; }
    int  whiteBalance()  const { return whiteBalance_; }

    Q_INVOKABLE QString getFlashName(int ft);
    Q_INVOKABLE QString getWhiteBalance(int wb);

signals:
    void timerDurationChanged();
    void isRedEyeChanged();
    void isFrontCameraChanged();
    void isCameraModeChanged();

    void flashTypeChanged();
    void whiteBalanceChanged();

public slots:
    void setTimerDuration(int timerDuration);
    void setIsRedEye(bool isRedEye);
    void setIsFrontCamera(bool isFrontCamera);
    void setIsCameraMode(bool isCameraMode);
    void setFlashType(int flashType);
    void setWhiteBalance(int whiteBalance);

private:
    int  timerDuration_;
    bool isRedEye_;
    bool isFrontCamera_;
    bool isCameraMode_;
    int  flashType_;
    int  whiteBalance_;
};

#endif // CAMERACONTROL_H
