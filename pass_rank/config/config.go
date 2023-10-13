package config

import (
	"log"
	"os"
	"path/filepath"
)

var PREFIX = func() string {
	if dir, exists := os.LookupEnv("PASSWORD_STORE_DIR"); exists {
		return dir
	}
	return filepath.Join(homeDir(), ".password-store")
}()

func homeDir() (home string) {
	var err error
	if home, err = os.UserHomeDir(); err != nil {
		log.Fatal(err)
	}
	return
}
