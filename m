Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVAMUix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVAMUix (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 15:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVAMUf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 15:35:27 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:23269 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261469AbVAMUdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 15:33:14 -0500
Subject: Re: thoughts on kernel security issues
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dave Jones <davej@redhat.com>, Marek Habersack <grendel@caudium.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501131206340.2310@ppc970.osdl.org>
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
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105644461.4644.102.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 19:27:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-13 at 20:10, Linus Torvalds wrote:
> In fact, right now we seem to encourage even people who do _not_
> necessarily want the delay and secrecy to go over to vendor-sec, just
> because the vendor-sec people are clearly arguing even against
> alternatives.

 If someone posts something to vendor-sec that says "please tell Linus"
we would. If someone posts to vendor-sec saying "I posted this to
linux-kernel here's a heads up" its useful. If you are uber cool elite 0
day disclosure weenie you post to full-disclosure or bugtraq. There are
alternatives 8)

> Which is something I do not understand. The _apologia_ for vendor-sec is 
> absolutely stunning. Even if there are people who want to only interface 
> with a fascist vendor-sec-style absolute secrecy list, THAT IS NOT AN 
> EXCUSE TO NOT HAVE OPEN LISTS IN _ADDITION_!

I'm all for an open list too. Its currently called linux-kernel. Its
full of such reports, and most of them are about new code or trivial
holes where secrecy is pointless. Having an open linux-security list so
they don't get missed as the grsecurity stuff did (and until I got fed
up of waiting the coverity stuff did) would help because it would make
sure that it didn't get buried in the noise.

Similarly it would help if you are sneaking security fixes in (as you do
regularly) you actually told the vendors about them.

Alan

