Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277326AbRJEHig>; Fri, 5 Oct 2001 03:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277327AbRJEHiZ>; Fri, 5 Oct 2001 03:38:25 -0400
Received: from sun250-0-admin.suomi.net ([212.50.140.140]:48541 "EHLO
	verkko.suomi.net") by vger.kernel.org with ESMTP id <S277326AbRJEHiS>;
	Fri, 5 Oct 2001 03:38:18 -0400
Date: Fri, 05 Oct 2001 10:38:22 +0300
From: Juha Siltala <juha.siltala@mail.suomi.net>
Subject: Fw: Re: Past CREDITS files
To: linux-kernel@vger.kernel.org
Message-id: <20011005103822.21d1f663.juha.siltala@mail.suomi.net>
MIME-version: 1.0
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i586-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I replied to Alan but forgot to cc here. (I'm not on the list so please cc
if you want me to see something.)

Begin forwarded message:

Date: Fri, 5 Oct 2001 10:31:34 +0300
From: Juha Siltala <juha.siltala@mail.suomi.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Past CREDITS files


On Thu, 04 Oct 2001 23:04:32 +0100 (BST)
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > I would like to examine the CREDITS files of all/most kernels released
> over
> > time. How could I get my hands on these? I want to study the
> accumulation
> > of contributors over the years. This is part of my masters thesis
> project.
> 
> Download all the kernels. Be aware they are
> 	-	Wildly inaccurate
> 	-	Started becoming accurate later on
> 	-	Were subject to significant external effects (the RH IPO
> 		caused people to massively update/send in new CREDIT entries)
> 	
> 
> They still represent a tiny subset of contributors. Especially the
> thousands
> who send in the odd small patch
> 
> > BTW, when was the current twofold stable/devel numbering scheme
> started?
> 
> See my historical mail archive. 
> http://www.linux.org.uk/Old-LK/Old-linux-kernel
> 
> Its in there somewhere 8)

I roamed the kernel archives and found no CREDITS files in very old (0.x)
kernels. I eased up my work by selecting just major versions from the
stable tree. Grepping those CREDITS gave some general data to back up a
simple statement that linux is a collaborative project, which has grown
bigger in time. Here's the data:

ver.	date		tar.bz2 size	contributors

1.0	12.03.1994	 993 k		80
1.2	06.03.1995	 1.8 M		128
2.0	08.06.1996	 4.5 M		190
2.2	25.01.1999	10.1 M		269
2.4	04.01.2001	18.9 M		391

Now this is not too much but a couple of developments are emerging:
checking out the geographical distribution of kernel hackers and some other
analysis based on the info that the files yield. I'm not the one doing this
but Dr. Silvonen (jussi.silvonen@helsinki.fi). I'm looking for a good way
of extracting names from the kernel sources instead of CREDITS, since Dr
Silvonen seems to be really getting into this and is data hungry now :)

I've been getting a lot of warnings (from Brian Gerst, Horst von Brand, and
Mark Hahn and others) about the data above. For my own purposes, that is,
to just show that linux is not "witten by Linus Torvalds in 1991" like we
hear from the media, the data would do. But If we (Dr. Silvonen and perhaps
I too) are going to elaborate on this, we obviously need something more
reliable. Everyone puts their name in their files and patches right?

I'd think that studying _all_ the kernels would be necessary, only more
elaborate name extraction method for the source files (I haven't figured
out how to do it yet though).

Thanks for taking the time to point out these weaknesses in my method!
-- 
|  Juha Siltala         |  Mail:juha.siltala@mail.suomi.net  |
|  Maahisentie 2K A8    |  Tel : +358  8 554 3591            |
|  90550 Oulu, Finland  |  GSM : +358 40 718 4743            |


