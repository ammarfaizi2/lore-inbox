Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315611AbSGLKIE>; Fri, 12 Jul 2002 06:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315870AbSGLKID>; Fri, 12 Jul 2002 06:08:03 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:1637 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S315611AbSGLKIC>;
	Fri, 12 Jul 2002 06:08:02 -0400
Message-ID: <005801c2298c$9f3f6f10$1c6fa8c0@hyper>
From: "Christian Ludwig" <cl81@gmx.net>
To: "Daniel Phillips" <phillips@arcor.de>
Cc: "Linux Kernel Mailinglist" <linux-kernel@vger.kernel.org>
References: <003d01c22819$ba1818b0$1c6fa8c0@hyper> <E17Suso-0002dn-00@starship> <003f01c2297e$b3e395d0$1c6fa8c0@hyper> <E17SwAM-0002e2-00@starship>
Subject: Re: bzip2 support against 2.4.18
Date: Fri, 12 Jul 2002 12:12:18 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote on Friday, July 12, 2002 10:52 AM:

> On Friday 12 July 2002 10:32, Christian Ludwig wrote:
> > To make it
> > at least a little bit easier there should be that 'bz2' in the name. So
> > 'bz2linux' would be a goal. But if we do this we also could change
'bzImage'
> > to 'gzlinux'.
>
> You can feel pretty confident in thinking the name bzImage is never going
> to change, if only because too many fingers know how to type the stupid
> thing by reflex action.

Right.

> > On the other hand I also had the idea to let the name 'bzImage' be for
both,
> > gzip and bzip2. The problem is that I can neither overload the name nor
> > choose the kernel compression at configuration time [I do not know how
to
> > make it at least].
>
> Now that you mention it, bzImage should continue to serve perfectly well,
> so long as you have some other way of configuring the kernel compression
> method than via the make target.  Why not just make the compression method
> a config option?  If it had been done this way from the beginning, we'd
> never have acquired the b or the z.
>
> This way you avoid the entire controversy of chosing a new name for the
> kernel image, and anyway, it's a nicer interface than via the make
> target.

That came into my mind, too. Let's see what I can do about it...
It won't probably be ready before August, because I still have some exams.

Have fun.

    - Christian


