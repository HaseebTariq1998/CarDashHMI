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
    Q_PROPERTY(WeatherState weatherState READ getWeatherState WRITE setWeatherState NOTIFY weatherStateChanged)
    Q_PROPERTY(double ambientTemperature READ ambientTemperature WRITE setAmbientTemperature NOTIFY  ambientTemperatureChanged)

public:
    enum WeatherState {
         Clear,
         Clouds,
         Rain,
         Snow,
         Thunderstorm,
         Drizzle,
         Mist,
         Unknown
     };
     Q_ENUM(WeatherState)

    // Constructor
    explicit Weather(QObject *parent = nullptr);

    // Public functions
    double extractTemperature(const QJsonObject &jsonObject);
    QString extractMainWeather(const QJsonObject &jsonObject);
    WeatherState mainWeatherToEnum(const QString &mainWeather);

    // Getters and Setters
    Weather::WeatherState getWeatherState() const;
    void setWeatherState(WeatherState newWeatherState);
    double ambientTemperature() const;
    void setAmbientTemperature(double newAmbientTemperature);

public slots:
    void fetchWeatherData();

signals:
    void weatherStateChanged(WeatherState weatherState);
    void ambientTemperatureChanged(double m_ambientTemperature);

private slots:
    void onWeatherDataReceived(QNetworkReply *reply);

private:
    const QString m_apiKey = "61a13d4701b9455cf9faa40fae55c836";
    const QString m_countary = "Pakistan";
    const QString m_city = "Islamabad";
    const QString apiUrl = QString("https://api.openweathermap.org/data/2.5/weather?q=%1,%2&appid=%3").arg(m_city).arg(m_countary).arg(m_apiKey) ;
    QNetworkAccessManager m_networkManager;
    WeatherState m_weatherState;
    double m_ambientTemperature;
};

#endif // WEATHER_H
