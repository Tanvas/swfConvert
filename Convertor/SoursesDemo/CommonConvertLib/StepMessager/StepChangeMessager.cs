using System;


namespace CommonConvertLib.StepMessager
{
    /// <summary>
    /// класс-помощник передачии
    /// события о смене
    /// этапа конвертации
    /// </summary>
    public class StepChangeMessager : IStepMessager
    {
        /// <summary>
        /// событие смены этапа конвертации
        /// </summary>
        public event EventHandler<StepChangeArg> StepChange;
     
        /// <summary>
        /// "послать" сообщение о смене этапа конвертации
        /// </summary>
        /// <param name="_mes">описание этапа конвертации</param>
        protected void SendMessage(string _mes)
        {
            if (StepChange != null)
                StepChange(this, new StepChangeArg(_mes));
        }
    }
}
