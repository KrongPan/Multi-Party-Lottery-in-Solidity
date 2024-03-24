# ChooseNum
    เป็นฟังก์ชั่นเริ่มเกมโดยจะมีการเก็บเวลาที่เริ่มเกมเมื่อมีผู้เล่นคนเเรกเข้ามา เเละมีการเช็คเวลา state ค่าเล่น เเละจำนวนคน(ไม่เกิน N) มีการ commit ค่าตัวเลขที่ hash เเล้วออกไป (ถือเป็น stage1)
# reveal
    มีการเช็คเวลาว่าเข้าสู่ stage2 เเล้วหรือไม่เมื่อเข้าเเล้วจึงให้ทำการ reveal ได้
# findWinner
    มีการเช็คเวลาว่าเข้าสู่ stage3 เเล้วหรือไม่เเละ function นี้ให้ผู้ที่ deploy ใช้ได้เท่านั้น มีการกำหนดตัวเเปรเพิ่มเพื่อเก็บลำดับที่ของผู้ชนะ(winnerNum) เเละ(newN)เพื่อทราบจำนวนผู้ที่จะนำมาใช้ในการคิดลำดับของผู้ชนะ จะมีการ loop เพื่อเช็คเงื่อนใขที่ละคน 
        -reveal ไปเเล้วหรือยัง
        -ตัวเลขที่เลือกมาอยู่ในช่วง 0-999 หรือไม่
    จากนั้นลำดับของผู้เล่นจะถูกจัดใหม่ตามผู้เล่นที่เหลืออยู่ ในการณีที่มีผู้ชนะ ผู้ชนะจะได้รับเงิน 98% เเละอีก 2% ให้ผู้ deploy contract ในกรณีที่ไม่มีผู้เล่นผ่านเงื่อนใขเลยผู้ deploy contract จะได้เงินที่งหมดไป
# withdraw 
    สามารถทำได้ก็ต่อเมื่อผู้ deploy contract ไม่ยอมทำ findWinner ภายในเวลาที่กำหนดโดยผู้เล่นจะสามารถเอาคืนได้คนละ 0.001 ether
# restart
    สามารถทำได้ก็ต่อเมื่อ Balance เป็น 0 เท่านั้นเท่ากับว่าถ้าเข้าสู่ stage4 เเล้วมีผู้เล่นไม่ยอมเอาเงินออกก็จะไม่สามารถ restart game ได้
#### deploy
    0xd3B8E9960AB1A46363e583643B3672342F00aA25