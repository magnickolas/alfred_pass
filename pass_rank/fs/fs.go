package fs

import (
	"log"
	"os"
	"path/filepath"
	"strings"
)

func FindPasswords(passDir string) []string {
	var passwords []string

	if err := filepath.WalkDir(passDir, func(path string, info os.DirEntry, err error) error {
		if err != nil {
			return err
		}
		if !info.IsDir() && strings.HasSuffix(path, ".gpg") {
			relativePath, _ := filepath.Rel(passDir, path)
			password := strings.TrimSuffix(relativePath, ".gpg")
			passwords = append(passwords, password)
		}
		return nil
	}); err != nil {
		log.Fatal(err)
	}

	return passwords
}
