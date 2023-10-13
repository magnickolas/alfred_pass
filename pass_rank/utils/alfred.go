package utils

import (
	"encoding/json"
	"fmt"
	"os"
)

type item struct {
	Title string `json:"title"`
	Arg   string `json:"arg"`
}

type output struct {
	Items []item `json:"items"`
}

func SerializeItemsList(strs []string) string {
	jsonData := output{}

	for _, str := range strs {
		jsonData.Items = append(jsonData.Items, item{Title: str, Arg: str})
	}

	jsonBytes, err := json.Marshal(jsonData)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error marshaling JSON: %v\n", err)
		os.Exit(1)
	}
	return string(jsonBytes)
}
