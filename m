Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265058AbUE0TOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265058AbUE0TOp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 15:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265075AbUE0TOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 15:14:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:28626 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265058AbUE0TOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 15:14:41 -0400
Date: Tue, 25 May 2004 21:12:43 +0200
From: Pavel Machek <pavel@suse.cz>
To: William Lee Irwin III <wli@holomorphy.com>,
       "Cef (LKML)" <cef-lkml@optusnet.com.au>, linux-kernel@vger.kernel.org,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [announce/OT] kerneltop ver. 0.7
Message-ID: <20040525191243.GL5215@openzaurus.ucw.cz>
References: <20040523215027.5dc99711.rddunlap@osdl.org> <200405241553.44114.cef-lkml@optusnet.com.au> <20040524060007.GN1833@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040524060007.GN1833@holomorphy.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Please try the patch I just posted which eliminates the need to be root.
> 

Non-root is allowed to profile kernel?

That allows it to get some knowledge what other processes are doing.
Potential security hole?

Okay, when wchan is publicly visible in /proc this is probably
not too big deal.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

