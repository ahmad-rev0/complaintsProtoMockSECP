const express = require("express");
const cors = require("cors");
const path = require("path");
const fs = require("fs");

const app = express();
const port = 61950;

app.use(cors());
app.use(express.static("secpappactualtests"));

// Serve Flutter project information
app.get("/", (req, res) => {
  const flutterProjectPath = path.join(__dirname, "secpappactualtests");

  res.send(`
    <!DOCTYPE html>
    <html>
    <head>
        <title>Flutter Project - Development Info</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                max-width: 800px;
                margin: 50px auto;
                padding: 20px;
                background-color: #f5f5f5;
            }
            .container {
                background: white;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            .warning {
                background: #fff3cd;
                border: 1px solid #ffeaa7;
                color: #856404;
                padding: 15px;
                border-radius: 4px;
                margin: 20px 0;
            }
            .info {
                background: #d1ecf1;
                border: 1px solid #bee5eb;
                color: #0c5460;
                padding: 15px;
                border-radius: 4px;
                margin: 20px 0;
            }
            pre {
                background: #f8f9fa;
                padding: 15px;
                border-radius: 4px;
                overflow-x: auto;
            }
            h1 { color: #0175C2; }
            h2 { color: #333; }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>🚀 Flutter Project Detected</h1>

            <div class="warning">
                <strong>⚠️ Flutter Development Environment Required</strong><br>
                This is a Flutter project that requires the Flutter SDK to run properly.
            </div>

            <h2>📱 Project Information</h2>
            <ul>
                <li><strong>Project Name:</strong> secpactualtests</li>
                <li><strong>Framework:</strong> Flutter</li>
                <li><strong>Description:</strong> A Flutter application for SECP XS Mobile sign-in</li>
                <li><strong>Platform Support:</strong> Android, iOS, Web, Desktop</li>
            </ul>

            <h2>🛠️ To Run This Project Properly</h2>
            <div class="info">
                <p><strong>Install Flutter SDK:</strong></p>
                <ol>
                    <li>Download Flutter from <a href="https://flutter.dev/docs/get-started/install" target="_blank">https://flutter.dev</a></li>
                    <li>Add Flutter to your PATH</li>
                    <li>Run <code>flutter doctor</code> to verify installation</li>
                </ol>
            </div>

            <h2>🚀 Development Commands</h2>
            <p>Once Flutter is installed, navigate to the project directory and run:</p>
            <pre>cd secpappactualtests
flutter pub get              # Install dependencies
flutter run -d web          # Run on web
flutter run -d android      # Run on Android
flutter run -d ios          # Run on iOS</pre>

            <h2>📁 Project Structure</h2>
            <ul>
                <li><strong>lib/</strong> - Main Dart source code</li>
                <li><strong>assets/</strong> - Images, fonts, and other assets</li>
                <li><strong>android/</strong> - Android-specific configuration</li>
                <li><strong>ios/</strong> - iOS-specific configuration</li>
                <li><strong>web/</strong> - Web-specific configuration</li>
            </ul>

            <h2>📋 Available Screens</h2>
            <ul>
                <li><strong>Sign In Screen</strong> (/) - Main entry point</li>
                <li><strong>Dashboard Screen</strong> (/dashboard) - Main dashboard interface</li>
                <li><strong>Report New Screen</strong> (/report-new) - New report creation</li>
            </ul>

            <h2>🎨 App Theme</h2>
            <ul>
                <li><strong>Primary Color:</strong> #087A84 (Teal)</li>
                <li><strong>Font Family:</strong> Inter</li>
                <li><strong>Material Design:</strong> Enabled</li>
            </ul>

            <h2>🔧 Current Status</h2>
            <div class="info">
                <strong>✅ Development Server Running</strong><br>
                The Node.js development server is now properly configured and running on port 61950.<br>
                To run the actual Flutter application, you'll need to install the Flutter SDK.
            </div>

            <p><em>This page is served by a temporary Node.js server. To develop the Flutter application properly, please install the Flutter SDK.</em></p>
        </div>
    </body>
    </html>
  `);
});

// API endpoint to get project structure
app.get("/api/project-info", (req, res) => {
  try {
    const pubspecPath = path.join(
      __dirname,
      "secpappactualtests",
      "pubspec.yaml",
    );
    const pubspecContent = fs.readFileSync(pubspecPath, "utf8");

    res.json({
      projectType: "flutter",
      pubspec: pubspecContent,
      hasFlutterSdk: false,
      message: "Flutter SDK required for proper development",
    });
  } catch (error) {
    res.status(500).json({ error: "Unable to read project information" });
  }
});

// API endpoint to get Flutter source code
app.get("/api/source/:filename", (req, res) => {
  try {
    const filename = req.params.filename;
    const safePath = path.join(
      __dirname,
      "secpappactualtests",
      "lib",
      filename,
    );

    // Security check to prevent directory traversal
    if (
      !safePath.startsWith(path.join(__dirname, "secpappactualtests", "lib"))
    ) {
      return res.status(403).json({ error: "Access denied" });
    }

    const sourceContent = fs.readFileSync(safePath, "utf8");
    res.json({
      filename: filename,
      content: sourceContent,
      language: "dart",
    });
  } catch (error) {
    res.status(404).json({ error: "Source file not found" });
  }
});

// Serve static files from Flutter project
app.use("/flutter", express.static(path.join(__dirname, "secpappactualtests")));

app.listen(port, () => {
  console.log(`🚀 Development server running on http://localhost:${port}`);
  console.log(`📱 Flutter project detected: secpactualtests`);
  console.log(`⚠️  Flutter SDK required for proper development`);
  console.log(
    `📁 Project files available at: http://localhost:${port}/flutter`,
  );
  console.log(`🌐 Main app accessible at: http://localhost:${port}`);
});
