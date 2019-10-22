#include "SplashShow.h"

#include <QCoreApplication>
#include <QtQml/QQmlContext>
#include <QQmlApplicationEngine>
#include <QDir>
#include <QThread>

#include <QDebug>

SplashShow::SplashShow(QQuickView* viewer)
    : viewer_(viewer)
{}

void SplashShow::start()
{
    qDebug() << "SplashShow::start() is called";
    QDir directory(QCoreApplication::applicationDirPath());

    QString path = directory.absoluteFilePath("../../SplashPage.qml");
    qDebug() << "SplashShow::init() path = " << path;
    viewer_->engine()->rootContext()->setContextProperty("SplashShow", this);
    viewer_->setSource(QUrl::fromLocalFile(path));
    viewer_->show();
}

void SplashShow::init()
{
    qDebug() << "SplashShow::init() is called";
    QThread::msleep(1000);
}

void SplashShow::end()
{
    qDebug() << "SplashShow::end() is called";
    viewer_->close();
}
