using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWFToHTML5.Helpers
{
    /// <summary>
    /// класс, выполняющий операции
    /// </summary>
    class OperateExecuter
    {
        /// <summary>
        /// максимальное количество попыток
        /// </summary>
        protected int maxTrying=1;
        /// <summary>
        /// делегат оперции
        /// </summary>
        /// <returns>успешность выполнения</returns>
        protected delegate bool Operation();
        /// <summary>
        /// делегат оперции со строковым
        /// пкраметром
        /// </summary>
        /// <returns>успешность выполнения</returns>
        protected delegate bool OperationStrArg(string _arg);

        /// <summary>
        /// выполнить операцию 
        /// с перебором всех попыток
        /// </summary>
        /// <param name="_op">операция</param>
        /// <param name="description">описание операции</param>
        protected void DoOperation(Operation _op, string description)
        {
            if (_op == null)
                throw new ArgumentNullException("Невозможно выполнить несуществующую операцию");

            int n = 0;
            while (!_op() && n < maxTrying)
                n++;
            if (n >= maxTrying)
                throw new Exception("Истекли попытки выполнения операции: " + description);
        }
        /// <summary>
        /// выполнить операцию 
        /// с перебором всех попыток
        /// </summary>
        /// <param name="_op">операция</param>
        /// <param name="_arg">аргумент</param>
        /// <param name="description">описание операции</param>
        protected void DoOperation(OperationStrArg _op,string _arg, string description)
        {
            if (_op == null)
                throw new ArgumentNullException("Невозможно выполнить несуществующую операцию");

            int n = 0;
            while (!_op(_arg) && n < maxTrying)
                n++;
            if (n >= maxTrying)
                throw new Exception("Истекли попытки выполнения операции: " + description);
        }
    }
}
