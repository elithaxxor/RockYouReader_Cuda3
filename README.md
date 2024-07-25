# CUDA-Based Keyword Search in Large Files

This C program uses CUDA to search for a specific keyword in large text files by leveraging GPU parallel processing for improved performance. The program reads the file in chunks, offloads the keyword search to the GPU, and outputs the positions where the keyword is found.

## Features

- **Parallel Processing**: Uses CUDA to accelerate the keyword search in large files.
- **Efficient Memory Management**: Allocates and frees memory efficiently on both the host and the device.
- **Chunk-Based Processing**: Reads the file in chunks to handle large files without excessive memory usage.

## Requirements

- CUDA Toolkit installed on your system.
- A CUDA-compatible GPU.
- `nvcc` compiler for compiling CUDA code.

## Installation

1. **Clone the Repository**:
   ```sh
   git clone https://github.com/yourusername/cuda-keyword-search.git
   cd cuda-keyword-search


## Compile 
- nvcc -o keyword_search keyword_search.cu
