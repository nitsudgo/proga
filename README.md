# proga (PROgramatically Generated Art)

## Getting started
1. Install Processing
1. Install `processing-java` from the processing `Tools` menu.
1. `cd` into the main `proga` folder of this project.
1. In the terminal, run the following code below.

    ```
    processing-java --sketch=$(pwd)/exotic_matter --run [0|1]
    ```

    Where you may pass an integer after the `--run` flag. If the integer is greater than zero, the sketch will run and save each frame. If the integer is less than or equal to 0, the sketch will run indefinitely until stopped.

For flexiblity and ease of exploration, not many of the sketches accept parameters from the command line (just go and edit them directly).