Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269155AbUIHUwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269155AbUIHUwb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 16:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269151AbUIHUwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 16:52:31 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:43696 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S269133AbUIHUwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 16:52:05 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: swsusp on x86-64 w/ nforce3
Date: Wed, 8 Sep 2004 22:52:38 +0200
User-Agent: KMail/1.6.2
Cc: Tony Lindgren <tony@atomide.com>, pavel@suse.cz, Andi Kleen <ak@suse.de>
References: <200409061836.21505.rjw@sisk.pl> <200409062123.08476.rjw@sisk.pl> <20040908204249.GG8142@atomide.com>
In-Reply-To: <20040908204249.GG8142@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409082252.38350.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 of September 2004 22:42, Tony Lindgren wrote:
> * Rafael J. Wysocki <rjw@sisk.pl> [040906 12:31]:
> > On Monday 06 of September 2004 18:36, Rafael J. Wysocki wrote:
> > > Pavel,
> > > 
> > > Can you tell me, please, if swsusp, as in the 2.6.9-rc1-bk12 kernel, is 
> > > supposed to work on x86-64-based systems (specifically, with the nforce3 
> > > chipset)?
> > 
> > Anyway, on such a system (.config and the output of dmesg are attached), I 
get 
> > the following:
> > 
> > Stopping tasks: 
> > ==============================================================|
> > Freeing 
> > 
memory: ............................................................................................................|
> > Suspending devices... /critical section: counting pages to copy..[nosave 
pfn 
> > 0x59b]..................................................)
> > Alloc pagedir
> > ..[nosave pfn 
> > 
0x59b]................................................................................critical 
> > section/: done (40890 pa)
> > APIC error on CPU0: 80(08)
> > 
> 
> Just FYI, swsusp works nicely here on my m6805 laptop :)

Can you, please, send me your .config?

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
