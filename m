Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263133AbTCLKRN>; Wed, 12 Mar 2003 05:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263134AbTCLKRM>; Wed, 12 Mar 2003 05:17:12 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:58865 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S263133AbTCLKRK>; Wed, 12 Mar 2003 05:17:10 -0500
Date: Wed, 12 Mar 2003 03:26:14 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Jens Axboe <axboe@suse.de>
Cc: Ben Collins <bcollins@debian.org>, Larry McVoy <lm@work.bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030312032614.G12806@schatzie.adilger.int>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Ben Collins <bcollins@debian.org>,
	Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
References: <20030312034330.GA9324@work.bitmover.com> <20030312041621.GE563@phunnypharm.org> <20030312085517.GK811@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030312085517.GK811@suse.de>; from axboe@suse.de on Wed, Mar 12, 2003 at 09:55:17AM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 12, 2003  09:55 +0100, Jens Axboe wrote:
> On Tue, Mar 11 2003, Ben Collins wrote:
> > You've made quite a marketing move. It's obvious to me, maybe not to
> > others. By providing this CVS gateway, you make it almost pointless to
> > work on an alternative client. Also by providing it, you make it easier
> > to get away with locking the revision history into a proprietary format.
> 
> This is a really good point, deserves high lighting imho...
> 
> The BK candy is getting increasingly bitter to swallow here, I may just
> have to drop it soon. A shame.

Sadly, some people see the dark side of everything.  I don't see how making
a CVS repository available with comments and an as-good-as-you-can-do-with-CVS
equivalent of a BK changeset equals "locking the revision history into a
proprietary format".  Yes, Larry said that this would allow him to change the
BK file format to break compatibility with CSSC, but it is no more "locked
away" now than before for those people who refuse to use BK.

Ironically, SCCS was a former "evil proprietary format" that was reverse
engineered to get CSSC, AFAIK.  People are still free to update CSSC to
track BK if they so choose.

Some people will just never be happy no matter what you give them.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

