Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbVCNWE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVCNWE6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 17:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVCNWD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 17:03:29 -0500
Received: from gate.crashing.org ([63.228.1.57]:20634 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261984AbVCNWAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 17:00:32 -0500
Subject: Re: dmesg verbosity [was Re: AGP bogosities]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Pavel Machek <pavel@ucw.cz>, David Lang <david.lang@digitalinsight.com>,
       Dave Jones <davej@redhat.com>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200503140855.18446.jbarnes@engr.sgi.com>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.62.0503140026360.10211@qynat.qvtvafvgr.pbz>
	 <20050314083717.GA19337@elf.ucw.cz>
	 <200503140855.18446.jbarnes@engr.sgi.com>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 08:55:41 +1100
Message-Id: <1110837341.5863.21.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> We already have the 'quiet' option, but even so, I think the kernel is *way* 
> too verbose.  Someone needs to make a personal crusade out of removing 
> unneeded and unjustified printks from the kernel before it really gets better 
> though...

Oh well, I admit going backward here with my new radeonfb which will be
very verbose in a first release, but that will be necessary to track
down all the various issues with monitor detection, BIOSes telling crap
about connectors etc...

Ben.


