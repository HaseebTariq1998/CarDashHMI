#include "weather.h"

Weather::Weather(QObject *parent) : QObject(parent)
{
    connect(&m_networkManager, &QNetworkAccessManager::finished, this, &Weather::onWeatherDataReceived);
    fetchWeatherData();
}

double Weather::extractTemperature(const QJsonObject &jsonObject)
{
    if (jsonObject.contains("main"))
    {
        QJsonObject mainObject = jsonObject["main"].toObject();
        if (mainObject.contains("temp"))
        {
            double temperatureKelvin = mainObject["temp"].toDouble();
            return temperatureKelvin - 273.15;  // Convert from Kelvin to Celsius
        }
    }
    return -1;  // Indicate failure
}

QString Weather::extractMainWeather(const QJsonObject &jsonObject)
{
    if (jsonObject.contains("weather"))
    {
        QJsonArray weatherArray = jsonObject["weather"].toArray();
        if (!weatherArray.isEmpty())
        {
            return weatherArray[0].toObject()["main"].toString();
        }
    }
    return QString();  // Empty string indicates no weather data
}

Weather::WeatherState Weather::mainWeatherToEnum(const QString &mainWeather)
{
    if (mainWeather == "Clear")
        return Weather::Clear;
    else if (mainWeather == "Clouds")
        return Weather::Clouds;
    else if (mainWeather == "Rain")
        return Weather::Rain;
    else if (mainWeather == "Snow")
        return Weather::Snow;
    else if (mainWeather == "Thunderstorm")
        return Weather::Thunderstorm;
    else if (mainWeather == "Thunderstorm")
        return Weather::Thunderstorm;
    else if (mainWeather == "Drizzle")
        return Weather::Drizzle;
    else if (mainWeather == "Drizzle")
        return Weather::Drizzle;
    else if (mainWeather == "Mist" || mainWeather == "Fog")
        return Weather::Mist;
    else
        return WeatherState::Unknown;
}

void Weather::fetchWeatherData()
{
    QNetworkRequest request(QUrl(this->apiUrl));
    m_networkManager.get(request);
}


void Weather::onWeatherDataReceived(QNetworkReply *reply)
{
    if (reply->error() != QNetworkReply::NoError)
    {
        QByteArray data = reply->readAll();
        QJsonDocument jsonDoc = QJsonDocument::fromJson(data);

        if (!jsonDoc.isNull())
        {
            QJsonObject jsonObject = jsonDoc.object();

            double temperatureCelsius = extractTemperature(jsonObject);
            if (temperatureCelsius != -1)
            {
                setAmbientTemperature(temperatureCelsius);
            }

            QString mainWeather = extractMainWeather(jsonObject);
            if (!mainWeather.isEmpty())
            {
                setWeatherState(mainWeatherToEnum(mainWeather));
            }
        }
    }
    reply->deleteLater();
}

Weather::WeatherState Weather::getWeatherState() const
{
    return m_weatherState;
}

void Weather::setWeatherState(WeatherState newWeatherState)
{
    if (m_weatherState == newWeatherState)
        return;
    m_weatherState = newWeatherState;
    emit weatherStateChanged(m_weatherState);
}

double Weather::ambientTemperature() const
{
    return m_ambientTemperature;
}

void Weather::setAmbientTemperature(double newAmbientTemperature)
{
    if (qFuzzyCompare(m_ambientTemperature, newAmbientTemperature))
        return;
    m_ambientTemperature = newAmbientTemperature;
    emit ambientTemperatureChanged(m_ambientTemperature);
}
