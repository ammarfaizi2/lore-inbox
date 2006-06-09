Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965170AbWFIUow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbWFIUow (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965166AbWFIUow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:44:52 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:10295 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S965168AbWFIUov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:44:51 -0400
Date: Fri, 9 Jun 2006 13:44:18 -0700
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
Message-ID: <20060609204418.GG3574@ca-server1.us.oracle.com>
Mail-Followup-To: Alex Tomas <alex@clusterfs.com>,
	Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Chase Venters <chase.venters@clientec.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Dilger <adilger@clusterfs.com>,
	Andrew Morton <akpm@osdl.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, cmm@us.ibm.com,
	linux-fsdevel@vger.kernel.org
References: <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org> <20060609181020.GB5964@schatzie.adilger.int> <Pine.LNX.4.64.0606091114270.5498@g5.osdl.org> <m31wty9o77.fsf@bzzz.home.net> <Pine.LNX.4.64.0606091137340.5498@g5.osdl.org> <Pine.LNX.4.64.0606091347590.5541@turbotaz.ourhouse> <1149880865.22124.70.camel@localhost.localdomain> <m3irna6sja.fsf@bzzz.home.net> <4489CB42.6020709@garzik.org> <m3wtbq5dgw.fsf@bzzz.home.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3wtbq5dgw.fsf@bzzz.home.net>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 11:35:43PM +0400, Alex Tomas wrote:
> that's your point of view. mine is that this option (and code)
> to be used only when needed. 

	Which is irrelevant.  If you tell the world "extents are
better!", they're going to turn them on regardless of whether you
consider their situation a good candidate.  Many non-kernel-hackers
started using reiserfs before it was usably stable, just because
"journaling is better!"

Joel

-- 

Life's Little Instruction Book #347

	"Never waste the oppourtunity to tell someone you love them."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
