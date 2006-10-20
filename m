Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992705AbWJTSyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992705AbWJTSyR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 14:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992707AbWJTSyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 14:54:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41915 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992705AbWJTSyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 14:54:16 -0400
Date: Fri, 20 Oct 2006 11:50:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [0/3] 2.6.19-rc2: known regressions
In-Reply-To: <20061020183159.GB8894@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0610201149340.3962@g5.osdl.org>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
 <20061014111458.GI30596@stusta.de> <20061015122453.GA12549@flint.arm.linux.org.uk>
 <20061015124210.GX30596@stusta.de> <20061019081753.GA29883@flint.arm.linux.org.uk>
 <20061020180722.GA8894@flint.arm.linux.org.uk> <20061020111900.30d3cb03.akpm@osdl.org>
 <20061020183159.GB8894@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Oct 2006, Russell King wrote:
> 
> Ah, okay.  Must not have poped out of the other side of Linus by 6am GMT
> then. 

Yeah, I applied Andrew's patch-bomb just an hour or two ago.

> (We also seem to have non-working git snapshots again, so when I
> looked at the ARM kautobuild it showed the same old errors.)

Gaah. Remind me where the autobuild is again..

		Linus
