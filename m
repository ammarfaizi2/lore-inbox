Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030366AbWFISiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbWFISiu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbWFISit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:38:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38288 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030362AbWFISis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:38:48 -0400
Date: Fri, 9 Jun 2006 11:38:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alex Tomas <alex@clusterfs.com>
cc: Andreas Dilger <adilger@clusterfs.com>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
In-Reply-To: <m31wty9o77.fsf@bzzz.home.net>
Message-ID: <Pine.LNX.4.64.0606091137340.5498@g5.osdl.org>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
 <4488E1A4.20305@garzik.org> <20060609083523.GQ5964@schatzie.adilger.int>
 <44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
 <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net>
 <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
 <20060609181020.GB5964@schatzie.adilger.int> <Pine.LNX.4.64.0606091114270.5498@g5.osdl.org>
 <m31wty9o77.fsf@bzzz.home.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Jun 2006, Alex Tomas wrote:
> 
> would "#if CONFIG_EXT3_EXTENTS" be a good solution then?

Let's put it this way:
 - have you had _any_ valid argument at all against "ext4"?

Think about it. Honestly. Tell me anything that doesn't work?

		Linus
