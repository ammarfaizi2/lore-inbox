Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281759AbRLBScc>; Sun, 2 Dec 2001 13:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281762AbRLBScM>; Sun, 2 Dec 2001 13:32:12 -0500
Received: from f25.law4.hotmail.com ([216.33.149.25]:3084 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S281759AbRLBScF>;
	Sun, 2 Dec 2001 13:32:05 -0500
X-Originating-IP: [205.231.90.227]
From: "victor1 torres" <camel_3@hotmail.com>
To: ajschrotenboer@lycosmail.com
Subject: Re: Bidirectional USB Printer
Date: Sun, 02 Dec 2001 18:32:00 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F255bsHGKFMj0LClVNp00021b11@hotmail.com>
X-OriginalArrivalTime: 02 Dec 2001 18:32:00.0316 (UTC) FILETIME=[A16847C0:01C17B5F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I´m sorry I use Slackware-8.0 + Current
And one more thing could you give me the e-mail address for the USB 
Maintainers.
Victor

On Saturday 01 December 2001 12:51, victor1 torres wrote:
 > I have a bidirectional usb printer and I was woundering how I would get
 > that to work with user space programs and if it really is supported. When 
I
 > load all my USB things and the printer.o it says Bidirectional USB 
Printer
 > = usblp0

Doesn't sounds like a problem. Merely have to set up LPR or whatever 
printing
subsystem is in use w/ your distribution. You never said what distribution,
so I can't tell you what to do to configure your box. Presumably, all u need
to do is configure whatever LPR equivalent to use /dev/usblp0 (or do a find
for lp0 in your /dev/ directory).

 > Please help.
It's kind of hard when you don't tell us enough to give you a concise 
answer.
Please help us by helping yourself in the future.
 > Thanks in advance
Spelling errors corrected for free
 >

BTW, next time try to cc: to the appropriate subsystem maintainer (in this
case USB and/or printing/parport) not the kernel maintainer. Neither Linus 
or
Marcelo need to be cc:'d for this kind of question.
--
tabris



_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

