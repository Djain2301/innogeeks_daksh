-- question statment:: Create a Simple Table Structure with MongoDB for an EduTech where Students enroll for the courses
--which are defined by admin, sessions, assignments and use simple InsertMany to register the records.

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