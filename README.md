# Weather Forecaster Application

The Weather Forecaster Application allows you to check the weather forecast for any city of your choice. It uses a weather API to provide up-to-date weather information. Follow the instructions below to run the app locally.

## Prerequisites

- Ruby on Rails installed on your machine
- A web browser (Google Chrome recommended)
- Access to the internet for fetching weather data

## Setup and Installation

1. **Clone the repository** to your local machine:

   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```

2. **Install required gems**:

   ```bash
   bundle install
   ```

3. **Cache the development environment** by running the following command:

   ```bash
   rails dev:cache
   ```

   This is needed to enable caching in the development environment.

4. **Start the web server** using the following command:

   ```bash
   bin/dev
   ```

   This will start the Rails server and open the app locally.

5. **Access the app** in your web browser (Google Chrome recommended):

   Open your browser and navigate to the following URL:

   ```
   http://localhost:3000/weather/show
   ```

6. **Check the weather forecast** for any city:

   Once you are on the weather page, enter the name of a city in the provided input field to view the forecast.

## Usage

- Type in the name of any city in the input field and press enter to see the weather forecast.
- You will receive details such as temperature, humidity, and other relevant weather information for the chosen city.

## Additional Information

If you encounter any issues or errors while setting up or running the app, feel free to check the logs for more details or contact the app maintainer.

Enjoy using the Weather Forecaster Application!
