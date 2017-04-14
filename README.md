# Bitmap editor


# Running

`>bin/bitmap_editor examples/show.txt`

# Usage

## Initializing the canvas

To initilize the canvas with a white background start by adding the `I`
command to the image processing file. It takes to integer arguments:

   * `x` The amoount columns of the bitmap. The value should be between 1 and 255.
   * `y` The amoount rows of the bitmap. The value should be between 1 and 255.

The example creates a white canvas with 5 rows and 6 columns.
```
I 6 5
```
