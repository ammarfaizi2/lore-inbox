Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314352AbSEFKlQ>; Mon, 6 May 2002 06:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314358AbSEFKlP>; Mon, 6 May 2002 06:41:15 -0400
Received: from prahaa-1-51.dialup.vol.cz ([195.122.213.51]:32261 "HELO 2100.cz")
	by vger.kernel.org with SMTP id <S314352AbSEFKlP>;
	Mon, 6 May 2002 06:41:15 -0400
Message-ID: <3CD687F3.4040505@alej.cz>
Date: Mon, 06 May 2002 12:41:07 -0100
From: K <k@alej.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.13 and 2.5.14 randomly freezes
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've tried to install 2.5.13 kernel at first and then 2.5.14, but I have 
same problem with both of them:
the whole report is at http://www.volny.cz/macros/kernel/report/ <- look 
there

=== boot up - freeze ===

ACPI: Power Button (FF) [PWRF]

| ACPI: Sleep Button (FF) [SLPF]
ACPI: Power Button (CM) [PWRB]
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
parport0: PC-style at 0x378 [PCSPP(,...)]
vesafb: framebuffer at 0xf0000000, mapped to 0xd0816000, size 32768k
vesafb: mode is 1280x1024x16, linelength=2560, pages=1
vesafb: protected mode interface info at c000:0f3e
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 160x64
fb0 VESA VGA frame buffer device pty: 256 Unix98 ptys con|

/Freeze at last line, sometimes prints more or less (changes every boot 
time). For example:/
| pty: 256 Unix98 ptys
pty: 256 Unix98 ptys c
pty: 256 Unix98 ptys confi|/(here is half of/ "g"/ character
/

/Vaclav Bartik
<k@alej.cz>
/

/
/

/
/


