using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWFToHTML5
{ 
    
    public static class PathExtensions
    {
        static char slash = System.IO.Path.DirectorySeparatorChar;
        /// <summary>
        /// возвращает строку как 
        /// путь (добавляет слэш)
        /// </summary>
        /// <param name="self">строка</param>
        /// <returns>строка как путь или пустая строка</returns>
        public static string AsPath(this string self)
        {
            try
            {

                char end = self[self.Length - 1];               
                if (end != slash)
                    self += slash;

                
                return self;
            }
            catch
            {
                return "";
            }

        }
    }
}
