# NativeScript Resources Generator

Helper script to generate image resources for both Android and iOS from a
sources image.

Executing the script with a source image as parameter, it will generate all the
necessary image sizes and automatically populate the `app/App_Resouces`
directory tree.


## Usage

Install the script:

    $ sudo cp nsresgen /usr/local/bin

And invoke it while inside the root directory of a NativeScript project, passing
an image as parameter:

    $ nsresgen ~/my/images/image.png

The `app/App_Resources` directory will be correctly populated, so you're now
able to use the resource from your code as usual:

```xml
<Image src="res://image"></Image>
```


## Dependencies

The *nsresgen* script depends upon the **imagemagick** package, so be sure to
have it in your system.
