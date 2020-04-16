## 0.1.0

* *Initial release.*
* Allows the usage of the plugin on both the Go host as the Flutter side. 
  * When using the Go host it allows to set and get the shape of the cursor. 
  * Flutter implements the Go host which allows for direct access to the Setter and Getter of shape. It also provides a helper widget and extension to set the shape on hover.
* Currently no tests are provided.
* Flutter side does not check if current platform is Desktop. 