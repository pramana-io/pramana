package main

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"
)

func main() {
	root := &cobra.Command{
		Use:   "pramana",
		Short: "Version control for your running systems",
		Long: "Pramana records what was true, what changed, who changed it, " +
			"and whether it was allowed — across the systems your code runs on.",
	}

	root.AddCommand(&cobra.Command{
		Use:   "version",
		Short: "Print the version and exit",
		Run: func(cmd *cobra.Command, args []string) {
			fmt.Println("pramana", version)
		},
	})

	if err := root.Execute(); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}