#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <ctools.h>
#include <QDebug>
#include <QSettings>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setOrganizationName("Jean-Luc Gyger");
    app.setOrganizationDomain("jeanlucgyger.ch");
    app.setApplicationName("Table");

    app.setWindowIcon(QIcon(":/image/48x48/table.png"));


    QQmlApplicationEngine engine;

    CTools *tools = new CTools(NULL, &engine);
    QString defaultLocale = QLocale::system().name();
    defaultLocale.truncate(defaultLocale.lastIndexOf('_'));


    QSettings settings;
    QString currentLanguage = settings.value("currentLanguage",defaultLocale).toString();
    qDebug() << currentLanguage;


    tools->loadTranslator(currentLanguage);

    engine.rootContext()->setContextProperty("version", VERSION);
    engine.rootContext()->setContextProperty("qtVersion", QT_VERSION_STR);

    engine.rootContext()->setContextProperty("tools", tools);

    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
