Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267715AbTASXRh>; Sun, 19 Jan 2003 18:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267720AbTASXRh>; Sun, 19 Jan 2003 18:17:37 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:29167 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S267715AbTASXRf>; Sun, 19 Jan 2003 18:17:35 -0500
Date: Sun, 19 Jan 2003 16:26:14 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Is the BitKeeper network protocol documented?
Message-ID: <20030119162614.I1594@schatzie.adilger.int>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
References: <20030118043309.GA18658@bjl1.asuk.net> <20030118052919.GA22751@work.bitmover.com> <3E296342.B3042E09@linux-m68k.org> <20030119113902.D1594@schatzie.adilger.int> <3E2B1DA7.CAA76FFF@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E2B1DA7.CAA76FFF@linux-m68k.org>; from zippel@linux-m68k.org on Sun, Jan 19, 2003 at 10:50:32PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 19, 2003  22:50 +0100, Roman Zippel wrote:
> Andreas Dilger wrote:
> > > IOW "You should be thankful for what I offer, if you don't like it, piss
> > > off!"  Might not be what you've intended, but that's what I arrived here
> > > and I'm sure I'm not the only one.
> > 
> > That's what he intended, and rightfully so.
> 
> I just wanted to make sure I understood correctly, I have an appropriate
> answer, but I can't word it as nicely as Larry.
> 
> >  You now have things you didn't
> > have before (i.e. hourly snapshots of Linus' tree) and you still aren't
> > happy.  I guess some people will never be happy with anything, so there is
> > no point in trying to appease them.
> 
> If you don't see the problem, maybe you should read
> /usr/src/linux/COPYING again for a change.

There is nothing in the GPL which requires anyone to make their changes
available to you the minute they make them.  The fact that you have access
to the changes within an hour of when they are made far exceeds the
requirements in the GPL, which only require that the source code be made
available if you distribute the OBJECT CODE OR EXECUTABLE.

If Linus uses BK to make pre-releases available to some people, that
does not appear to even invoke the "executable distribution" clause,
any more than him emailing patches to other developers privately.  If
Linus started making kernel patches available via a Lotus Notes database
(heaven forbid, I think even the IBM folks agree on that one ;-) doesn't
mean that IBM suddenly has to make all the details of Lotus Notes
available, or that Linus is forbidden to use tools as he wants.  There
are still lots of other ways to get the kernel source.

In fact (think about this for a while 8-o), EVERY SINGLE CHANGE that has
gone into the "official Linus kernel" had Linus doing the merge
(i.e. acting as editor of the combined work which is the kernel), which
may imply that Linus even owns a complete copyright over the entire
kernel source tree (i.e. compiled work).  Since he has never (or not
in the last decade, AFAIK) distributed a binary or object version of
the kernel, it may be that he isn't under any obligation to do anything
related to distribution under the GPL.  If you think that being the editor
of a combined work is not enough to give him copyright over the combined
work, then you need to learn your copyright law a bit more.  If it wasn't
for Linus acting as a "gatekeeper", the kernel would be full of the crap
that makes up 99% of the sourceforge projects out there.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

