use edtech

db.edtech.insertMany(
  [
    {
      studentName : "Daksh Bindal",
      coursesEnrolled : [
        {
          courseName: "Git", Sessions: 10, assignments: 5
        },
        {
          courseName: "Linux", Sessions: 15, assignments: 10
        },
        {
          courseName: "Database", Sessions: 13, assignments: 7
        }
      ]
    }
  ]
)