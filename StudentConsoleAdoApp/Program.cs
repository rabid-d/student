using StudentConsoleAdoApp;
using System.Data.SqlClient;
using System.Data;

var connetionString = "Server=localhost;Database=UniversityDatabase;Integrated Security=SSPI;";
var cnn = new SqlConnection(connetionString);
try
{
    cnn.Open();
    var getStudentsByGroupSql = @"SELECT [StudentCard], [FirstName], [LastName], [Middlename], [GroupName]
                                  FROM [dbo].[Student] [St]
                                  JOIN [dbo].[Group] [Gr] ON [St].[CurrentGroupId] = [Gr].[GroupId] AND [Gr].[GroupName] = N'ПІ-21'
                                  ORDER BY [FirstName], [LastName]";
    using (var cmd = new SqlCommand(getStudentsByGroupSql, cnn))
    {
        SqlDataReader reader = cmd.ExecuteReader();

        var allStudents = new List<StudentCard>();
        while (reader.Read())
        {
            allStudents.Add(ParseStudentCard(reader));
        }

        Console.WriteLine("List of students in ПІ-21 group:");
        foreach (var student in allStudents)
        {
            WriteStudentToConsole(student);
            Console.WriteLine();
        }
        reader.Close();
    }

    var getStudentAndGradesSql = @"SELECT [StudentCard], [FirstName], [LastName], [Middlename], [GroupName], [Grade], [Grd].[CreatedDateTime]
                                   FROM [dbo].[Student] [St]
                                   JOIN [dbo].[Grade] [Grd] ON [Grd].[StudentId] = [St].[StudentId] AND [St].FirstName = N'Іщук'
                                   JOIN [dbo].[Group] [Grp] ON [St].[CurrentGroupId] = [Grp].[GroupId]
                                   ORDER BY [Grd].[CreatedDateTime]";
    using (var cmd = new SqlCommand(getStudentAndGradesSql, cnn))
    {
        SqlDataReader reader = cmd.ExecuteReader();
        var studentsAndGrades = new List<Tuple<StudentCard, Tuple<int, DateTime>>>();
        while (reader.Read())
        {
            var student = ParseStudentCard(reader);
            var grade = reader.GetInt32(5);
            var dateOfGrade = reader.GetDateTime(6);
            studentsAndGrades.Add(Tuple.Create(student, Tuple.Create(grade, dateOfGrade)));
        }

        Console.WriteLine("All grades of student Іщук:");
        foreach (var studentAndGrade in studentsAndGrades)
        {
            WriteStudentToConsole(studentAndGrade.Item1);
            Console.Write($"{studentAndGrade.Item2.Item1, -15}");
            Console.Write($"{studentAndGrade.Item2.Item2, -15}");
            Console.WriteLine();
        }
        reader.Close();
    }

    var procedureName = "SpTransferStipend";
    using (var cmd = new SqlCommand(procedureName, cnn))
    {
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Year", 2022);
        cmd.Parameters.AddWithValue("@Month", 1);
        cmd.ExecuteNonQuery();
    }
    cnn.Close();
}
catch (Exception ex)
{
    Console.WriteLine(ex.Message);
    Console.WriteLine(ex.StackTrace);
}

void WriteStudentToConsole(StudentCard student)
{
    Console.Write($"{student.CardNumber, -15}");
    Console.Write($"{student.FirstName, -15}");
    Console.Write($"{student.LastName, -15}");
    Console.Write($"{student.MiddleName, -15}");
    Console.Write($"{student.GroupName, -15}");
}

StudentCard ParseStudentCard(SqlDataReader reader)
{
    return new StudentCard()
    {
        CardNumber = reader.GetString(0),
        FirstName = reader.GetString(1),
        LastName = reader.GetString(2),
        MiddleName = reader.GetString(3),
        GroupName = reader.GetString(4),
    };
}
