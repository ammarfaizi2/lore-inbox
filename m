Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVAMWhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVAMWhD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVAMWd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:33:56 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:51685 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261795AbVAMWa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 17:30:29 -0500
Subject: Re: thoughts on kernel security issues
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Jones <davej@redhat.com>, Marek Habersack <grendel@caudium.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501131255590.2310@ppc970.osdl.org>
References: <20050112094807.K24171@build.pdx.osdl.net>
	 <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>
	 <20050112185133.GA10687@kroah.com>
	 <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
	 <20050112161227.GF32024@logos.cnet>
	 <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
	 <20050112174203.GA691@logos.cnet>
	 <1105627541.4624.24.camel@localhost.localdomain>
	 <20050113194246.GC24970@beowulf.thanes.org>
	 <20050113200308.GC3555@redhat.com>
	 <Pine.LNX.4.58.0501131206340.2310@ppc970.osdl.org>
	 <1105644461.4644.102.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0501131255590.2310@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105651504.4624.150.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 21:25:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-13 at 21:03, Linus Torvalds wrote:
> On Thu, 13 Jan 2005, Alan Cox wrote:
>  - no embargo, no rules, but "private" in the sense that it's supposed to 
>    be for kernel developers only or at least people who won't take 
>    advantage of it.
> 
>    _I_ think this is the one that makes sense. No hard rules, but private 
>    enough that people won't feel _guilty_ about reporting problems. Right 
>    now I sometimes get private email from people who don't want to point
>    out some local DoS or similar, and that can certainly get lost in the
>    flow.

And also not passed on to vendors and other folks which is a pita and
this would fix
> 
>  - _short_ embargo, for kernel-only. I obviously believe that vendor-sec 
>    is whoring itself for security firms and vendors. I believe there would 
>    be a place for something with stricter rules on disclosure.

Seems these two could be the same list with a bit of respect for users
wishes and common sense.

> It's not a black-and-white thing. I refuse to believe that most security 
> problems are found by people without any morals. I believe that somewhere 
> in the middle is where most people feel most comfortable.

Seems sane

