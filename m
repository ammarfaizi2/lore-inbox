Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261781AbTCLQIN>; Wed, 12 Mar 2003 11:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261782AbTCLQIN>; Wed, 12 Mar 2003 11:08:13 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:30474 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S261781AbTCLQIL>; Wed, 12 Mar 2003 11:08:11 -0500
Date: Wed, 12 Mar 2003 11:18:38 -0500
From: Ben Collins <bcollins@debian.org>
To: Jens Axboe <axboe@suse.de>, Larry McVoy <lm@work.bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030312161838.GF563@phunnypharm.org>
References: <20030312034330.GA9324@work.bitmover.com> <20030312041621.GE563@phunnypharm.org> <20030312085517.GK811@suse.de> <20030312032614.G12806@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030312032614.G12806@schatzie.adilger.int>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 03:26:14AM -0700, Andreas Dilger wrote:
> On Mar 12, 2003  09:55 +0100, Jens Axboe wrote:
> > On Tue, Mar 11 2003, Ben Collins wrote:
> > > You've made quite a marketing move. It's obvious to me, maybe not to
> > > others. By providing this CVS gateway, you make it almost pointless to
> > > work on an alternative client. Also by providing it, you make it easier
> > > to get away with locking the revision history into a proprietary format.
> > 
> > This is a really good point, deserves high lighting imho...
> > 
> > The BK candy is getting increasingly bitter to swallow here, I may just
> > have to drop it soon. A shame.
> 
> Sadly, some people see the dark side of everything.  I don't see how making
> a CVS repository available with comments and an as-good-as-you-can-do-with-CVS
> equivalent of a BK changeset equals "locking the revision history into a
> proprietary format".  Yes, Larry said that this would allow him to change the
> BK file format to break compatibility with CSSC, but it is no more "locked
> away" now than before for those people who refuse to use BK.
> 
> Ironically, SCCS was a former "evil proprietary format" that was reverse
> engineered to get CSSC, AFAIK.  People are still free to update CSSC to
> track BK if they so choose.

Atleast SCCS is mostly ascii. Larry is talking about binary. Who knows,
maybe even encrypted and using some unknown compression method (I'm sure
if it's encrypted, it will be called "compression").


-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
