#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml/QQmlContext>
#include <QQuickView>

#ifdef Q_OS_ANDROID
#include <QtSvg>    //Because deployment sometimes just forgets to include this lib otherwise
#endif

#include <QtCore/QUrl>
#include <QtWebView/QtWebView>
#include <QtCore/QCommandLineOption>
#include <QtCore/QCommandLineParser>

#include <QDebug>

#include "SplashShow.h"

class Utils : public QObject {
    Q_OBJECT
public:
    Utils(QObject* parent = nullptr) : QObject(parent) { }
    Q_INVOKABLE static QUrl fromUserInput(const QString& userInput);
};

QUrl Utils::fromUserInput(const QString& userInput)
{
    if (userInput.isEmpty())
        return QUrl::fromUserInput("about:blank");
    const QUrl result = QUrl::fromUserInput(userInput);
    return result.isValid() ? result : QUrl::fromUserInput("about:blank");
}

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // For SplashShow
    // QQuickView viewer;
    // SplashShow* splash = new SplashShow(&viewer);
    // splash->start();
    // For SplashShow

    // make local folder
    QString appFolder(QStandardPaths::writableLocation(QStandardPaths::AppDataLocation) + "/QiitaApplication");
    QDir homePath(QStandardPaths::writableLocation(QStandardPaths::AppDataLocation));
    //check and create to the writable path
    if (homePath.exists()){
       homePath.mkdir("QiitaApplication");
       qDebug() << "make directory" << homePath;
    }else{
        QDir().mkpath(appFolder);
        qDebug() << "make path" << appFolder;
    }
    //just incase it was not created
    if (!homePath.cd("QiitaApplication")){
            homePath.mkpath("QiitaApplication");
    }

    // For QtWebView
    QtWebView::initialize();
    QCommandLineParser parser;
    const QString initialUrl = parser.positionalArguments().isEmpty() ?
        QStringLiteral("qt.io") : parser.positionalArguments().first();

    QQmlContext *context = engine.rootContext();
    context->setContextProperty(QStringLiteral("initialUrl"), Utils::fromUserInput(initialUrl));
    // For QtWebView

    // For SplashShow on Windows Application
   //  QQuickView viewer;
    // SplashShow* splash = new SplashShow(&viewer);
    // splash->start();
    // For SplashShow

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
