Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266983AbTBQLKl>; Mon, 17 Feb 2003 06:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266987AbTBQLKl>; Mon, 17 Feb 2003 06:10:41 -0500
Received: from indianer.linux-kernel.at ([62.116.87.200]:7869 "EHLO
	indianer.linux-kernel.at") by vger.kernel.org with ESMTP
	id <S266983AbTBQLKk>; Mon, 17 Feb 2003 06:10:40 -0500
From: "Oliver Pitzeier" <oliver@linux-kernel.at>
To: <axp-kernel-list@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: 2.5.61 (Yes, there are still Alpha users out there. :-) )
Date: Mon, 17 Feb 2003 12:19:18 +0100
Organization: linux-kernel.at
Message-ID: <000d01c2d676$6d2bfec0$020b10ac@pitzeier.priv.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: 
Importance: Normal
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-0.4, required 5, AWL,
	NOSPAM_INC, QUOTED_EMAIL_TEXT, SPAM_PHRASE_00_01)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leslie Donaldson wrote:
>    Got the new kernel here are my results.

I also downloaded 2.5.61 today. I wasn't able the last 2 days. :-(

>    -) Base kernel now compiles out of box.

For me too.

>    -) firewire dma.c no compile. patch was late should be in next rev.
>       Maintainers already found bug.
>    -) Sound opl3sa2 no compile. Entered patch today

I don't use firewire, sound and so on, therefor I can't tell you my results
regarding this.

>    -) make modules_install still has
>       depmod: Unhandled relocation of type 10 for .text

There were also some problems with make modules_install for me!

> well there you go. For clarification until I get a clean
> install I'm not going to try and boot this thing. (I like my 
> raid working.)

I'll let it run now... Let's see. If the machine crashes I don't mind too much.
It's just an old Compaq AS1000 5/333 only used by me as Alpha-teststation and
some kind of "fileserver".

If it works well now and hopefully without crashing, I believe 2.6 will also
work fine... :-)

Best regards,
 Oliver


