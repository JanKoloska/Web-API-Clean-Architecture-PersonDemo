using JanKoloska.PersonDemo.Core.Utilities;

namespace JanKoloska.PersonDemo.Core.UnitTests.Utilities;

public class GuardTests
{
    [Fact]
    public void AgainstNull_WithNonNullStringValue_ShouldNotThrow()
    {
        // Arrange
        var value = "Test";

        // Act
        Guard.AgainstNull(value, nameof(value));
    }

    [Fact]
    public void AgainstNull_WithNonNullIntegerValue_ShouldNotThrow()
    {
        // Arrange
        int value = 42;

        // Act
        Guard.AgainstNull(value, nameof(value));
    }

    [Fact]
    public void AgainstNull_WithNullValue_ShouldThrowArgumentNullException()
    {
        // Arrange
        string? value = null;

        // Act
        var exception = Assert.Throws<ArgumentNullException>(() => Guard.AgainstNull(value, nameof(value)));

        // Assert
        Assert.NotNull(exception);
        Assert.Equal(nameof(value), exception.ParamName);
        Assert.Equal("Parameter 'value' must not be null. (Parameter 'value')", exception.Message);
    }
}