using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Reflection;

namespace Scamm_Builder
{
    class SCAMMNode : TreeNode
    {
        public SCAMMNodeTab Tab { get { return tab; } }
        protected SCAMMNodeTab tab;

        protected static int SequentialIndex { get {return sequential++;} }
        private static int sequential = 0;

        public static void ResetClass()
        {
            sequential = 0;
        }

        public static string GetTypeName()
        {
            return null;
        }

        public static Type[] GetChildClasses()
        {
            return null;
        }

        public virtual void SaveNodes(BinaryWriter bw)
        {
            bw.Write(Nodes.Count);
            foreach (TreeNode n in Nodes)
            {
                bw.Write(n.GetType().Name);
                ((SCAMMNode)n).Save(bw);
            }
        }

        public void Save(BinaryWriter bw)
        {
            Tab.SaveGrid(bw);
            SaveNodes(bw);
        }

        public SCAMMNode CreateNode (string className)
        {
            var assembly = Assembly.GetExecutingAssembly();
            var type = assembly.GetTypes().First(t => t.Name == className);
            SCAMMNode newNode = (SCAMMNode)Activator.CreateInstance(type, new object[] { Tab.TabControl });
            Nodes.Add(newNode);
            return newNode;
        }

        public virtual void LoadNodes(BinaryReader br)
        {
            int nodeCount = br.ReadInt32();
            for (int i = 0; i < nodeCount; i++)
            {
                try
                {
                    var childNode = CreateNode(br.ReadString());
                    childNode.Load(br);
                }
                catch (System.IO.EndOfStreamException excpt)
                {
                    MessageBox.Show("The following Exception ocurred loading node " + i.ToString() + "/" + nodeCount.ToString() + " of a " + this.GetType() + ": " + excpt.Message);
                    throw new SCAMMException();
                }
            }
        }

        public void Load(BinaryReader br)
        {
            Tab.LoadGrid(br);
            Text = Tab.Name;
            LoadNodes(br);
        }
    }
}
