package server

// Goal of this section of the code:
// Open all necessary torrents
// Receive data
// Write data to correct file

func main() int {
	go start_torrent()

	return 0
}
