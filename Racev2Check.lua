-- ฟังก์ชันสำหรับเช็คและสร้างไฟล์
local function CreateFile(fileName, data)
    if not pcall(readfile, fileName) then
        writefile(fileName, data)
        print("File created and data written:", fileName)
        return true -- คืนค่า true หากไฟล์ถูกสร้างสำเร็จ
    else
        print("File already exists:", fileName)
        return false -- คืนค่า false หากไฟล์มีอยู่แล้ว
    end
end

-- ฟังก์ชันหลัก
local playerName = game:GetService("Players").LocalPlayer.Name
local fileName = playerName .. ".txt"
local fileData = "Completed-RaceV2"

while true do
    -- เรียกใช้ฟังก์ชัน InvokeServer และเก็บค่าที่คืนกลับมา
    local args = {
        [1] = "Wenlocktoad",
        [2] = "1"
    }
    local result = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))

    -- แสดงผลหรือจัดการกับค่าที่คืนกลับมา
    print("Result:", result)

    -- ตรวจสอบค่าของ result
    if result == 1 then
        local fileCreated = CreateFile(fileName, fileData)
        if fileCreated then
            print("File creation successful. Exiting loop.")
            break -- ออกจากลูปเมื่อสร้างไฟล์สำเร็จ
        else
            print("File already exists, skipping creation.")
        end
    else
        print("Result is not 0. Retrying in 10 seconds.")
    end

    wait(10) -- รอ 10 วินาทีก่อนลองใหม่
end
