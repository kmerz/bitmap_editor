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

## Set single pixel

Setting a single pixel on the canvas needs the `L` command. It take three
arguments:

   * `x` Integer between 1 and 255 which is used for the coordinate.
   * `y` Integer between 1 and 255 which is used for the coordinate.
   * `c` A color which is present as as a capital letter from A to Z

This example creates a 6 to 5 pixel canvas and sets a pixel to 2 3 in the color A.
After that it prints the result.
```
I 6 5
L 2 3 A
S
```
