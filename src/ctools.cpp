#include "ctools.h"
#include <QLocale>
#include <QApplication>
#include <QDebug>
#include <QDir>



CTools::CTools(QObject *parent, QQmlApplicationEngine *engine) : QObject(parent)
{
    m_engine = engine;
}

void CTools::switchTranslator(QTranslator& translator, const QString &rLanguage)
{
    qApp->removeTranslator(&translator);
    if(translator.load(":/lang/" + rLanguage )) {
        qApp->installTranslator(&translator);
        m_engine->retranslate();
    }
}

void CTools::switchTranslatorQt(QTranslator& translator, const QString &rLanguage)
{
    qApp->removeTranslator(&translator);
    if(translator.load(":/qt_lang/" + rLanguage )) {
        qApp->installTranslator(&translator);
        m_engine->retranslate();
    }
}

void CTools::loadTranslator(const QString &rLanguage)
{
    if(m_currLang != rLanguage) {
      m_currLang = rLanguage;
      QLocale locale = QLocale(m_currLang);
      QLocale::setDefault(locale);
      QString languageName = QLocale::languageToString(locale.language());
      switchTranslator(m_translator, QString("Table_%1_150.qm").arg(rLanguage));
      switchTranslatorQt(m_translatorQt, QString("qt_%1.qm").arg(rLanguage));
      switchTranslatorQt(m_translatorQtBase, QString("qtbase_%1.qm").arg(rLanguage));
      switchTranslatorQt(m_translatorQtQuick, QString("qtquickcontrol_%1.qm").arg(rLanguage));
    }
}

void CTools::switchLanguage(QString language)
{
    switchTranslator(m_translator, QString("Table_%1_150.qm").arg(language));
    switchTranslatorQt(m_translatorQt, QString("qt_%1.qm").arg(language));
    switchTranslatorQt(m_translatorQtBase, QString("qtbase_%1.qm").arg(language));
    switchTranslatorQt(m_translatorQtQuick, QString("qtquickcontrol_%1.qm").arg(language));

}

QStringList CTools::getLanguageList()
{
    QStringList list;

    QDir dir(":/lang/");

    QFileInfoList l = dir.entryInfoList();

    for (int i = 0; i < l.size(); ++i) {
         QFileInfo fileInfo = l.at(i);
         QString lang = fileInfo.fileName().replace("Table_", "").replace("_150.qm","");

         list.append(lang);
    }

    return list;
}
