using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Scamm_Builder
{
    class ScammVariable
    {
        private static char[] trimChars = new char[] {(char)9, ' ' };

        public bool IsInt8          { get { return varType == ScammVariableType.svt_int8; } }
        public bool IsInt16         { get { return varType == ScammVariableType.svt_int16; } }
        public bool IsInt32         { get { return varType == ScammVariableType.svt_int32; } }
        public bool IsStr           { get { return varType == ScammVariableType.svt_str; } }
        public bool IsPointer       { get { return varType == ScammVariableType.svt_pointer; } }
        public bool IsPStr          { get { return varType == ScammVariableType.svt_pStr; } }
        public bool IsPBuffer       { get { return varType == ScammVariableType.svt_pBuffer; } }
        public bool IsPEventHandler { get { return varType == ScammVariableType.svt_pEventHandler; } }
        public bool IsPObject       { get { return varType == ScammVariableType.svt_pObject; } }
        public bool IsPObjectList   { get { return varType == ScammVariableType.svt_pObjectList; } }

        public int ValueAsByte      { get { return int.Parse(value) & 0xff; } }
        public int ValueAsWord      { get { return int.Parse(value) & 0xffff; } }
        public int ValueAsUpperWord { get { return (int.Parse(value) >> 16) & 0xffff; } }
        public int ValueAsLowerWord { get { return (int.Parse(value)) & 0xffff; } }

        public string NamePadding  { get { return new string('\t', 8 - (name.Length + 1) / 8); } }

        public string name;
        public string description;
        public string value;
        public int varType;
        public UInt16 size;
        public int usage;
        public UInt16 addr;

        private static string nameSuffix = "P_NAME";

        public static bool IsNameVar(string var)
        {
            if (var.Length >= nameSuffix.Length)
            {
                if (var.Substring(var.Length - nameSuffix.Length).CompareTo(nameSuffix) == 0)
                {
                    return true;
                }
            }
            return false;
        }

        public bool IsNameVar()
        {
            return IsNameVar (name);
        }

        public ScammVariable(string name, string description, string value, int type, UInt16 size, int usage, UInt16 addr)
        {
            this.name = name;
            this.description = description;
            this.value = value;
            this.varType = type;
            this.size = size;
            this.usage = usage;
            this.addr = addr;
        }

        public static void Reset (ref IDictionary<String, ScammVariable> vars, string ASMfile)
        {
            vars = new Dictionary<String, ScammVariable> ();

            ASMfile = ASMfile.Replace("\t", " ");
            var lines = ASMfile.Split(new[] { '\r', '\n' });
            foreach (var line in lines)
            {
                if (line.Length > 17)
                {
                    int a = line[17];
                }
                var trimmedLine = line.Replace((char)9, ' ');

                int i, ii;
                do
                {
                    i = ii = trimmedLine.Length;
                    trimmedLine = trimmedLine.Replace("  ", " ");
                    i = trimmedLine.Length;
                } while (i != ii);

                trimmedLine = trimmedLine.Trim();
                if ((trimmedLine.Length > 0) && (trimmedLine.Substring(0, 1).CompareTo(".") != 0))
                {
                    var codeVsComment = trimmedLine.Split(';');
                    if (codeVsComment.Length > 0)
                    {
                        var code = codeVsComment[0].Trim().Split(' ');
                        if (code.Length > 1)
                        {
                            string name = code[0];
                            UInt16 addr = (UInt16)int.Parse(code[2].Substring(3, 4), System.Globalization.NumberStyles.HexNumber);
                            var metaVsComment = codeVsComment[1].Split('#');
                            if (metaVsComment.Length > 1)
                            {
                                string description = metaVsComment[2].Trim(trimChars);
                                var meta = metaVsComment[0].Trim().Split(' ');
                                UInt16 size = UInt16.Parse(meta[0]);
                                int type = ScammVariableType.typeNames.IndexOf(meta[1]);
                                if (type != ScammVariableType.svt_marker)
                                {
                                    int usage = ScammVariableUsage.usageNames.IndexOf(meta[2]);
                                    string defaultValue = (type == ScammVariableType.svt_pEventHandler) ? "return\r\n" :
                                        (type == ScammVariableType.svt_pObjectList) ? "0" : metaVsComment[1].Trim();

                                    if (size != 0)
                                    {
                                        vars.Add(name, new ScammVariable(name, description, defaultValue, type, size, usage, addr));
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
