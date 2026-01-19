# flutter_lab_exam01

# ข้อสอบปฎิบัติครั้งที่ 1

|                      |                                                           |
| -------------------- | --------------------------------------------------------- |
| **เวลาสอบ**          | 2 ชั่วโมง                                                 |
| **คะแนนเต็ม**        | 70 คะแนน                                                  |
| **อุปกรณ์ที่อนุญาต** | คอมพิวเตอร์, Internet, เอกสาร, AI (ChatGPT, Gemini , ฯลฯ) |

|   |
|---|
|⚠ ![](data:image/png;base64,R0lGODlhGwAbAHcAMSH+GlNvZnR3YXJlOiBNaWNyb3NvZnQgT2ZmaWNlACH5BAEAAAAALAAAAAAbABoAhwAAAAAAAAAAMwAAZgAAmQAAzAAA/wAzAAAzMwAzZgAzmQAzzAAz/wBmAABmMwBmZgBmmQBmzABm/wCZAACZMwCZZgCZmQCZzACZ/wDMAADMMwDMZgDMmQDMzADM/wD/AAD/MwD/ZgD/mQD/zAD//zMAADMAMzMAZjMAmTMAzDMA/zMzADMzMzMzZjMzmTMzzDMz/zNmADNmMzNmZjNmmTNmzDNm/zOZADOZMzOZZjOZmTOZzDOZ/zPMADPMMzPMZjPMmTPMzDPM/zP/ADP/MzP/ZjP/mTP/zDP//2YAAGYAM2YAZmYAmWYAzGYA/2YzAGYzM2YzZmYzmWYzzGYz/2ZmAGZmM2ZmZmZmmWZmzGZm/2aZAGaZM2aZZmaZmWaZzGaZ/2bMAGbMM2bMZmbMmWbMzGbM/2b/AGb/M2b/Zmb/mWb/zGb//5kAAJkAM5kAZpkAmZkAzJkA/5kzAJkzM5kzZpkzmZkzzJkz/5lmAJlmM5lmZplmmZlmzJlm/5mZAJmZM5mZZpmZmZmZzJmZ/5nMAJnMM5nMZpnMmZnMzJnM/5n/AJn/M5n/Zpn/mZn/zJn//8wAAMwAM8wAZswAmcwAzMwA/8wzAMwzM8wzZswzmcwzzMwz/8xmAMxmM8xmZsxmmcxmzMxm/8yZAMyZM8yZZsyZmcyZzMyZ/8zMAMzMM8zMZszMmczMzMzM/8z/AMz/M8z/Zsz/mcz/zMz///8AAP8AM/8AZv8Amf8AzP8A//8zAP8zM/8zZv8zmf8zzP8z//9mAP9mM/9mZv9mmf9mzP9m//+ZAP+ZM/+ZZv+Zmf+ZzP+Z///MAP/MM//MZv/Mmf/MzP/M////AP//M///Zv//mf//zP///wECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwj/AAEIHEiwoMGDCAk+c5awIUFnEBk6dFjNGTVn1SYmfAbgokSNBy1abPYR5ENnpP6QgmiSYEVnT1ZUgZixJQCIpKoEeELqIseW1JqpesJihSqRJhdaHFVFZk+IPydWDDp0xRNVzS5WdAhtoUdSVpx6ZAit4cusQqtYuYqWYU2EESMyXZFnVESSJQtCRBvUWZW/zviSbNiscOBmqUbVTXWY5OCDbdvatRuZ2jHIhTNnTqy5czODQT03+5tH87TMFwc29sy0xJNRovEKdHbsdLNjhU+n+vskVTPbhXGTXBg786hRvovjDczccfOgfZ07Z8jypsTq2K9f51hNlcCFAquRC/ou8dl4AOABdA8IADs=)**ข้อปฏิบัติสำคัญเกี่ยวกับการใช้** **AI**<br><br>1. อนุญาตให้ใช้ AI (ChatGPT, Claude, Copilot ฯลฯ) เป็นเครื่องมือช่วย<br><br>2. ต้องใส่ comment // AI-ASSISTED: [อธิบาย] ในทุกจุดที่ใช้ความช่วยเหลือจาก AI|

|                                         |                                  |
| --------------------------------------- | -------------------------------- |
| ชื่อ-นามสกุล: <br><br>ศุภวิชญ์ ชูอนันท์ | รหัสนักศึกษา: <br><br>6611130088 |
## 1.1) ออกแบบแอปของตัวเอง (8 คะแนน )

**ให้นักศึกษาคิดแอปที่ตัวเองอยากใช้จริงในชีวิตประจำวัน โดยต้องมีคุณสมบัติครบตามนี้**

- [x] มีอย่างน้อย 3 หน้าจอ (ใช้ Navigator)

- [x] มีรายการที่ลบได้ด้วยการปัด (Dismissible)

- [x] มีฟอร์มกรอกข้อมูลพร้อม validation อย่างน้อย 3 fields

- [x] มีการจัดลำดับรายการได้ (ReorderableListView) หรือ มี Key ที่ใช้อย่างมีความหมาย

1. **Onboarding Screen:** หน้าบอกราละเอียดการใช้งาน
2. **Home Screen:** list ของงาน
3. **Add/Edit Task Screen:** หน้ารับ input
4. **Settings Screen:** เปิด dark mode

**อธิบายแนวคิดแอป**
เป็นแอป task management เพื่อช่วยจัดตารางเวลาสำหรับนักศึกษา

---

## 1.2) วาด Wireframe (6 คะแนน)

mockup
// AI-Assisted
### Home Screen

```
+-----------------------------------+
|  [Menu]     Student Planner   {*} |  <-- {*} is Settings Icon
+-----------------------------------+
| [ O  Search Tasks...            ] |  <-- Search Bar
+-----------------------------------+
|  ::  [ 1. Flutter Exam      ]     |  <-- '::' represents Drag Handle
|      Priority: High | Due: Tmrw   |
+-----------------------------------+
|  ::  [ 2. Math Homework     ]     |
|      Priority: Med  | Due: Fri    |
+-----------------------------------+
|  ::  [ 3. Buy Coffee        ]     |
|      Priority: Low  | Due: Now    |
+-----------------------------------+
|                                   |
|                             ( + ) |  <-- Add Button
+-----------------------------------+
```

### Add Task Form Screen

```
+-----------------------------------+
|  [<]       New Task               |
+-----------------------------------+
|                                   |
|  Task Title * |
|  [_____________________________]  |
|                                   |
|  Priority                         |
|  [ Medium                   (v)]  |
|                                   |
|  Due Date                         |
|  [ Calendar Icon ]  Oct 25, 2025  |
|                                   |
|                                   |
|      [    SAVE TASK    ]          |
+-----------------------------------+
```

### Settings Screen

```
+-----------------------------------+
|  [<]       Settings               |
+-----------------------------------+
|                                   |
|  Dark Mode              [ O  ]    |  <-- Switch Widget
|                                   |
+-----------------------------------+
```

### Navigation
```
[ Home Screen ]
      |
      +----(Click FAB +)--------> [ Add Task Form ]
      |                                 |
      |                           (Click Save)
      |                                 |
      |<---(Return with Data)-----------+
      |
      |
      +----(Click Gear Icon)----> [ Settings Screen ]
                                        |
      |<---(Back Button)----------------+
```


