# Lab 10 Report - TensorFlow

## Checkpoint 1:

![](part1_1.png)

## Checkpoint 2:

```
# Plot the first X test images, their predicted label, and the true label
# Color correct predictions in blue, incorrect predictions in red
num_rows = 5
num_cols = 3
num_images = num_rows*num_cols
plt.figure(figsize=(2*2*num_cols, 2*num_rows))
for i in range(num_images):
  plt.subplot(num_rows, 2*num_cols, 2*i+1)
  plot_image(i + 9000, predictions[i + 9000], test_labels, test_images)
  plt.subplot(num_rows, 2*num_cols, 2*i+2)
  plot_value_array(i + 9000, predictions[i + 9000], test_labels)
plt.tight_layout()
plt.show()
```

![](part2_1.png)

## Checkpoint 3:

Clothing 1:

Original:

![](image1_shirt.png)

Greyscale:

![](shirt_grey.png)

Results:

![](shirt_results.png)

Clothing 2:

Original:

![](image1_shoe.png)

Greyscale:

![](shoe_grey.png)

Results:

![](shoe_results.png)

Clothing 3:

Original:

![](image1_pants.png)

Greyscale:

![](pants_grey.png)

Results:

![](pants_results.png)