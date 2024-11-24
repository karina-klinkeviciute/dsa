document.addEventListener("DOMContentLoaded", function () {
    fetch('_static/versions.json')
        .then(response => response.json())
        .then(versions => {
            const select = document.createElement("select");
            select.id = "version-selector";
            select.style.margin = "10px";

            versions.forEach(version => {
                const option = document.createElement("option");
                option.value = version;
                option.textContent = version;
                if (window.location.pathname.includes(version)) {
                    option.selected = true;
                }
                select.appendChild(option);
            });

            select.addEventListener("change", function () {
                const selectedVersion = select.value;
                window.location.href = window.location.origin + "/dsa/" + selectedVersion + "/";
            });

            // Add the selector to the sidebar with class `.bd-sidebar-primary`
            const sidebar = document.querySelector(".bd-sidebar-primary");
            if (sidebar) {
                const div = document.createElement("div");
                div.id = "version-selector-container";
                div.appendChild(select);
                sidebar.appendChild(div);
            }
        })
        .catch(error => console.error('Error loading versions:', error));
});
