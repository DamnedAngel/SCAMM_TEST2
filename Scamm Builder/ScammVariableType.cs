using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Collections.ObjectModel;

namespace Scamm_Builder
{
    public static class ScammVariableType
    {
        public const int svt_marker             = 0;
        public const int svt_int8               = 1;
        public const int svt_int16              = 2;
        public const int svt_int32              = 3;
        public const int svt_str                = 4;
        public const int svt_pointer            = 5;
        public const int svt_pStr               = 6;
        public const int svt_pBuffer            = 7;
        public const int svt_pEventHandler      = 8;
        public const int svt_pContext           = 9;
        public const int svt_pObject            = 10;
        public const int svt_pObjectList        = 11;

        public static readonly ReadOnlyCollection<string> typeNames = new ReadOnlyCollection<string>(
            new string[] {
                "marker",
                "Int8",
                "Int16",
                "Int32",
                "Str",
                "Pointer",
                "PStr",
                "PBuffer",
                "PEventHandler",
                "PContext",
                "PObject",
                "PObjectList",
            }
        );
    }
}
