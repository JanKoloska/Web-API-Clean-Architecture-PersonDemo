namespace JanKoloska.PersonDemo.Core.Entities;

public class Person
{
    public long Id { get; set; }

    public string FirstName { get; set; }

    public string? MiddleName { get; set; }

    public string? LastName { get; set; }

    public DateOnly DateOfBirth { get; set; }

    public Person(string firstName, DateOnly dateOfBirth)
    {
        FirstName = firstName;
        DateOfBirth = dateOfBirth;
    }
}