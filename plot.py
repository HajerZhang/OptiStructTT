import matplotlib.pyplot as plt
import numpy as np

# 从文件读取数据
while True:
    user_input = input("请输入 1 或 2 来选择数据文件: \n1. density\n2. allowablestress\n")

    if user_input == '1':
        data_file1 = ".\data\density\GraphicMethod\data.txt" 
        data_file2 = ".\data\density\FullStressMethod\data.txt"
        data_file3 = ".\data\density\ZigzagMethod\data.txt"
        break
    elif user_input == '2':
        data_file1 = ".\data\Stress\GraphicMethod\data.txt" 
        data_file2 = ".\data\Stress\FullStressMethod\data.txt"
        data_file3 = ".\data\Stress\ZigzagMethod\data.txt"
        break
    else:
        print("请输入有效的选项 (1, 2)")


with open(data_file1, 'r') as file:
    lines1 = file.readlines()
with open(data_file2, 'r') as file:
    lines2 = file.readlines()
with open(data_file3, 'r') as file:
    lines3 = file.readlines()
    
# 读取数据并拟合曲线
data1 = np.genfromtxt(data_file1, skip_header=1)
x_data1, y_data1 = data1[:, 0], data1[:, 1]
data2 = np.genfromtxt(data_file2, skip_header=1)
x_data2, y_data2 = data2[:, 0], data2[:, 1]
data3 = np.genfromtxt(data_file3, skip_header=1)
x_data3, y_data3 = data3[:, 0], data3[:, 1]

# 控制散点图点的大小
point_size = 10

# 绘制散点图
plt.scatter(x_data1, y_data1, s=point_size, color='blue', marker='o')
plt.scatter(x_data2, y_data2, s=point_size, color='green', marker='o')
plt.scatter(x_data3, y_data3, s=point_size, color='red', marker='o')

# 拟合曲线
coeff1 = np.polyfit(x_data1, y_data1, 6)
y_fit1 = np.polyval(coeff1, x_data1)

coeff2 = np.polyfit(x_data2, y_data2, 6)
y_fit2 = np.polyval(coeff2, x_data2)

coeff3 = np.polyfit(x_data3, y_data3, 6)
y_fit3 = np.polyval(coeff3, x_data3)

plt.plot(x_data1, y_fit1, color='blue', linestyle='--', label='GM')
plt.plot(x_data2, y_fit2, color='green', linestyle='--', label='FSM')
plt.plot(x_data3, y_fit3, color='red', linestyle='--', label='ZM')

# 设置标题和标签

if user_input == '1':
    plt.title('Density-Weight')
    plt.xlabel("density")
elif user_input == '2':
    plt.title('AllowableStress-Weight')
    plt.xlabel("allowablestress")
plt.ylabel("weight")

# 添加图例
plt.legend()

# 图像保存
if user_input == '1':
    output_file = ".\plot\Density-Weight.png"
elif user_input == '2':
    output_file = ".\plot\Stress-Weight.png"
plt.savefig(output_file)

# 显示图形
plt.show()