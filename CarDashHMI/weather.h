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
    Q_PROPERTY(double temperatureCelsius READ temperatureCelsius  NOTIFY temperatureChanged)
    Q_PROPERTY(WeatherState weatherState READ getWeatherState WRITE setWeatherState NOTIFY weatherStateChanged)


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


    explicit Weather(QObject *parent = nullptr);

    double temperatureCelsius() const;
    void setTemperatureCelsius(const double &temperatureCelsius);

    double extractTemperature(const QJsonObject &jsonObject);

    QString extractMainWeather(const QJsonObject &jsonObject);

    WeatherState mainWeatherToEnum(const QString &mainWeather);

    Weather::WeatherState getWeatherState() const;
    void setWeatherState(WeatherState newWeatherState);

public slots:
    void fetchWeatherData();

signals:
    void temperatureChanged(double temperature);

    void weatherStateChanged();

private slots:
    void onWeatherDataReceived(QNetworkReply *reply);

private:
    QNetworkAccessManager networkManager;
    double m_temperatureInCelsius;

    const QString apiKey = "61a13d4701b9455cf9faa40fae55c836";  // Replace with your OpenWeatherMap API key
    const QString apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=Islamabad,Pakistan&appid=" + apiKey;
    WeatherState m_weatherState;
};

#endif // WEATHER_H
