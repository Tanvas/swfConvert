using System;


namespace CommonConvertLib.StepMessager
{
    /// <summary>
    /// класс-помощник передачии
    /// события о смене
    /// этапа конвертации
    /// </summary>
    public interface IStepMessager
    {
        /// <summary>
        /// событие смены этапа конвертации
        /// </summary>
        event EventHandler<StepChangeArg> StepChange;
     
    }
}
