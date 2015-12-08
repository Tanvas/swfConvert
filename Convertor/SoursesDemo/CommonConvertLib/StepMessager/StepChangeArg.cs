using System;


namespace CommonConvertLib.StepMessager
{
    /// <summary>
    /// аргумент смены этапа конвертирования
    /// </summary>
    /// <param name="_stepDiscription">описание действия этапа</param>
    public class StepChangeArg:EventArgs
    {
        /// <summary>
        /// описание действия этапа
        /// </summary>
        public string StepDiscription { get; private set; }

        /// <summary>
        /// аргумент смены этапа конвертирования
        /// </summary>
        /// <param name="_stepDiscription">описание действия этапа</param>
        public StepChangeArg(string _stepDiscription)
        {
            StepDiscription = _stepDiscription;
        }
    }
}
