Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267359AbTBFQt2>; Thu, 6 Feb 2003 11:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267362AbTBFQt2>; Thu, 6 Feb 2003 11:49:28 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:62449 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S267359AbTBFQt1>; Thu, 6 Feb 2003 11:49:27 -0500
Date: Thu, 6 Feb 2003 09:58:50 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Larry McVoy <lm@work.bitmover.com>, lm@bitmover.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-ID: <20030206095850.D18636@schatzie.adilger.int>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>, lm@bitmover.com,
	linux-kernel@vger.kernel.org
References: <20030205174021.GE19678@dualathlon.random> <20030205102308.68899bc3.akpm@digeo.com> <20030205184535.GG19678@dualathlon.random> <20030205114353.6591f4c8.akpm@digeo.com> <20030205141104.6ae9e439.arashi@yomerashi.yi.org> <20030205233115.GB14131@work.bitmover.com> <20030205233705.A31812@infradead.org> <20030205235706.GB21064@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030205235706.GB21064@work.bitmover.com>; from lm@bitmover.com on Wed, Feb 05, 2003 at 03:57:06PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 05, 2003  15:57 -0800, Larry McVoy wrote:
> On Wed, Feb 05, 2003 at 11:37:05PM +0000, Christoph Hellwig wrote:
> > On Wed, Feb 05, 2003 at 03:31:15PM -0800, Larry McVoy wrote:
> > > We can go buy another machine for glibc2.3, I just need to know what
> > > redhat release uses that.  If there isn't one, what distro uses that?
> > 
> > redhat 8.0 uses a prerelease of glibc2.3, the current redhat beta uses
> > glibc 2.3.1+CVS, dito for debian unstable.
> 
> And is everyone happy with 8.0's glibc, if we offer that up until 8.1 comes
> out?  If so, we'll buy a machine and add it to the build cluster this week.

UML is your friend here - you can have a whole set of distros/revisions all
on the same host.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

