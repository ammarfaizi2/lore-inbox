Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVAKSMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVAKSMa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 13:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVAKSMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 13:12:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:62928 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261328AbVAKR50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 12:57:26 -0500
Date: Tue, 11 Jan 2005 09:57:24 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Chris Wright <chrisw@osdl.org>, Steve Bergman <steve@rueb.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Proper procedure for reporting possible security vulnerabilities?
Message-ID: <20050111095724.D10567@build.pdx.osdl.net>
References: <41E2B181.3060009@rueb.com> <87d5wdhsxo.fsf@deneb.enyo.de> <41E2F6B3.9060008@rueb.com> <Pine.LNX.4.61.0501102309270.2987@dragon.hygekrogen.localhost> <20050110164001.Q469@build.pdx.osdl.net> <Pine.LNX.4.61.0501111758290.3368@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.61.0501111758290.3368@dragon.hygekrogen.localhost>; from juhl-lkml@dif.dk on Tue, Jan 11, 2005 at 06:05:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jesper Juhl (juhl-lkml@dif.dk) wrote:
> On Mon, 10 Jan 2005, Chris Wright wrote:
> > Problem is, the rest of the world uses a security contact for reporting
> > security sensitive bugs to project maintainers and coordinating
> > disclosures.  I think it would be good for the kernel to do that as well.
> > 
> Problem is that the info can then get stuck at a vendor or maintainer 
> outside of public view and risk being mothballed. It also limits the 
> number of people who can work on a solution (including peole getting to 
> work on auditing other code for similar issues). It also prevents admins 
> from taking alternative precautions prior to availability of a fix (you 
> have to assume the bad guys already know of the bug, not just the good 
> guys).

That's not quite the case.  The point of having a security contact is to
help coordinate timely public disclosure, not to sit on and mothball
info.  In most projects it turns out to be helpful.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
