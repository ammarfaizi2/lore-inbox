Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267729AbTATAL0>; Sun, 19 Jan 2003 19:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267732AbTATAL0>; Sun, 19 Jan 2003 19:11:26 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:36079 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S267729AbTATALZ>; Sun, 19 Jan 2003 19:11:25 -0500
Date: Sun, 19 Jan 2003 17:20:04 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: David Schwartz <davids@webmaster.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Is the BitKeeper network protocol documented?
Message-ID: <20030119172004.K1594@schatzie.adilger.int>
Mail-Followup-To: David Schwartz <davids@webmaster.com>,
	Roman Zippel <zippel@linux-m68k.org>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20030119162614.I1594@schatzie.adilger.int> <20030119235742.AAA13049@shell.webmaster.com@whenever>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030119235742.AAA13049@shell.webmaster.com@whenever>; from davids@webmaster.com on Sun, Jan 19, 2003 at 03:57:40PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 19, 2003  15:57 -0800, David Schwartz wrote:
> On Sun, 19 Jan 2003 16:26:14 -0700, Andreas Dilger wrote:
> >There is nothing in the GPL which requires anyone to make their
> >changes available to you the minute they make them.  The fact that
> >you have access to the changes within an hour of when they are made
> >far exceeds the requirements in the GPL, which only require that the
> >source code be made available if you distribute the OBJECT CODE OR
> >EXECUTABLE.
> 
> 	I think you're ignoring the way the GPL defines the "source code". 
> The GPL defines the "source code" as the preferred form for modifying 
> the program. If the preferred form of a work for purposes of 
> modifying it is live access to a BK repository, then that's the 
> "source code" for GPL purposes.

I think you are ignoring the fact that this clause (#3) in the GPL only
relates only if "you copy or distribute the Program (or a work based on
it, under Section 2) in object code or executable form".


> >There are still lots of other ways to get the kernel source.
> 
> 	You are using the conventional meaning of "source code", which is 
> roughly, "whatever you compile to get the executable". However, this 
> is not the "source" for GPL purposes. For GPL purposes, the source is 
> the preferred form of a work for purposes of modifying it.
> 
> 	This means you can't remove meta information that's useful for 
> modifying because that is not the preferred form. Such meta 
> information includes whatever is useful for modifying it, such as 
> revision history and chain of custody.
> 
> 	You can't have two "source"s, one a private repository that you 
> prefer to use for making changes and the other an "obfuscated" public 
> version you distribute for GPL compliance which is missing all the 
> other useful information.
> 
> 	Checking source out of a repository, separating away the revision 
> history, is an obfuscatory act. The GPL prohibits such source 
> obfuscation and requires you to distribute the source in whatever is 
> the actual preferred form for modifying it. Really. Sorry.

Again you are ignoring the fact that there are other methods by which
the source code is available in the "preferred form", just not quite as
timely as directly from the BK repository (which is itself in a form, SCCS,
which does not require BK to access), and there is nothing in the GPL which
requires that the source be made avaible instantly.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

