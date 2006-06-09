Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030409AbWFITGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030409AbWFITGN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbWFITGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:06:13 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:9133 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030409AbWFITGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:06:11 -0400
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chase Venters <chase.venters@clientec.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Alex Tomas <alex@clusterfs.com>,
       Andreas Dilger <adilger@clusterfs.com>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606091347590.5541@turbotaz.ourhouse>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	 <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int>
	 <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
	 <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>
	 <m33beecntr.fsf@bzzz.home.net>
	 <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>
	 <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
	 <20060609181020.GB5964@schatzie.adilger.int>
	 <Pine.LNX.4.64.0606091114270.5498@g5.osdl.org>
	 <m31wty9o77.fsf@bzzz.home.net>
	 <Pine.LNX.4.64.0606091137340.5498@g5.osdl.org>
	 <Pine.LNX.4.64.0606091347590.5541@turbotaz.ourhouse>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 09 Jun 2006 20:21:04 +0100
Message-Id: <1149880865.22124.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-06-09 am 13:50 -0500, ysgrifennodd Chase Venters:
> It's about bundling. It's about being able to take your 3-year old 
> dependable car and make it faster by bolting on new manifolds and 
> turbochargers, rather than waiting a year for the manufacturer to release 
> a totally new model

Unfortunately in the software case if you want it in the base kernel you
are bolting new manifolds on everyones car at once, and someone is going
to have an engine explode as a result.

Ext3 already has enough back compatiblity that you can replace the
engine with a horse, we don't need any more in it thank you.

Alan

