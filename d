<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
      href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css"
      rel="stylesheet"
    />

    <link href="./output.css" rel="stylesheet" />
    <link href="./styles.css" rel="stylesheet" />
    <title>Document</title>
    <style>
      .scrollable {
        max-height: 500px;
        overflow-y: auto;
      }
    </style>
  </head>
  <body class="bg-[#F6F7F8] p-[18px]">
    <nav
      class="px-[32px] h-[72px] bg-[#FFFFFF] rounded-[70px] flex items-center justify-between"
    >
      <!--first-->
      <img src="./static/TestLogo.svg" alt="logo" />
      <!--second-->
      <div class="flex gap-[40px]">
        <div class="flex gap-[9px] items-center">
          <img src="./static/home.svg" alt="overview" />
          <p class="text-[#072635] text-[14px] font-bold leading-[19px]">
            Overview
          </p>
        </div>
        <div class="flex gap-[9px] items-center">
          <img src="./static/group.svg" alt="overview" />
          <p class="text-[#072635] text-[14px] font-bold leading-[19px]">
            Patients
          </p>
        </div>
        <div class="flex gap-[9px] items-center">
          <img src="./static/calendar.svg" alt="overview" />
          <p class="text-[#072635] text-[14px] font-bold leading-[19px]">
            Schedule
          </p>
        </div>
        <div class="flex gap-[9px] items-center">
          <img src="./static/chat.svg" alt="overview" />
          <p class="text-[#072635] text-[14px] font-bold leading-[19px]">
            Messages
          </p>
        </div>
        <div class="flex gap-[9px] items-center">
          <img src="./static/card.svg" alt="overview" />
          <p class="text-[#072635] text-[14px] font-bold leading-[19px]">
            Transactions
          </p>
        </div>
      </div>
      <!--third-->
      <div class="flex gap-[8px] items-center">
        <img
          src="./static/senior-woman-doctor-and-portrait-smile-for-health-2023-11-27-05-18-16-utc.png"
          alt="senior woman"
        />
        <div class="pr-[12px] border-r border-[#EDEDED]">
          <p class="text-[#072635] text-[14px] font-bold leading-[19px]">
            Dr. Jose Simmons
          </p>
          <p class="text-[#707070] text-[14px] leading-[19px]">
            General Practitioner
          </p>
        </div>
        <div class="flex gap-[12px] items-center">
          <img src="./static/settings.svg" alt="settings" />
          <img src="./static/more.svg" alt="hamburger icon" />
        </div>
      </div>
    </nav>
    <!--body-->
    <div class="mt-[32px] container flex gap-[32px]">
      <aside class="bg-[#FFFFFF] patient-list p-5">
        <div class="w-[317px]">
          <h2 class="text-xl font-bold mb-4">Patients</h2>
        </div>

        <ul id="patient-list" class="space-y-4 scrollable"></ul>
      </aside>
      <div class="bg-[#ffffff] graph-container patient-list"></div>
      <!--w-[367px]-->
      <div class="patient-list jessica" id="jessica-info">
        <!-- Jessica's detailed information will be injected here -->
      </div>
    </div>
    <script>
      async function fetchPatients() {
        const username = "coalition";
        const password = "skills-test";
        // btoa
        const secureCredentials = btoa(`${username}:${password}`);

        try {
          // Make the fetch request with the encoded credentials in the Authorization header
          const response = await fetch(
            "https://fedskillstest.coalitiontechnologies.workers.dev",
            {
              headers: {
                Authorization: `Basic ${secureCredentials}`,
              },
            }
          );

          if (!response.ok) {
            throw new Error(
              "Network response was not ok " + response.statusText
            );
          }

          const patients = await response.json();

          const patientList = document.getElementById("patient-list");

          patients.slice(0, 11).map((patient) => {
            const listItem = document.createElement("li");
            listItem.className =
              "flex items-center justify-between p-2 w-[317px] rounded-lg shadow-sm";

            listItem.innerHTML = `
                            <div class="flex  items-center">
                                <img src="${patient.profile_picture}" alt="${patient.name}" class="w-10 h-10 rounded-full mr-4">
                                <div>
                                    <p class="font-semibold">${patient.name}</p>
                                    <div class="flex">
                                      <p class="smtxt text-gray-500">${patient.gender} ${patient.age}</p>
                                    </div>
                                </div>
                            </div>
                            <img src="./static/moreh.svg" alt="more"/>
                        `;
            patientList.appendChild(listItem);
          });

          // Extract Jessica Taylor's details
          const jessica = patients.find(
            (patient) => patient.name === "Jessica Taylor"
          );
          if (jessica) {
            const formatDate = (dateString) => {
              const date = new Date(dateString);
              const options = {
                year: "numeric",
                month: "long",
                day: "numeric",
              };
              return new Intl.DateTimeFormat("en-US", options).format(date);
            };
            const jessicaInfo = document.getElementById("jessica-info");
            jessicaInfo.innerHTML = `
              <div class="flex  flex-col bg-[#fffff] border ">
                <br>
                <div class="flex flex-col items-center ">
                  <div class="flex pb-[24px]  justify-center ">
                    <img src="${jessica.profile_picture}" alt="${
              jessica.name
            }" class=" img-info ">
                  </div>
                  <br>
                  <h2 class="text-2xl  font-bold mb-2">${jessica.name}</h2>
                </div>
                <div class="flex border px-[12px] gap-[12px]">
                  <div class=" img-info flex items-center justify-center  bg-[#F6F7F8] ">
                    <img src="./static/calendar.svg" alt="calendar" class=""/>  
                  </div>
                    <div>
                    <p class="text-gray-600 mb-1">Date of Birth </p>
                    <p class="text-[14px] font-bold leading-[19px] text-[#072635]">${formatDate(
                      jessica.date_of_birth
                    )}</p>
                  </div>
                </div>
                
                <p class="text-gray-600 mb-1">Gender </p>
                <p class="text-[14px] font-bold leading-[19px] text-[#072635]">${
                  jessica.gender
                }</p>
                <p class="text-gray-600 mb-1">Contact Info </p>
                <p class="text-[14px] font-bold leading-[19px] text-[#072635]">${
                  jessica.phone_number
                }</p>
                <p class="text-gray-600 mb-1">Emergency Contacts </p>
                <p class="text-[14px] font-bold leading-[19px] text-[#072635]">${
                  jessica.emergency_contact
                }</p>
                <p class="text-gray-600 mb-1">Insurance Provider </p>
                <p class="text-[14px] font-bold leading-[19px] text-[#072635]">${
                  jessica.insurance_type
                }</p>
                
              </div>
            `;
          }
        } catch (error) {
          console.error("Fetch error: ", error);
        }
      }

      // Fetch patients when the window loads
      window.onload = fetchPatients;
    </script>
  </body>
</html>
