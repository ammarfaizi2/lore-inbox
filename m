Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277868AbRJNVoG>; Sun, 14 Oct 2001 17:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277871AbRJNVn5>; Sun, 14 Oct 2001 17:43:57 -0400
Received: from Expansa.sns.it ([192.167.206.189]:47631 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S277868AbRJNVno>;
	Sun, 14 Oct 2001 17:43:44 -0400
Date: Sun, 14 Oct 2001 23:44:08 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Riley Williams <rhw@MemAlpha.cx>
cc: Henning P Schmiedehausen <hps@intermeta.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>, <lisi@cibs10.sns.it>
Subject: Re: 2.0.39 kernel release history
In-Reply-To: <Pine.LNX.4.21.0110142007300.6433-100000@Consulate.UFP.CX>
Message-ID: <Pine.LNX.4.33.0110142318220.18041-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Oct 2001, Riley Williams wrote:

> > Yes, you are right, if I do remember well there as been 10/12 1.99.X
> > kernels.
>
> Unless I'm mistaken, the 2.0-pre series of releases was identified
> internally as 1.99.x instead. This series of 14 kernels were released
> between 12 May 1996 and 6 Jun 1996, and are listed in the quote above.
let me remember. I used and teste all kernel from 1.3.20 till 2.0.0, and
so...
after 1.3.100 there was 1.99.1. It was released with this name.
I do not remember if i tested 14 kernels. They were released really fast,
one, sometimes two, every day.
My test server was a P75 with 16 ;byte of RAM and 1 GB of hard disk.
I had 50 users, and usually i had 4 users conneted interactivelly at the
same time, using three IBM black and white X-Terms, and the X11 session
(one stelath 64 video card, with 2 Mbyte RAM, on a 17 incs monitor,
with a resolution of 1280x1024 at 8 bpp :) ). All suers were using mozilla
or netscape, fvwm 1.4, and xosview :). Now you would need mutch more
memory to do the same with modern DE!.
>
> If I am mistaken and there were indeed a dozen or so kernels released
> with 1.99 version numbers between 1.3.100 and 2.0-pre1, they were all
> released in the 2 days between those kernels, and I have to state that
> I would consider this unlikely, although not impossible.
2.0.0-pre1 was released two day before 2.0.0.
I had no time to test 2.0.0-pre2
Then Linus posted a mail saying (passim, I try to remeber more or less
the content).

"2.0.0 is out. what changed? ummm let me think. it's a lot of time I am
not using a 1.2 kernel [....] World domination last"

Italo, could you try to help me to remember? You were upgrading RS6000
from AIX 3.1 to AIX 3.2.5, I think.

2.0.21 has been out for maybe a couple of month before 2.0.22 have been
released. 2.0.21 was more that rock solid!
We bought at SNS 6 Pentoium Pro220 Mhz some days after 2.0.21 was
released, but they were putted into production
with 2.0.28 (a lot of time after, I know, but there was a problem with
adaptec 2940UW and some ext2 corruption)

Luigi Genoni

>
> However, the claim that there were other kernels between 0.01 and 0.10
> of which I am not aware, or between 0.12 and 0.95 of which I am also not
> aware, would not surprise me in either case. Here is the relevant part
> of the history sequence for this period...
there was I think at less a kernel, maybe two,  after 0.0.1 and before
0.10, but I do not remeber. I started to use Linux seriously with 0.96 on
a 386 DX 33 Mhz with 4 mega of RAM (used to host a BBS for SNS students,
that was closed when CED Director discovered it)
>
> >>> 17 Sep 1991  17:29:55          10,239        235,669  0.01
> >>>
> >>>  3 Dec 1991   1:48:02          13,460        307,481  0.10
> >>>  8 Dec 1991  18:37:16          13,839        319,681  0.11
> >>> 16 Jan 1992   6:39:10          19,258        446,636  0.12
> >>>
> >>>  8 Mar 1992  12:04:59          20,882        493,630  0.95
> >>> 17 Mar 1992  21:47:55          21,275        503,578  0.95a
> >>>  9 Apr 1992  20:48:11          22,147        527,085  0.95c
>
> ...and you will note that 11 weeks passed between the 0.01 and 0.10
> kernels, and a further 7.5 weeks between the 0.12 and 0.95 kernels.
> However, I have been unable to locate any reliable information regarding
> the missing kernels, so this is the limit of my knowledge here.
>
> The other period where I suspect missing kernels is this one...
>
> >>> 15 Aug 1993  15:28:14         122,867      3,244,802  0.99.12
> >>> 17 Aug 1993  22:39:38         122,871      3,244,979  0.99.12a
> >>>
> >>> 20 Sep 1993  16:18:01         124,228      3,279,890  0.99.13
> >>>
> >>> 25 Oct 1993  22:33:27         135,501      3,605,576  0.99.13k
> >>>
> >>> 29 Nov 1993   9:11:53         157,045      4,180,919  0.99.14
> >>>  3 Dec 1993  15:26:49         156,751      4,169,476  0.99.14a
>
> ...between the 0.99.12a and 0.99.14 kernel releases. I suspect both that
> there were other kernels in each of the three gaps shown above, but have
> been unable to find any reliable information regarding them. Personally,
> I would anticipate full alphabets for both the 0.99.12 and 0.99.13
> subseries as occurs with the 0.99.14 subseries, but can't prove it.
>
> As far as I am aware, the collection of available kernels from 0.99.14
> to date is complete, and it is only these five gaps where kernels are
> missing. ANY information regarding any of the missing kernels would be
> much appreciated, and actual tarballs for ANY of these would be a bonus.
>
> Best wishes from Riley.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

