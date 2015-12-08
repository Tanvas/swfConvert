using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SWFToHTML5
{
    /// <summary>
    /// интерфейс общих настроек
    /// параметров конвертации
    /// </summary>
    public interface IConvertSettings
    {
       
        /// <summary>
        /// качество 
        /// "на выходе"
        /// </summary>
        int Quality { get; }
        /// <summary>
        /// ширина выходного
        /// видео в пикселях
        /// </summary>
        int WidthPx { get; }
        /// <summary>
        /// высота выходного видео
        /// в пикселях
        /// </summary>
        int HeightPx { get; }
        /// <summary>
        /// временная директория
        /// </summary>
        string TmpDirectory { get; }
        /// <summary>
        /// удалять ли оригинал (swf)
        /// </summary>
        bool IsOrigDel { get; }

        /// <summary>
        /// обновить параметры
        /// </summary>
        /// <param name="_settings">новые параметры</param>
        void UpdateSettings(IConvertSettings _settings);

    }
}
