using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Scamm_Builder
{
    class SCAMMObject : SCAMMNode
    {
        public new static string GetTypeName()
        {
            return "Object";
        }

        public SCAMMObject()
        {
            Text = "Object " + SequentialIndex;
        }

        public new static Type[] GetChildClasses()
        {
            return new Type[] { };
        }
    }
}
