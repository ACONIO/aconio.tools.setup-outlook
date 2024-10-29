# aconio.tools.setup-outlook

A tool to set the `Registry Keys` to deactivate the `Trust Center` popup.

![Coding Cat](/docs/codingcat.webp)

## Installation & Usage:

1. Download the latest version of the Script from.
2. Extract the `.zip` onto the clients Desktop.
3. Set the correct `build_number` and `target_username` in `config.txt`.
4. Run the script as an `Administrator`.
5. ...
6. Check if the `Registry Keys` were set correctly
7. Success

## Configurables:

**To run this script successfully you need to set following Parameters:**

### Build Number:

This is the build nubmer of Outlook. You can read out the build number of Outlook following these steps:

1. Open Outlook.
2. Choose the `File`tab.
3. Select Office Account.
4. Click on `Product Information`.
5. You can find the `build number` like seen in the image below.
   ![Outlook Build Number](/docs/outlook_build_number.png)

### Target Username:

This is the name of the production user provided by the client.

## Notes:

After the script finishes executing, you can verify that the registry keys were set successfully by reviewing the Command Prompt output. The output displays each registry key along with its values, confirming that the keys were added or modified as intended. If any keys are missing or show incorrect values, you may need to review or re-run the script to ensure the settings were applied correctly.
