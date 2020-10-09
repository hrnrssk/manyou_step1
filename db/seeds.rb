# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

label1 = Label.create!(name: "sample1")
label2 = Label.create!(name: "sample2")
label3 = Label.create!(name: "sample3")
label4 = Label.create!(name: "sample4")
label5 = Label.create!(name: "sample5")
label6 = Label.create!(name: "sample6")
label7 = Label.create!(name: "sample7")
label8 = Label.create!(name: "sample8")
label9 = Label.create!(name: "sample9")
label10 = Label.create!(name: "sample10")

@user1 = User.create(user_name: "sasaki", email: "a@g.com", password: "aaaaaa", admin: "true")
task1 = Task.create(name: "sasaki_task1", detail: "detail1", deadline: "2020/08/09", status: "未着手", priority: "低", user: @user1)
task1.labels << label1
task1.labels << label2
task1.save
task2 = Task.create(name: "sasaki_task2", detail: "detail2", deadline: "2020/08/10", status: "着手中", priority: "中", user: @user1)
task2.labels << label7
task2.labels << label8
task2.save
task3 = Task.create(name: "sasaki_task3", detail: "detail3", deadline: "2020/08/11", status: "完了", priority: "高", user: @user1)
task3.labels << label3
task3.labels << label4
task3.labels << label5
task3.save
task4 = Task.create(name: "sasaki_task4", detail: "detail4", deadline: "2020/08/14", status: "完了", priority: "低", user: @user1)
task4.labels << label9
task4.save
task5 = Task.create(name: "sasaki_task5", detail: "detail5", deadline: "2020/08/13", status: "着手中", priority: "中", user: @user1)
task5.labels << label4
task5.labels << label5
task5.save
task6 = Task.create(name: "sasaki_task6", detail: "detail6", deadline: "2020/08/12", status: "未着手", priority: "高", user: @user1)
task6.labels << label1
task6.labels << label2
task6.labels << label5
task6.labels << label8
task6.labels << label10
task6.save


@user2 = User.create(user_name: "hiro", email: "b@g.com", password: "bbbbbb", admin: "true")
task7 = Task.create(name: "hiro_task1", detail: "detail7", deadline: "2020/08/09", status: "未着手", priority: "低", user: @user2)
task7.labels << label1
task7.labels << label2
task7.labels << label3
task7.labels << label9
task7.save
task8 = Task.create(name: "hiro_task2", detail: "detail8", deadline: "2020/08/10", status: "着手中", priority: "中", user: @user2)
task8.labels << label1
task8.labels << label10
task8.save
task9 = Task.create(name: "hiro_task3", detail: "detail9", deadline: "2020/08/11", status: "完了", priority: "高", user: @user2)
task9.labels << label4
task9.labels << label7
task9.save

@user3 = User.create(user_name: "nori", email: "c@g.com", password: "cccccc", admin: "true")
task10 = Task.create(name: "nori_task1", detail: "detail10", deadline: "2020/08/09", status: "未着手", priority: "低", user: @user3)
task10.labels << label4
task10.labels << label5
task10.save
task11 = Task.create(name: "nori_task2", detail: "detail11", deadline: "2020/08/10", status: "着手中", priority: "中", user: @user3)
task11.labels << label1
task11.labels << label2
task11.save
task12 = Task.create(name: "nori_task3", detail: "detail12", deadline: "2020/08/11", status: "完了", priority: "高", user: @user3)
task12.labels << label10
task12.save

10.times do |i|
    User.create!(user_name: "test_user#{i + 1}", email: "test#{i + 1}@g.com", password: "ddddd#{i + 1}", admin: "false")
end


