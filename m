Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269003AbTCDCTT>; Mon, 3 Mar 2003 21:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269039AbTCDCTT>; Mon, 3 Mar 2003 21:19:19 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:62612 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S269003AbTCDCTS>; Mon, 3 Mar 2003 21:19:18 -0500
Date: Mon, 03 Mar 2003 18:20:03 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: David Lang <david.lang@digitalinsight.com>,
       Andrea Arcangeli <andrea@suse.de>
cc: Larry McVoy <lm@work.bitmover.com>, Jeff Garzik <jgarzik@pobox.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Arador <diegocg@teleline.es>,
       "Adam J. Richter" <adam@yggdrasil.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pavel@janik.cz, pavel@ucw.cz
Subject: Re: BitBucket: GPL-ed *notrademarkhere* clone
Message-ID: <592860000.1046744403@flay>
In-Reply-To: <Pine.LNX.4.44.0303031554230.29949-100000@dlang.diginsite.com>
References: <Pine.LNX.4.44.0303031554230.29949-100000@dlang.diginsite.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Just curious, this also means that at least around the 80% of merges
>> in Linus's tree is submitted via a bitkeeper pull, right?
>> 
>> Andrea
> 
> remember how Linus works, all normal patches get copied into a single
> large patch file as he reads his mail then he runs patch to apply them to
> the tree. I think this would make the entire batch of messages look like
> one cset.

I think he also creates subtrees, applies flat patches to those, then 
merges the subtrees back into his main tree as a bk-merge ... won't that 
distort the stats? 

M.

