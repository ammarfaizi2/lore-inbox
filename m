Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267028AbSLEAUV>; Wed, 4 Dec 2002 19:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267084AbSLEAUV>; Wed, 4 Dec 2002 19:20:21 -0500
Received: from smtprelay6.dc2.adelphia.net ([64.8.50.38]:37515 "EHLO
	smtprelay6.dc2.adelphia.net") by vger.kernel.org with ESMTP
	id <S267028AbSLEAUR>; Wed, 4 Dec 2002 19:20:17 -0500
Message-ID: <01c301c29bf5$201a9120$6a01a8c0@wa1hco>
From: "jeff millar" <wa1hco@adelphia.net>
To: "Shane Helms" <shanehelms@eircom.net>, <linux-kernel@vger.kernel.org>
References: <F6E1228667B6D411BAAA00306E00F2A51539BA@pdc2.nestec.net> <200212041526.57501.shanehelms@eircom.net>
Subject: Re: is KERNEL developement finished, yet ???
Date: Wed, 4 Dec 2002 19:27:40 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My opinion...

Kernels are getting mature in the sense the there's not that many ways to do
tasking and hardware interface.  It no longer a game of invention but a game
of polishing.  The amount of total work available probably continues to go
up because kernels are becoming as common as screws.

It's like the guy who invented interchangable hardware in the
1700's...really cool and creates plenty of work but it's no longer bleeding
edge to design the next screw thread in the next material.

So, do you want to push the edge and discover new principles and go where no
one has gone before?  Or do you want to make the existing implementations
better than anyone else ever has before?

If you want to stay with programming close to the hardware, think about
pulling the essential elements of I/O drivers and some parts of applications
into VHDL and programmable hardware (FPGA's)...then hook those into the
kernel effectively and in an open architecture sort of way.

jeff

----- Original Message -----
From: "Shane Helms" <shanehelms@eircom.net>
To: <linux-kernel@vger.kernel.org>
Sent: Wednesday, December 04, 2002 10:26 AM
Subject: is KERNEL developement finished, yet ???


> I'd like most of you to answer the following question, that includes even
> Linus.
>
> I love C programming at low level (ie kernel, embedded, etc) and i'm
seriously
> good at it. But don't know whether I should persue it as my main Career or
> just as an Interest. My question is, is there, yet, any area at this low
> level to be discovered and developed on ? or as most ppl say, are the
> interesting parts over and it's just now into patches, bugs and slight
> enhancements/optimizations/securities ?
>
> I'm starting a Post-Graduate studies at April, and need to know, whether
it's
> worth going into Computer Architecture Group as my main career, or shall I
> stir towards a another area like networking which is still in
developement,
> and plenty of jobs (but not as interssting as kernel/OS programming) ?????

>
> please reply, and if in favor of kernel developement, try to name some
areas
> where there yet relies hope.
>
> Thanks,
>
> Shane
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

