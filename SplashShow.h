#ifndef SPLASHSHOW_H
#define SPLASHSHOW_H

#include <QObject>
#include <QQuickView>

class SplashShow : public QObject
{
    Q_OBJECT
public:
    SplashShow(QQuickView* viewer);
    void start();
    Q_INVOKABLE void end();

public slots:
    void init();

private:
    QQuickView* viewer_;
};

#endif // SPLASHSHOW_H
