using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Scamm_Builder
{
    class SCAMMContext : SCAMMNode
    {
        public new static string GetTypeName()
        {
            return "Context";
        }

        public new static Type[] GetChildClasses()
        {
            return new Type[] { typeof(SCAMMContext), typeof(SCAMMObject), typeof(SCAMMPicture) };
        }

        public SCAMMContext(TabControl tabControl)
        {
            Text = "Context " + SequentialIndex;
            tab = new SCAMMContextTab(tabControl, this, Text);
            tab.ResetGrid(Text);
        }
    }
}
