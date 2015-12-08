using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SWFToHTML5.ResourseHlp
{
    /// <summary>
    /// интерфейс получения ресурсов для
    /// конвертации
    /// </summary>
    public interface IResourse: IEnumerable
    {
        /// <summary>
        /// корректны ли ресурсы
        /// </summary>
        bool IsCorrect { get; }
    }
    
}
