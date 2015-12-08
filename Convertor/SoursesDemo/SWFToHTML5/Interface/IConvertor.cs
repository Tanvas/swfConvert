using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWFToHTML5
{
    /// <summary>
    /// интерфейс конвертора
    /// </summary>
    public interface IConvertor
    {
        
        /// <summary>
        /// загрузить swf file
        /// </summary>
        /// <param name="pathToSwf">путь до swf файла</param>
        void SetInputSWF(string pathToSwf);
        /// <summary>
        /// конвертировать
        /// </summary>        
        /// <param name="outPath">выходная директория</param>
        /// <returns></returns>
        void Convert(string outPath);
    }
}
