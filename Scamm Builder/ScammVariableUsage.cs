using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Collections.ObjectModel;

namespace Scamm_Builder
{
    public static class ScammVariableUsage
    {
        public const int svu_readonly = 0;
        public const int svu_runtime = 1;
        public const int svu_editable = 2;
        public const int svu_automatic = 3;

        public static readonly ReadOnlyCollection<string> usageNames = new ReadOnlyCollection<string>(
            new string[] {
                    "Readonly",
                    "Runtime",
                    "Editable",
                    "Automatic",
            }
        );
    }
}
