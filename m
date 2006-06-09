Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030496AbWFIVLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030496AbWFIVLu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWFIVLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:11:50 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:21724 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932328AbWFIVLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:11:49 -0400
Date: Fri, 9 Jun 2006 14:11:23 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Alex Tomas <alex@clusterfs.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chase Venters <chase.venters@clientec.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609211123.GI3574@ca-server1.us.oracle.com>
Mail-Followup-To: Alex Tomas <alex@clusterfs.com>,
	Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Chase Venters <chase.venters@clientec.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Dilger <adilger@clusterfs.com>,
	Andrew Morton <akpm@osdl.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, cmm@us.ibm.com,
	linux-fsdevel@vger.kernel.org
References: <Pine.LNX.4.64.0606091114270.5498@g5.osdl.org> <m31wty9o77.fsf@bzzz.home.net> <Pine.LNX.4.64.0606091137340.5498@g5.osdl.org> <Pine.LNX.4.64.0606091347590.5541@turbotaz.ourhouse> <1149880865.22124.70.camel@localhost.localdomain> <m3irna6sja.fsf@bzzz.home.net> <4489CB42.6020709@garzik.org> <m3wtbq5dgw.fsf@bzzz.home.net> <20060609204418.GG3574@ca-server1.us.oracle.com> <m3fyie5a19.fsf@bzzz.home.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3fyie5a19.fsf@bzzz.home.net>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2006 at 12:49:54AM +0400, Alex Tomas wrote:
> >>>>> Joel Becker (JB) writes:
>  JB> 	Which is irrelevant.  If you tell the world "extents are
>  JB> better!", they're going to turn them on regardless of whether you
>  JB> consider their situation a good candidate.  Many non-kernel-hackers
>  JB> started using reiserfs before it was usably stable, just because
>  JB> "journaling is better!"
> 
> I haven't said that so far. I feel absolutely comfortable to put
> as many warnings as needed from your point of view.

	When I say "you", I mean the general consensus.  You can scream
"don't do this" as loud as you want, the world might drown you out.  Not
every random person that sees "new extents in ext3" is going to know
that Alex is the authority.  They certainly aren't going to read the
documentation.  They'll read some comment on some website that says "all
you need is '-o extents'!"

Joel


-- 

"A narcissist is someone better looking than you are."  
         - Gore Vidal

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
