Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVAMQoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVAMQoZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 11:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVAMQnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 11:43:19 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:27108 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261222AbVAMQkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 11:40:55 -0500
Subject: Re: thoughts on kernel security issues
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050112205717.GA12319@kroah.com>
References: <20050112094807.K24171@build.pdx.osdl.net>
	 <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>
	 <20050112185133.GA10687@kroah.com>
	 <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
	 <20050112161227.GF32024@logos.cnet>
	 <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
	 <20050112122711.S24171@build.pdx.osdl.net>
	 <20050112205717.GA12319@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105627381.4624.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 15:36:24 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Vendors should also cc: the kernel-security list/contact at the same
> time they would normally contact vendor-sec.  I don't see a problem with
> that happening, and would help out the people on vendor-sec from having
> to wade through a lot of linux kernel specific stuff at times.

vendor-sec has no control over dates or who else gets to know. We can
ask people to also notify others, we can suggest dates to people but
that is all. So if you think 7 days is sensible when reporting a hole
specify you will be making it public in 7 days.

If vendor-sec ignores a request for example that the bug doesn't go
public until date X then we just don't get told in future and we get
more 0 day crap

