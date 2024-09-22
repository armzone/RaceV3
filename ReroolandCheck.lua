-- ฟังก์ชันสำหรับการเช็คและสร้างไฟล์
local function CheckAndCreateFile(fileName, data)
    if not pcall(readfile, fileName) then
        writefile(fileName, data)
        print("File created and data written:", fileName)
        return true -- คืนค่า true หากไฟล์ถูกสร้างสำเร็จ
    else
        print("File already exists:", fileName)
        return false -- คืนค่า false หากไฟล์มีอยู่แล้ว
    end
end

-- ฟังก์ชันสำหรับการเปลี่ยนเผ่า
local function changeRace()
    local args = {
        [1] = "BlackbeardReward",
        [2] = "Reroll",
        [3] = "2"
    }

    -- เรียกใช้ฟังก์ชัน InvokeServer เพื่อเปลี่ยนเผ่า
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
    print("Changing race...")
end

-- ฟังก์ชันหลักสำหรับการเช็คและสร้างไฟล์ตามเผ่าที่กำหนด
local function checkAndCreateFileIfNeeded()
    local player = game:GetService("Players").LocalPlayer
    local raceValue = player.Data.Race.Value
    local playerName = player.Name -- ดึงชื่อผู้เล่น

    -- วนลูปเพื่อทำงานจนกว่าจะได้เผ่าที่อยู่ใน _G.Race และถูกตั้งค่าเป็น true
    while not _G.Race[raceValue] do
        print("Current race:", raceValue, "not allowed. Attempting to change race.")
        changeRace() -- เรียกใช้ฟังก์ชันเพื่อเปลี่ยนเผ่า
        wait(5) -- รอ 5 วินาทีเพื่อให้เผ่าเปลี่ยนแล้วตรวจสอบใหม่
        raceValue = player.Data.Race.Value -- อัพเดตค่าเผ่าของผู้เล่นหลังจากเปลี่ยน
    end

    print("Race changed to:", raceValue, "Proceeding with file check...")

    -- เผ่าเป็นที่ยอมรับแล้ว ทำการสร้างไฟล์ตามเงื่อนไขที่ต้องการ
    while true do
        local args = {
            [1] = "Wenlocktoad",
            [2] = "1"
        }

        -- เรียกใช้ฟังก์ชัน InvokeServer และเก็บค่าที่คืนกลับมา
        local result = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))

        -- แสดงผลหรือจัดการกับค่าที่คืนกลับมา
        print(result)

        -- เช็คค่าที่ได้และทำการสร้างไฟล์ถ้าค่าตรงตามเงื่อนไข
        if result == -2 then
            local fileCreated = CheckAndCreateFile(playerName .. ".txt", "Completed-Somethingyouwantowritehere")
            if fileCreated then
                break -- ออกจากลูปเมื่อสร้างไฟล์แล้ว
            end
        else
            -- หากค่าไม่เท่ากับ -2 ให้พิมพ์ข้อความ
            print("กำลังรอ v3")
        end

        wait(5) -- รอ 5 วินาทีก่อนทำการเช็คอีกครั้ง
    end
end

-- เรียกใช้งานฟังก์ชัน
checkAndCreateFileIfNeeded()
