Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbVLEVkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbVLEVkm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 16:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbVLEVkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 16:40:42 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:6297 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964806AbVLEVkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 16:40:41 -0500
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: Lee Revell <rlrevell@joe-job.com>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <87u0dn5k6m.fsf@mid.deneb.enyo.de>
References: <20051203135608.GJ31395@stusta.de>
	 <1133620264.2171.14.camel@localhost.localdomain>
	 <20051203193538.GM31395@stusta.de> <1133639835.16836.24.camel@mindpipe>
	 <20051203225815.GH25722@merlin.emma.line.org>
	 <1133653782.19768.1.camel@mindpipe>  <87u0dn5k6m.fsf@mid.deneb.enyo.de>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 16:41:16 -0500
Message-Id: <1133818877.21641.92.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-05 at 22:05 +0100, Florian Weimer wrote:
> * Lee Revell:
> 
> >> The point that just escaped you as the motivation for this thread was
> >> the availability of security (or other critical) fixes for older
> >> kernels. It would all be fine if, say, the fix for CVE-2004-2492 were
> >> available for those who find 2.6.8 works for them (the fix went into
> >> 2.6.14 BTW), and the concern is the development model isn't fit to
> >> accomodate needs like this.
> >> 
> >
> > If you want security fixes backported then you can get a distro kernel.
> 
> And these distro kernels appear magically from nowhere?
> 

No you get them from Red Hat or SuSE or whoever.  One of the core
assumptions of the new development model is that distros whose business
model involves paying people to do QA and regression testing and have
access to bug reports from zillions of users are better positioned than
kernel developers to decide what a "stable" kernel is.

Lee

