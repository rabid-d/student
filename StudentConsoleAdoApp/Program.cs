using System.Data.SqlClient;
using static System.Linq.Enumerable;

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
        Console.WriteLine("List of students in ПІ-21 group:");
        WriteToConsole(reader);
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
        Console.WriteLine("All grades of student Іщук:");
        WriteToConsole(reader);
        reader.Close();
    }
    cnn.Close();
}
catch (Exception ex)
{
    Console.WriteLine(ex.Message);
    Console.WriteLine(ex.StackTrace);
}

void WriteToConsole(SqlDataReader reader)
{
    while (reader.Read())
    {
        foreach (var i in Range(0, reader.FieldCount))
        {
            Console.Write($"{reader.GetValue(i), -15}");
        }
        Console.WriteLine();
    }
    Console.WriteLine();
}
