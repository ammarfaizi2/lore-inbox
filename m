Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129953AbRAXP1I>; Wed, 24 Jan 2001 10:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129944AbRAXP06>; Wed, 24 Jan 2001 10:26:58 -0500
Received: from [212.255.16.226] ([212.255.16.226]:53426 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S130153AbRAXP0q> convert rfc822-to-8bit;
	Wed, 24 Jan 2001 10:26:46 -0500
Message-ID: <006001c0861a$0c85c960$0100a8c0@homeip.net>
From: "mirabilos" <eccesys@topmail.de>
To: "Linux-Kernel ML" <linux-kernel@vger.kernel.org>
Subject: Hercules Graphics Card
Date: Wed, 24 Jan 2001 15:22:57 -0000
Organization: eccesys.net Linux Distribution Development
MIME-Version: 1.0
Content-Type: text/plain;
	charset="x-user-defined"
Content-Transfer-Encoding: 8BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.3018.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So I'm not the only... -- surprise for me, too.

I'm too using this, mostly because I like it, got up with it, and it's better than those pixelled displays today. And who needs colours?
For me, it says (2.4.0-prerelease) I'd got a HGC with 8 kB of RAM.
This surely isn't true because under DOS some pgmz work problemless
which use the whole 64K of &hB0000 to &hBFFFF (when I deactivate the VGA
card), and even Turbo Debugger 1.0's dual-screen option works in both gfx and
text mode, with the other card as debugging display in text mode, no matter whether the PGM uses HGC or VGA as primary display.
I'm sorry I've got no correction, but prolly you could try to read-modify-write-read-write_original, and compare the read value with the written bzw. the original.
And - do we get a HGC gfx framebuffer hgc1fb? (Btw, the vga16fb must be called vga4fb - it uses 4 bit colour, not 16)
What about dual-screen X... (this is OT - I know)

(Sorry about my English) - mirabilos


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
