using System.Runtime.InteropServices;
using RGiesecke.DllExport;
using Telegram.Bot;
using Telegram.Bot.Types;

namespace TelegramBotDllExport
{
    public class TelegramBot
    {
        private static TelegramBotClient Bot { get; set; }
        private static Chat _chat { get; set; }

        [DllExport]
        public static void Init([MarshalAs(UnmanagedType.LPWStr)]string token)
        {
            Bot = new TelegramBotClient(token);
            Bot.OnMessage += (sender, args) =>
            {
                _chat = args.Message.Chat;
                Bot.SendTextMessageAsync(
                    chatId: _chat,
                    text:   "registered: " + args.Message.Chat.Id);
            };
            Bot.StartReceiving();
        }

        [DllExport]
        public static void SendMessage([MarshalAs(UnmanagedType.LPWStr)]string msg)
        {
            if(_chat != null)
                Bot.SendTextMessageAsync(chatId: _chat,text: msg);
        }
    }
}
