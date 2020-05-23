#include "ctools.h"
#include <QLocale>
#include <QApplication>
#include <QDebug>

CTools::CTools(QObject *parent) : QObject(parent)
{

}

void CTools::switchTranslator(QTranslator& translator, const QString &rLanguage)
{
    qApp->removeTranslator(&translator);
    if(translator.load(":/lang/" + rLanguage )) {
        qDebug()<< "JJJ";
        qApp->installTranslator(&translator);
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
      switchTranslator(m_translatorQt, QString("qt_%1.qm").arg(rLanguage));
     }
}
