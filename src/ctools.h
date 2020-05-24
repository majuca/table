#ifndef CTOOLS_H
#define CTOOLS_H

#include <QObject>
#include <QTranslator>
#include <QQmlApplicationEngine>

class CTools : public QObject
{
    Q_OBJECT
public:
    explicit CTools(QObject *parent = nullptr, QQmlApplicationEngine *engine=nullptr);

    void loadTranslator(const QString& rLanguage);

    Q_INVOKABLE void switchLanguage(QString language);
    Q_INVOKABLE QStringList getLanguageList();

protected:
    void switchTranslator(QTranslator& translator, const QString& rLanguage);
    void switchTranslatorQt(QTranslator& translator, const QString& rLanguage);

private:
    QTranslator m_translator; // contains the translations for this application
    QTranslator m_translatorQt; // contains the translations for qt
    QTranslator m_translatorQtBase; // contains the translations for qt
    QTranslator m_translatorQtQuick; // contains the translations for qt
    QString m_currLang; // contains the currently loaded language
    QString m_langPath; // Path of language files. This is always fixed to /languages.
    QQmlApplicationEngine *m_engine;
};

#endif // CTOOLS_H
