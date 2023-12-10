using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Scamm_Builder 
{
    class SCAMMContextTab : SCAMMNodeTab
    {
        public SCAMMContextTab(TabControl tabControl, SCAMMNode node, string text) : base(tabControl, node, text)
        {
            ASMTemplateName = "ContextStructure.s";
        }
    }
}
