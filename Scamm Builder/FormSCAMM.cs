using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;
using System.Reflection;

using Antlr4.StringTemplate;


namespace Scamm_Builder
{
    public partial class FormSCAMM : Form
    {
        bool isDoubleClick = false;
        const byte token_XTRA = 0b00000000;   // 00000000: Extra commands
        const byte token_ARAY = 0b00000000;   // 00XXXXXX CCCCCCCC: Fills (XXXXXX + 1) pixels with color CCCCCCCC
        const byte token_LINE = 0b01000000;   // 01XXXXXX YYYYYYYY CCCCCCCC: Fill XXXXXX lines + (YYYYYYYY + 1) pixels with color CCCCCCCC
        const byte token_UBMP = 0b10000000;   // 10XXXXXX: Follows uncompressed bitmap of size XXXXXX + 1
        const byte token_CBMP = 0b11000000;   // 11XXXXXX: Follows compressed bitmap of size XXXXXX + 1

        const byte token_XTRA_EOF = 0b00000000;   // 00000000: EOF

        const int maxBookSize = 60000;
        const int screenWidth = 256;
        const int screenHeight = 168;
        const int screenSize = screenWidth * screenHeight;

        string fileName = "I:\\Emulator\\MSX\\DEV\\Projects\\SCAMM\\SCAMM\\Debug\\bin\\Book1.RAW";
        byte[] bookFile = new byte[maxBookSize];
        int bookFileIndex = 0;

        SCAMMGame game;
        private string _saveFile = null;
        public string SaveFile { get { return _saveFile; } set { saveToolStripMenuItem.Enabled = (_saveFile = value) != null;  } }

        public FormSCAMM()
        {
            InitializeComponent();
        }

        private void resetGame()
        {
            tabControl.TabPages.Clear();
            treeViewGame.Nodes.Clear();
            game = new SCAMMGame(tabControl);
            treeViewGame.Nodes.Add(game);
            game.Tab.ShowTab();
            SaveFile = null;
        }

        private void FormSCAMM_Load(object sender, EventArgs e)
        {
            resetGame();
        }

        private void saveUBMP(Bitmap b, int p, int pixelCount, byte[] bookFile, ref int bookFileIndex)
        {
            while (pixelCount > 0)
            {
                int n = Math.Min(pixelCount, 0x40);
                n = Math.Min(n, 256 - (p % 256));
                bookFile[bookFileIndex++] = (byte)(token_UBMP | (n - 1));
                for (int i = 0; i < n; i++)
                {
                    Color c = b.GetPixel(p % screenWidth, p / screenWidth);
                    bookFile[bookFileIndex++] = (byte)((c.G & 0b11100000) | ((c.R & 0b11100000) >> 3) | (c.B >> 6));
                    p++;
                }
                pixelCount -= n;
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            int p = 0;
            int bmpP = 0;
            byte previousToken = 0;
            bookFileIndex = 0;
            Bitmap b = new Bitmap(pictureBox1.ClientSize.Width, pictureBox1.Height);
            pictureBox1.DrawToBitmap(b, pictureBox1.ClientRectangle);

            do
            {
                Color c = b.GetPixel(p % screenWidth, p / screenWidth);
                int newP = p + 1;
                while ((newP < screenSize) && (b.GetPixel(newP % screenWidth, newP / screenWidth).ToArgb().Equals(c.ToArgb())))
                {
                    newP++;
                }
                int pixelCount = newP - p;

                if (pixelCount <= 3)
                {
                    previousToken = token_UBMP;
                    p += pixelCount;
                    if (p >= screenSize)
                    {
                        saveUBMP(b, bmpP, p - bmpP, bookFile, ref bookFileIndex);
                    }
                }
                else
                {
                    if ((previousToken & token_UBMP) > 0)
                    {
                        saveUBMP(b, bmpP, p - bmpP, bookFile, ref bookFileIndex);
                    }

                    byte color = (byte)((c.G & 0b11100000) | ((c.R & 0b11100000) >> 3) | (c.B >> 6));
                    if ((pixelCount <= 64) && ((p / screenWidth) == ((p+pixelCount) / screenWidth)))
                    {
                        bookFile[bookFileIndex++] = (byte)(token_ARAY | pixelCount - 1);
                        bookFile[bookFileIndex++] = color;
                        bmpP = p += pixelCount;
                    }
                    else
                    {
                        int space = screenWidth - (p & 0xff);
                        while (pixelCount > (0x3f00 + space))
                        {
                            bookFile[bookFileIndex++] = (byte)(token_LINE | 0x3f);
                            bookFile[bookFileIndex++] = (byte)(screenWidth - 1);
                            bookFile[bookFileIndex++] = color;
                            p += (0x3f00 + space);
                            pixelCount -= (0x3f00 + space);
                            space = 256;
                        }

                        if (pixelCount <= space)
                        {
                            // acts like a token_ARAY, for 64 < pixelcount <= space
                            bookFile[bookFileIndex++] = (byte)(token_LINE);
                            bookFile[bookFileIndex++] = (byte)(pixelCount - 1);
                            bookFile[bookFileIndex++] = color;
                            p += pixelCount;
                        }
                        else
                        {
                            pixelCount -= space;
                            int pixels = (pixelCount % screenWidth);
                            pixels = (pixels == 0) ? screenWidth : pixels;
                            pixelCount -= pixels;
                            int lines = Math.Min((pixelCount / 256), 62);
                            bookFile[bookFileIndex++] = (byte)(token_LINE | lines + 1);
                            bookFile[bookFileIndex++] = (byte) (pixels - 1);
                            bookFile[bookFileIndex++] = color;
                            p += space + (lines * 0x100) + pixels;
                        }
                        bmpP = p;
                    }
                    previousToken = 0;
                    pixelCount = 0;
                }
            } while (p < screenSize);
            bookFile[bookFileIndex++] = token_XTRA; bookFile[bookFileIndex++] = token_XTRA_EOF; // EOF

            File.WriteAllBytes(fileName, bookFile.Take(bookFileIndex).ToArray()); // Requires System.IO
        }

        private void button2_Click(object sender, EventArgs e)
        {
            bookFileIndex = 0;
            Bitmap b = new Bitmap(pictureBox1.ClientSize.Width, pictureBox1.Height);
            pictureBox1.DrawToBitmap(b, pictureBox1.ClientRectangle);

            for (int y = 0; y < 168; y++)
            {
                for (int x = 0; x < 256; x++)
                {
                    Color c = b.GetPixel(x, y);
                    byte color = (byte)((c.G & 0b11100000) | ((c.R & 0b11100000) >> 3) | (c.B >> 6));
                    bookFile[bookFileIndex++] = color;
                }
            }

            File.WriteAllBytes(fileName, bookFile.Take(bookFileIndex).ToArray()); // Requires System.IO
        }

        private void button3_Click(object sender, EventArgs e)
        {
            int p = 0;
            byte token = 0;
            bookFileIndex = 0;
            Bitmap b = new Bitmap(screenWidth, screenHeight);
            try
            {
                do
                {
                    token = bookFile[bookFileIndex++];
                    if (token == token_XTRA)
                    {
                        token = bookFile[bookFileIndex++];
                    }
                    int cmd = token & 0b11000000;
                    if (cmd == token_UBMP)
                    {
                        int size = (token & 0b00111111);
                        while (size-- >= 0)
                        {
                            int color = bookFile[bookFileIndex++];
                            Color c = Color.FromArgb((color << 3) & 0b11100000, (color & 0b11100000), (color << 6) & 0b11000000);
                            b.SetPixel(p % screenWidth, p / screenWidth, c);
                            p++;
                        }
                    }
                    else if (cmd == token_ARAY)
                    {
                        int pixels = token & 0b00111111;
                        int color = bookFile[bookFileIndex++];
                        Color c = Color.FromArgb((color << 3) & 0b11100000, (color & 0b11100000), (color << 6) & 0b11000000);
                        while (pixels-- >= 0)
                        {
                            b.SetPixel(p % screenWidth, p / screenWidth, c);
                            p++;
                        }
                    }
                    else if (cmd == token_LINE)
                    {
                        int lines = token & 0b00111111;
                        int pixels = bookFile[bookFileIndex++] + 1;
                        int color = bookFile[bookFileIndex++];
                        Color c = Color.FromArgb((color << 3) & 0b11100000, (color & 0b11100000), (color << 6) & 0b11000000);
                        if (lines > 0)
                        {
                            do
                            {
                                b.SetPixel(p % screenWidth, p / screenWidth, c);
                                p++;
                            } while ((p % screenWidth) > 0);

                            for (int y = 1; y < lines; y++)
                            {
                                for (int x = 0; x < screenWidth; x++)
                                {
                                    b.SetPixel(p % screenWidth, p / screenWidth, c);
                                    p++;
                                }
                            }
                        }
                        while (pixels-- > 0)
                        {
                            b.SetPixel(p % screenWidth, p / screenWidth, c);
                            p++;
                        }
                    }
                } while (token != token_XTRA_EOF);
            }
            catch (Exception excpt)
            {
                MessageBox.Show("The following Exception ocurred: " + excpt.Message);
            }
            finally
            {
                pictureBox2.CreateGraphics().DrawImage(b, new Point());
            }
        }

        private void pictureBox1_MouseMove(object sender, MouseEventArgs e)
        {
            Bitmap b = new Bitmap(pictureBox1.ClientSize.Width, pictureBox1.Height);
            pictureBox1.DrawToBitmap(b, pictureBox1.ClientRectangle);
            Color c = b.GetPixel(e.Location.X, e.Location.Y);
            Int32 color = (c.G << 16) | ((c.R << 8) | c.B);
            byte color2 = (byte)((c.G & 0b11100000) | ((c.R & 0b11100000) >> 3) | (c.B >> 6));
            label1.Text = e.Location.X + ":" + e.Location.Y;
            label2.Text = color2.ToString("X");
            label3.Text = color2.ToString("X");
        }

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            System.Windows.Forms.Application.Exit();
        }

        private void gameStructureASMFileToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FormSourceView.ShowRogue("GameStructure.s", SCAMMUtil.getTextResource("GameStructure.s"));
        }

        private void gameFieldsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FormSourceView.ShowRogue("GameFieldsSize.s", SCAMMUtil.getTextResource("GameFieldsSize.s"));
        }

        private void gameToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (SaveFile == null)
            {
                saveAsToolsStripMenuItem_Click(sender, e);
            }

            if (SaveFile != null)
            {
                string srcDir = Path.GetDirectoryName(SaveFile) + "\\src";
                Directory.CreateDirectory(srcDir);

                Template a = new Template(SCAMMUtil.getTextResource("GameTemplate.txt"));
                a.Add("gameVars", game.Tab.nodeVars.Values);
                string gameSrc = a.Render();

                BinaryWriter bw = new BinaryWriter(File.Open(srcDir + "\\game.s", FileMode.Create));
                bw.Write(gameSrc);
                bw.Close();

                FormSourceView.ShowRogue("Game script", a.Render());
            }
        }

        private void menuStrip1_ItemClicked(object sender, ToolStripItemClickedEventArgs e)
        {

        }

        private void treeViewGame_NodeMouseClick(object sender, TreeNodeMouseClickEventArgs e)
        {
            SCAMMNode n = (SCAMMNode) e.Node;
            treeViewGame.SelectedNode = n;

            if (e.Button == MouseButtons.Right)
            {
                addItem.DropDownItems.Clear();
                Type t = n.GetType();
                Type[] classes = (Type[])t.GetMethod("GetChildClasses").Invoke(null, null);

                foreach (Type c in classes)
                {
                    string name = (string)c.GetMethod("GetTypeName").Invoke(null, null);
                    string className = c.Name;

                    ToolStripMenuItem i = new ToolStripMenuItem(name, null, addItem_Click, className);
                    addItem.DropDownItems.Add(i);
                }

                bool addVisible = addItem.DropDownItems.Count > 0;
                bool deleteVisible = !(n is SCAMMGame);

                addItem.Visible = addVisible;
                deleteItem.Visible = deleteVisible;
                nodeMenuSeparator.Visible = addVisible & deleteVisible;

                nodeMenu.Show(Cursor.Position);
            }
        }

        private void addItem_Click(object sender, EventArgs e)
        {
            SCAMMNode parentNode = (SCAMMNode)treeViewGame.SelectedNode;
            SCAMMNode childNode = parentNode.CreateNode(((ToolStripMenuItem)sender).Name);
            parentNode.Expand();
            childNode.Tab.ShowTab();
        }

        private void deleteItem_Click(object sender, EventArgs e)
        {
            SCAMMNode n = (SCAMMNode) treeViewGame.SelectedNode;
            if (! (n is SCAMMGame))
            {
                n.Remove();
            }
        }

        private void treeViewGame_NodeMouseDoubleClick(object sender, TreeNodeMouseClickEventArgs e)
        {
            SCAMMNode n = (SCAMMNode)treeViewGame.SelectedNode;
            n.Tab.ShowTab();
        }

        private void tabControl_DrawItem(object sender, DrawItemEventArgs e)
        {
            //This code will render a "x" mark at the end of the Tab caption. 
            e.Graphics.DrawString("x", e.Font, Brushes.Black, e.Bounds.Right - 15, e.Bounds.Top + 4);
            e.Graphics.DrawString(this.tabControl.TabPages[e.Index].Text, e.Font, Brushes.Black, e.Bounds.Left + 3, e.Bounds.Top + 4);
            e.DrawFocusRectangle();
        }

        private void tabControl_MouseDown(object sender, MouseEventArgs e)
        {
            for (int i = 0; i < this.tabControl.TabPages.Count; i++)
            {
                Rectangle r = tabControl.GetTabRect(i);
                //Getting the position of the "x" mark.
                Rectangle closeButton = new Rectangle(r.Right - 15, r.Top + 2, 11, 16);
                if (closeButton.Contains(e.Location))
                {
                    if (MessageBox.Show("Would you like to Close this Tab?", "Confirm", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes)
                    {
                        this.tabControl.TabPages.RemoveAt(i);
                        break;
                    }
                }
            }
        }

        private void treeViewGame_BeforeCollapse(object sender, TreeViewCancelEventArgs e)
        {
            if (isDoubleClick && e.Action == TreeViewAction.Collapse)
                e.Cancel = true;
        }

        private void treeViewGame_BeforeExpand(object sender, TreeViewCancelEventArgs e)
        {
            if (isDoubleClick && e.Action == TreeViewAction.Expand)
                e.Cancel = true;
        }

        private void treeViewGame_MouseDown(object sender, MouseEventArgs e)
        {
            isDoubleClick = e.Clicks > 1;
        }

        private void treeViewGame_ItemDrag(object sender, ItemDragEventArgs e)
        {
            DoDragDrop(e.Item, DragDropEffects.Move);
        }

        private void treeViewGame_DragEnter(object sender, DragEventArgs e)
        {
            e.Effect = DragDropEffects.Move;
        }

        private void treeViewGame_DragDrop(object sender, DragEventArgs e)
        {
            // Retrieve the client coordinates of the drop location.
            Point targetPoint = treeViewGame.PointToClient(new Point(e.X, e.Y));

            // Retrieve the node at the drop location.
            TreeNode targetNode = treeViewGame.GetNodeAt(targetPoint);

            // Retrieve the node that was dragged.
            var subClasses =
                from assembly in AppDomain.CurrentDomain.GetAssemblies()
                from type in assembly.GetTypes()
                where type.IsSubclassOf(typeof(TreeNode))
                select type;
            TreeNode draggedNode = null;
            foreach (var c in subClasses)
            {
                draggedNode = (TreeNode)e.Data.GetData(c);
                if (draggedNode != null)
                {
                    break;
                }
            }

            // confirm nodes are not null
            if ((draggedNode != null) && (targetNode != null))
            {
                // confirm nodes are not the same
                // and that target is not a subnode of dragged
                TreeNode n = targetNode;
                while ((!n.Equals(draggedNode)) && (n.Parent != null))
                {
                    n = n.Parent;
                }

                if (n.Parent == null)
                {
                    // Remove the node from its current 
                    // location and add it to the node at the drop location.
                    draggedNode.Remove();
                    targetNode.Nodes.Add(draggedNode);

                    // Expand the node at the location 
                    // to show the dropped node.
                    targetNode.Expand();
                }
            }
        }

        private void openToolStripMenuItem_Click(object sender, EventArgs e)
        {
            OpenFileDialog openDialog = new OpenFileDialog();
            openDialog.Filter = "SCAMM Game|*.SCA";
            openDialog.Title = "Save SCAMM Game";
            openDialog.ShowDialog();

            // If the file name is not an empty string open it for saving.  
            if (openDialog.FileName != "")
            {
                // Saves the Image via a FileStream created by the OpenFile method.  
                BinaryReader br = new BinaryReader(File.Open(openDialog.FileName, FileMode.Open));
                resetGame();
                try
                {
                    game.Load(br);
                    SaveFile = openDialog.FileName;
                }
                catch (SCAMMException)
                {
                    MessageBox.Show("Game not loaded.");
                    resetGame();
                }
                finally
                {
                    br.Close();
                }
            }
        }

        private void newToolStripMenuItem_Click(object sender, EventArgs e)
        {
            resetGame();
        }

        private void saveAsToolsStripMenuItem_Click(object sender, EventArgs e)
        {
            SaveFileDialog saveDialog = new SaveFileDialog();
            saveDialog.Filter = "SCAMM Game|*.SCA";
            saveDialog.Title = "Save " + game.Text;
            saveDialog.ShowDialog();

            // If the file name is not an empty string open it for saving.  
            if (saveDialog.FileName != "")
            {
                // Saves the Image via a FileStream created by the OpenFile method.  
                SaveFile = saveDialog.FileName;
                saveToolStripMenuItem_Click(sender, e);
            }
        }

        private void saveToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // If the file name is not an empty string open it for saving.  
            if (SaveFile != null)
            {
                // Saves the Image via a FileStream created by the OpenFile method.  
                BinaryWriter bw = new BinaryWriter(File.Open(SaveFile, FileMode.Create));
                game.Save(bw);
                bw.Close();
            }
        }
    }
}
