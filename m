Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281887AbRKWEYI>; Thu, 22 Nov 2001 23:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281890AbRKWEX6>; Thu, 22 Nov 2001 23:23:58 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:57585 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281887AbRKWEXr>;
	Thu, 22 Nov 2001 23:23:47 -0500
Date: Thu, 22 Nov 2001 21:22:49 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Stuart Young <sgy@amc.com.au>, linux-kernel@vger.kernel.org,
        Rob Turk <r.turk@chello.nl>, torvalds@transmeta.com
Subject: Re: Linux FSCP (Frequently Submitted Compilation Problems)? (was:  Re: Loop.c File !!!!)
Message-ID: <20011122212249.U1308@lynx.no>
Mail-Followup-To: Richard Gooch <rgooch@ras.ucalgary.ca>,
	Stuart Young <sgy@amc.com.au>, linux-kernel@vger.kernel.org,
	Rob Turk <r.turk@chello.nl>, torvalds@transmeta.com
In-Reply-To: <Pine.LNX.4.21.0111202025290.6299-100000@brick> <5.1.0.14.2.20011121082413.00abadd0@pop.gmx.net> <5.1.0.14.0.20011122100929.009ead30@mail.amc.localnet> <9ti8e5$9bl$1@ncc1701.cistron.net> <5.1.0.14.0.20011123105317.00a0c940@mail.amc.localnet> <20011122180320.R1308@lynx.no> <200111230116.fAN1G8p04152@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200111230116.fAN1G8p04152@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Thu, Nov 22, 2001 at 06:16:08PM -0700
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 22, 2001  18:16 -0700, Richard Gooch wrote:
> Andreas Dilger writes:
> > On Nov 23, 2001  11:03 +1100, Stuart Young wrote:
> > > >Something along the lines of 'Your kernel failed to build. Check
> > > >www.where-ever-the-buglist-is.org for known issues with your kernel.
> > > >Post your problem on the kernel list if this is not a FRB'. Is this
> > > >something that can be done easily?
> > > 
> > > At the bottom of the file, have ANOTHER link to a generic FAQ about 
> > > compilation problems (which covers all the major things like forgetting
> > > to install an assembler, the broken old build stuff, 'make dep' before 
> > > compiling modules, etc). The FAQ could be on the kernel mirrors as well 
> > > (and I don't see why not, as this is all kernel related, and definitely a 
> > > resource that needs to be in more than one place).
> > 
> > Yes!!!!  Anything to reduce the number of repeat problems reported
> > is good in my books.  It might also hold a pointer to Linus' (or
> > Marcello's) -pre patch area, with a warning that they are not for
> > everyone.
> 
> Well, the FAQ is supposed to answer these questions. There's a whole
> section on compile problems. Do we need another FAQ?

Well, you've seen how many times Keith points people to the FAQ on
module versions, after they post to the list first.  You only see
the FAQ URL at the bottom of the emails if you have previously read
the mailing list, which most haven't.

> However, I could easily upload the FAQ to kernel.org at the same time
> as I upload to tux.org, since I've already got an area there. Would
> this be useful? If so, then perhaps Linus could put in a symbolic link
> so that ftp.kernel.org:/pub/linux/kernel/faq.html points to:
> "people/rgooch/faq.html", so that it's visible from the top level.

It would be nice if the section of compile problems could be linked to
separately, so people don't have to read the whole FAQ to read about
their specific problem.  While reading the whole thing is not a bad idea,
it _is_ fairly long.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

