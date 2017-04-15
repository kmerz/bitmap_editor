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

## Clear canvas

To clear a canvas with white pixels add C to the image processing file. This command
does not take any arguments.

The example creates a white canvas with 5 rows and 6 columns and then
clears it to white.
```
I 6 5
C
```

## Print canvas

To print the canvas add S to the image processing file. This command does not
take any arguments.

The example creates a white canvas with 5 rows and 6 columns and then
prints it.
```
I 6 5
S
```
