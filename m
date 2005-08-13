Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbVHMMkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbVHMMkv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 08:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbVHMMku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 08:40:50 -0400
Received: from ns1.suse.de ([195.135.220.2]:16305 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932147AbVHMMku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 08:40:50 -0400
Date: Sat, 13 Aug 2005 14:39:56 +0200
From: Andi Kleen <ak@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, rmk@arm.linux.org.uk, ak@suse.de,
       gerg@uclinux.org, jdike@karaya.com, sammy@sammy.net,
       lethal@linux-sh.org, wli@holomorphy.com, davem@davemloft.net,
       matthew@wil.cx, geert@linux-m68k.org, paulus@samba.org,
       davej@codemonkey.org.uk, tony.luck@intel.com, dev-etrax@axis.com,
       rpurdie@rpsys.net, spyro@f2s.com, Robert Wilkens <robw@optonline.net>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Convert sigaction to act like other unices
Message-ID: <20050813123956.GN22901@wotan.suse.de>
References: <1123900802.5296.88.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123900802.5296.88.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 10:40:02PM -0400, Steven Rostedt wroqte:
> Here's a patch that converts all architectures to behave like other unix
> boxes signal handling.  It's funny that I didn't need to change the m68k
> architecture, since it was the only one that already behaves this way!
> (the m68knommu does not!)

<rest snipped which also wasn't better>

This is not a description of what you changed. A patch entry has to 
start with a rationale and then a description of the change.

-Andi
