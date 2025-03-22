<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <style>
        /* Smooth animations for transitions */
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #1e0033, #4b0082);
            color: #ffffff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .login-container {
            background: rgba(0, 0, 0, 0.8);
            border-radius: 12px;
            padding: 30px;
            width: 100%;
            max-width: 500px;
            box-shadow: 0 10px 30px rgba(128, 0, 255, 0.8);
            text-align: center;
            animation: fadeIn 1s ease;
        }

        @keyframes fadeIn {
            0% { opacity: 0; }
            100% { opacity: 1; }
        }

        h1 {
            color: #ff80ff;
            text-shadow: 0 0 15px #ff00ff;
            margin-bottom: 20px;
            font-size: 2.5em;
        }

        .input-group {
            margin-bottom: 20px;
        }

        .input-group input {
            width: 100%;
            padding: 14px;
            border-radius: 8px;
            border: 2px solid #ff00ff;
            background: rgba(255, 255, 255, 0.1);
            color: #ffffff;
            font-size: 16px;
            transition: border 0.3s ease;
        }

        .input-group input:focus {
            border: 2px solid #ff80ff;
        }

        .login-button {
            background: linear-gradient(90deg, #ff00ff, #8000ff);
            color: #ffffff;
            padding: 14px;
            width: 100%;
            border-radius: 8px;
            border: none;
            font-size: 18px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .login-button:hover {
            background: linear-gradient(90deg, #8000ff, #ff00ff);
        }

        #admin-options, #admin-panel, #view-only-panel {
            display: none;
            margin-top: 20px;
            opacity: 0;
            transition: opacity 1s ease-in-out;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ff00ff;
            padding: 10px;
        }

        table th {
            background-color: #1e0033;
        }

        table td {
            background-color: #2a003d;
        }

        .edit-button, .remove-button, .save-button {
            background-color: #ff00ff;
            color: #ffffff;
            border: none;
            padding: 5px 10px;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .edit-button:hover, .remove-button:hover, .save-button:hover {
            background-color: #8000ff;
        }

        .error {
            font-size: 14px;
            color: white;
            padding: 10px;
            background-color: rgba(255, 0, 0, 0.6);
            border-radius: 5px;
            margin-top: 20px;
        }

    </style>
</head>
<body>
    <div class="login-container">
        <h1>Login</h1>
        <form id="loginForm">
            <div class="input-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="input-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit" class="login-button">Login</button>
            <p id="error-message" class="error" style="display: none;">Invalid username or password</p>
        </form>

        <div id="admin-options">
            <h2>Welcome, Admin!</h2>
            <button id="manage-credentials" class="login-button">Manage Credentials</button>
            <button id="go-to-website" class="login-button">Go to Website</button>
        </div>

        <div id="view-only-panel">
            <h2>View Credentials</h2>
            <table id="credentials-table">
                <thead>
                    <tr>
                        <th>Username</th>
                        <th>Password</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Credentials will be dynamically added here -->
                </tbody>
            </table>
        </div>

        <div id="admin-panel">
            <h2>Admin Panel</h2>
            <div>
                <label for="new-username">New Username:</label>
                <input type="text" id="new-username">
            </div>
            <div>
                <label for="new-password">New Password:</label>
                <input type="text" id="new-password">
            </div>
            <button id="add-credential" class="login-button">Add Credential</button>
            <button id="save-credentials" class="save-button">Save Credentials</button>
            <table id="admin-credentials-table">
                <thead>
                    <tr>
                        <th>Username</th>
                        <th>Password</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Credentials will be dynamically added here -->
                </tbody>
            </table>
        </div>
    </div>

    <script>
        let credentials = JSON.parse(localStorage.getItem('credentials')) || {
            "Admin/AIMASAH": "2012142",
            "M.M.G": "21082011",
            "Y.M.G": "21082011",
            "S.A.S": "S%!A*lk",
            "M.A.S": "P0@h*&",
            "A.M.K": "@bb%nh*^",
            "Y.A.A": "Y#$hh*j!",
            "Y.M.A": "AL*&bb^2",
            "Z.M.G": "!@hh^&23",
            "Y.A.F": "@odn!!@3$",
            "K.W.A":"KHIDO",
            "TACCPP/OIS": "TACCPP/OIS",
            "NEJAR":"jiji",
            "AIMASAH":"2012142"
        };

        const loginForm = document.getElementById('loginForm');
        const adminOptions = document.getElementById('admin-options');
        const adminPanel = document.getElementById('admin-panel');
        const viewOnlyPanel = document.getElementById('view-only-panel');
        const errorMessage = document.getElementById('error-message');
        const credentialsTable = document.getElementById('credentials-table').querySelector('tbody');
        const adminCredentialsTable = document.getElementById('admin-credentials-table').querySelector('tbody');
        const saveButton = document.getElementById('save-credentials');

        function saveCredentials() {
            localStorage.setItem('credentials', JSON.stringify(credentials));
            alert('Credentials saved successfully!');
        }

        function populateTable() {
            // For view-only panel
            credentialsTable.innerHTML = '';
            for (const [username, password] of Object.entries(credentials)) {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${username}</td>
                    <td>${password}</td>
                `;
                credentialsTable.appendChild(row);
            }

            // For admin panel
            adminCredentialsTable.innerHTML = '';
            for (const [username, password] of Object.entries(credentials)) {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${username}</td>
                    <td>${password}</td>
                    <td>
                        <button class="edit-button" onclick="editCredential('${username}')">Edit</button>
                        <button class="remove-button" onclick="removeCredential('${username}')">Remove</button>
                    </td>
                `;
                adminCredentialsTable.appendChild(row);
            }
        }

        loginForm.addEventListener('submit', function (e) {
            e.preventDefault();
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;

            if (credentials[username] === password) {
                if (username === "Admin/AIMASAH") {
                    adminOptions.style.display = 'block';
                    setTimeout(() => {
                        adminOptions.style.opacity = 1;
                    }, 100);
                } else if (username === "M.M.G" || username === "Y.M.G") {
                    viewOnlyPanel.style.display = 'block';
                    setTimeout(() => {
                        viewOnlyPanel.style.opacity = 1;
                    }, 100);
                    populateTable();
                } else {
                    window.location.href = "Main.html";
                }
                errorMessage.style.display = 'none';
            } else {
                errorMessage.style.display = 'block';
            }
        });

        document.getElementById('manage-credentials').addEventListener('click', function () {
            adminPanel.style.display = 'block';
            setTimeout(() => {
                adminPanel.style.opacity = 1;
            }, 100);
            adminOptions.style.display = 'none';
            populateTable();
        });

        document.getElementById('add-credential').addEventListener('click', function () {
            const newUsername = document.getElementById('new-username').value;
            const newPassword = document.getElementById('new-password').value;

            if (newUsername && newPassword) {
                credentials[newUsername] = newPassword;
                populateTable();
                alert('Credential added successfully!');
            }
        });

        saveButton.addEventListener('click', saveCredentials);

        function editCredential(username) {
            const newUsername = prompt('Enter new username:', username);
            const newPassword = prompt('Enter new password:', credentials[username]);

            if (newUsername && newPassword) {
                credentials[newUsername] = newPassword;
                if (newUsername !== username) {
                    delete credentials[username];
                }
                populateTable();
                alert('Credential updated successfully!');
            }
        }

        function removeCredential(username) {
            const confirmation = confirm(`Are you sure you want to remove the credential for ${username}?`);

            if (confirmation) {
                delete credentials[username];
                populateTable();
                alert('Credential removed successfully!');
            }
        }

        // Populate table on page load
        populateTable();
    </script>
</body>
</html>
