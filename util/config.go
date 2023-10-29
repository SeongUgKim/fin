package util

import "github.com/spf13/viper"

type Config struct {
	DBSource      string `mapstructure:"DB_SOURCE"`
	ServerAddress string `mapstructure:"SERVER_ADDRESS"`
}

// LoadConfig reads configuration from file or environment variables.
func LoadConfig(path string) (config Config, err error) {
	// tell Viper the location of the config file
	viper.AddConfigPath(path)
	// tell Viper to look for a config file
	viper.SetConfigName("app")
	viper.SetConfigType("env")

	// tell viper to automatically override values that it has read from config file
	// with the values of the corresponding env variable if they exists
	viper.AutomaticEnv()
	// start reading config values
	err = viper.ReadInConfig()
	if err != nil {
		return
	}

	// unmarshals the values into the target config
	err = viper.Unmarshal(&config)
	return
}
