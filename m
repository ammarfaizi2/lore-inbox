Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030432AbWFITXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030432AbWFITXB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030427AbWFITXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:23:00 -0400
Received: from [80.71.248.82] ([80.71.248.82]:65260 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S1030425AbWFITW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:22:58 -0400
X-Comment-To: Alan Cox
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chase Venters <chase.venters@clientec.com>,
       Linus Torvalds <torvalds@osdl.org>, Alex Tomas <alex@clusterfs.com>,
       Andreas Dilger <adilger@clusterfs.com>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<4488E1A4.20305@garzik.org>
	<20060609083523.GQ5964@schatzie.adilger.int>
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
	<1149880865.22124.70.camel@localhost.localdomain>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Fri, 09 Jun 2006 23:24:57 +0400
In-Reply-To: <1149880865.22124.70.camel@localhost.localdomain> (Alan Cox's message of "Fri, 09 Jun 2006 20:21:04 +0100")
Message-ID: <m3irna6sja.fsf@bzzz.home.net>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Alan Cox (AC) writes:

 AC> Unfortunately in the software case if you want it in the base kernel you
 AC> are bolting new manifolds on everyones car at once, and someone is going
 AC> to have an engine explode as a result.

please, don't forget you need to enable it by mount option.

thanks, Alex
