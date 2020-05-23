#ifndef CTOOLS_H
#define CTOOLS_H

#include <QObject>
#include <QTranslator>

class CTools : public QObject
{
    Q_OBJECT
public:
    explicit CTools(QObject *parent = nullptr);

    void switchTranslator(QTranslator& translator, const QString& rLanguage);
    void loadTranslator(const QString& rLanguage);


private:
    QTranslator m_translator; // contains the translations for this application
    QTranslator m_translatorQt; // contains the translations for qt
    QString m_currLang; // contains the currently loaded language
    QString m_langPath; // Path of language files. This is always fixed to /languages.

};

#endif // CTOOLS_H
