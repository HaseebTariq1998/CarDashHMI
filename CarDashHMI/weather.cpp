#include "weather.h"

Weather::Weather(QObject *parent) : QObject(parent)
{
    temperatureInCelsius = 0;
    connect(&networkManager, &QNetworkAccessManager::finished, this, &Weather::onWeatherDataReceived);
    fetchWeatherData();

}

double Weather::temperatureCelsius() const
{
    return temperatureInCelsius;
}

void Weather::fetchWeatherData()
{

        QNetworkRequest request(QUrl(this->apiUrl));
        networkManager.get(request);

}

void Weather::onWeatherDataReceived(QNetworkReply *reply)
{
    if (reply->error() == QNetworkReply::NoError)
    {
        QByteArray data = reply->readAll();
        QJsonDocument jsonDoc = QJsonDocument::fromJson(data);

        if (!jsonDoc.isNull())
        {
            QJsonObject jsonObject = jsonDoc.object();
            if (jsonObject.contains("main"))
            {
                QJsonObject mainObject = jsonObject["main"].toObject();
                if (mainObject.contains("temp"))
                {
                    double temperatureKelvin = mainObject["temp"].toDouble();
                    double temperatureCelsius = temperatureKelvin - 273.15;  // Convert from Kelvin to Celsius
                    temperatureInCelsius = temperatureCelsius;
                    emit temperatureChanged(temperatureCelsius);
                }
            }
        }
    }

    reply->deleteLater();
}
