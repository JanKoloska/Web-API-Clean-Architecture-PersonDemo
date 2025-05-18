namespace JanKoloska.PersonDemo.Core.Utilities;

public static class Guard
{
    public static void AgainstNull<T>(T? value, string? parameterName)
    {
        if (value is null)
        {
            throw new ArgumentNullException(parameterName, $"Parameter '{parameterName}' must not be null.");
        }
    }
}