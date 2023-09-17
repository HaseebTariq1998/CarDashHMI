#ifndef WEATHER_H
#define WEATHER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QByteArray>
#include <QThread>
#include <QtConcurrent>

class Weather : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double temperatureCelsius READ temperatureCelsius NOTIFY temperatureChanged)

public:
    explicit Weather(QObject *parent = nullptr);

    double temperatureCelsius() const;

public slots:
    void fetchWeatherData();

signals:
    void temperatureChanged(double temperature);

private slots:
    void onWeatherDataReceived(QNetworkReply *reply);

private:
    QNetworkAccessManager networkManager;
    double temperatureInCelsius;

    const QString apiKey = "61a13d4701b9455cf9faa40fae55c836";  // Replace with your OpenWeatherMap API key
    const QString apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=Islamabad,Pakistan&appid=" + apiKey;


};

#endif // WEATHER_H
