Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285060AbRLLCun>; Tue, 11 Dec 2001 21:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285062AbRLLCug>; Tue, 11 Dec 2001 21:50:36 -0500
Received: from smtpmail1.msi.com.tw ([203.66.186.152]:60945 "EHLO
	smtpdom.msi.com.tw") by vger.kernel.org with ESMTP
	id <S285060AbRLLCuS>; Tue, 11 Dec 2001 21:50:18 -0500
Reply-To: <aaronhsieh@msi.com.tw>
From: "aaronhsieh" <aaronhsieh@msi.com.tw>
To: <linux-kernel@vger.kernel.org>
Cc: =?big5?B?TW9sbHlXdSinZKlzxFIp?= <mollywu@msi.com.tw>
Subject: Kernel issue 2.4.6~2.4.16
Date: Wed, 12 Dec 2001 10:50:58 +0800
Message-ID: <000e01c182b7$ea5d65a0$1c0510ac@ah>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mangalore.zipworld.com.au id NAA13321

Dear Kernel team:
                                 I have some question about Kernel 2.4.6~2.4.16.

                                 I make Kernel 2.4.6~2.4.16 on my system.But the O.S will dump on every time(If i set CPU type for AMD Athlon/Doron/K7)
.And has results in message:

-----------------------------------------------------------------------------------------------------------------------------------------------
CPU: 0

EIP: 0010 [<c012c9c7c>]  Not Tainted

EFLAGS: 00010282

eax: 00000088   ebx: c02b3000    ecx: c02b2fe8    edx: 00003331   esi: c10ccc40    edi: 00000000

ebp: 00000001  esp: c1689e54

ds: 0018  es: 0018    ss:0018

Processs mrtg (pid: 1930 , Stackpage= c1689000)

Stack: c02b315c   00000001   c02b2fe8   00000000    00002331   00000282   00000000   c02b2fe8

            c012cbfb    000001d2   c34299c0  c3627640     c1dbd3d8   00000000   c02b2fe8     c02b3158

            000001d2  c024bac6    c012ca16  080fb6214    c01230c6   808f6214     c3627640   c34229c0

Call Trace:  [<c012cbfb>]  [<c024bac6>]   [<c012cae6>]   [<c01230c6>]   [<c0123e6f>]   [<c0123285>]
                     [<c0111318>]  [<c0111270>]  [<c0131977>]   [<c01245a4>]  [<c01235d3>]  [<c0106fa0>]
-------------------------------------------------------------------------------------------------------------------------------------------------

                   It's all.

                   So,how to fix the "big problem"?

                   If set CPU type for "P-III / Celeron".System fine! Why?


My H/W configuration:
                                       VIA Chipset: KN-133 ' KLE-133(North Bridge)       
                                                               686B(South Nridge)

                                        AMD Duron-850 ' Mobile Duron-850

                                        On-Board 64M SDRAM(Share 8M VGA ram)




---------------------------------------------------
Aaron Hsieh

Micro-Start Int'l Co.,Ltd.

IA Testing Team

Tel.886-2-3234-5599 #8429

Fax.886-2-32348791

E-mail:aaronhsieh@msi.com.tw
---------------------------------------------------ı:.Ë›±Êâmçë¢kaŠÉb²ßìzwm…ébïîË›±Êâmébìÿ‘êçz_âØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Ş—ú+€Ê+zf£¢·hšˆ§~†­†Ûiÿÿïêÿ‘êçz_è®æj:+v‰¨ş)ß£ømšSåy«­æ¶…­†ÛiÿÿğÃí»è®å’i
