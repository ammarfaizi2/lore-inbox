Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281852AbRKWBQm>; Thu, 22 Nov 2001 20:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281854AbRKWBQW>; Thu, 22 Nov 2001 20:16:22 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:46248 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281852AbRKWBQO>; Thu, 22 Nov 2001 20:16:14 -0500
Date: Thu, 22 Nov 2001 18:16:08 -0700
Message-Id: <200111230116.fAN1G8p04152@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: Stuart Young <sgy@amc.com.au>, linux-kernel@vger.kernel.org,
        Rob Turk <r.turk@chello.nl>, torvalds@transmeta.com
Subject: Re: Linux FSCP (Frequently Submitted Compilation Problems)? (was:  Re: Loop.c File !!!!)
In-Reply-To: <20011122180320.R1308@lynx.no>
In-Reply-To: <Pine.LNX.4.21.0111202025290.6299-100000@brick>
	<5.1.0.14.2.20011121082413.00abadd0@pop.gmx.net>
	<5.1.0.14.0.20011122100929.009ead30@mail.amc.localnet>
	<9ti8e5$9bl$1@ncc1701.cistron.net>
	<5.1.0.14.0.20011123105317.00a0c940@mail.amc.localnet>
	<20011122180320.R1308@lynx.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger writes:
> On Nov 23, 2001  11:03 +1100, Stuart Young wrote:
> > >Something along the lines of 'Your kernel failed to build. Check
> > >www.where-ever-the-buglist-is.org for known issues with your kernel. Post 
> > >your problem on the kernel list if this is not a FRB'. Is this something 
> > >that can be done easily?
> > 
> > At the bottom of the file, have ANOTHER link to a generic FAQ about 
> > compilation problems (which covers all the major things like forgetting to 
> > install an assembler, the broken old build stuff, 'make dep' before 
> > compiling modules, etc). The FAQ could be on the kernel mirrors as well 
> > (and I don't see why not, as this is all kernel related, and definitely a 
> > resource that needs to be in more than one place).
> 
> Yes!!!!  Anything to reduce the number of repeat problems reported
> is good in my books.  It might also hold a pointer to Linus' (or
> Marcello's) -pre patch area, with a warning that they are not for
> everyone.

Well, the FAQ is supposed to answer these questions. There's a whole
section on compile problems. Do we need another FAQ?

However, I could easily upload the FAQ to kernel.org at the same time
as I upload to tux.org, since I've already got an area there. Would
this be useful? If so, then perhaps Linus could put in a symbolic link
so that ftp.kernel.org:/pub/linux/kernel/faq.html points to:
"people/rgooch/faq.html", so that it's visible from the top level.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
