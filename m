Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282690AbRLBCRq>; Sat, 1 Dec 2001 21:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282685AbRLBCR0>; Sat, 1 Dec 2001 21:17:26 -0500
Received: from adsl-67-36-120-14.dsl.klmzmi.ameritech.net ([67.36.120.14]:30892
	"HELO tabris.net") by vger.kernel.org with SMTP id <S282684AbRLBCRU>;
	Sat, 1 Dec 2001 21:17:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
Organization: Dome-S-Isle Data
To: "victor1 torres" <camel_3@hotmail.com>
Subject: Re: Bidirectional USB Printer
Date: Sat, 1 Dec 2001 21:17:08 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <F63HzGkzMcvsq9IcVux00007d18@hotmail.com>
In-Reply-To: <F63HzGkzMcvsq9IcVux00007d18@hotmail.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011202021708.81E76FB80D@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 December 2001 12:51, victor1 torres wrote:
> I have a bidirectional usb printer and I was woundering how I would get
> that to work with user space programs and if it really is supported. When I
> load all my USB things and the printer.o it says Bidirectional USB Printer
> = usblp0

Doesn't sounds like a problem. Merely have to set up LPR or whatever printing 
subsystem is in use w/ your distribution. You never said what distribution, 
so I can't tell you what to do to configure your box. Presumably, all u need 
to do is configure whatever LPR equivalent to use /dev/usblp0 (or do a find 
for lp0 in your /dev/ directory).

> Please help.
It's kind of hard when you don't tell us enough to give you a concise answer. 
Please help us by helping yourself in the future.
> Thanks in advance
Spelling errors corrected for free
>

BTW, next time try to cc: to the appropriate subsystem maintainer (in this 
case USB and/or printing/parport) not the kernel maintainer. Neither Linus or 
Marcelo need to be cc:'d for this kind of question.
-- 
tabris

   If at first you don't succeed, cheat. Repeat until caught, and then
   lie.

                                               My best friend's back pack

