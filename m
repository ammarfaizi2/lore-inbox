Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281891AbRKWEit>; Thu, 22 Nov 2001 23:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281904AbRKWEij>; Thu, 22 Nov 2001 23:38:39 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:34729 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281891AbRKWEiZ>; Thu, 22 Nov 2001 23:38:25 -0500
Date: Thu, 22 Nov 2001 21:38:29 -0700
Message-Id: <200111230438.fAN4cTt07168@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: Stuart Young <sgy@amc.com.au>, linux-kernel@vger.kernel.org,
        Rob Turk <r.turk@chello.nl>, torvalds@transmeta.com
Subject: Re: Linux FSCP (Frequently Submitted Compilation Problems)? (was:  Re: Loop.c File !!!!)
In-Reply-To: <20011122212249.U1308@lynx.no>
In-Reply-To: <Pine.LNX.4.21.0111202025290.6299-100000@brick>
	<5.1.0.14.2.20011121082413.00abadd0@pop.gmx.net>
	<5.1.0.14.0.20011122100929.009ead30@mail.amc.localnet>
	<9ti8e5$9bl$1@ncc1701.cistron.net>
	<5.1.0.14.0.20011123105317.00a0c940@mail.amc.localnet>
	<20011122180320.R1308@lynx.no>
	<200111230116.fAN1G8p04152@vindaloo.ras.ucalgary.ca>
	<20011122212249.U1308@lynx.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger writes:
> On Nov 22, 2001  18:16 -0700, Richard Gooch wrote:
> > Well, the FAQ is supposed to answer these questions. There's a whole
> > section on compile problems. Do we need another FAQ?
> 
> Well, you've seen how many times Keith points people to the FAQ on
> module versions, after they post to the list first.  You only see
> the FAQ URL at the bottom of the emails if you have previously read
> the mailing list, which most haven't.

Yeah. While the welcome message has a link to the FAQ, that doesn't
help for people who post without subscribing.

> > However, I could easily upload the FAQ to kernel.org at the same time
> > as I upload to tux.org, since I've already got an area there. Would
> > this be useful? If so, then perhaps Linus could put in a symbolic link
> > so that ftp.kernel.org:/pub/linux/kernel/faq.html points to:
> > "people/rgooch/faq.html", so that it's visible from the top level.
> 
> It would be nice if the section of compile problems could be linked
> to separately, so people don't have to read the whole FAQ to read
> about their specific problem.  While reading the whole thing is not
> a bad idea, it _is_ fairly long.

That would be easy to do with the WWW pages on www.kernel.org. Is that
what you had in mind?

However, you can easily end up with a growing list of "hotlinks" into
the FAQ, as someone decides some piece of information is really
important. As soon as you have one hotlink, you open the door for
many. Besides, the FAQ *does* have a contents list (with links).
People should be using that.

Ultimately, there's only so much you can do against human laziness.
I know, because I'm lazy too :-) I'd rather fiddle with the controls
of a new VCR than read the manual, or type "make" before reading the
README.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
