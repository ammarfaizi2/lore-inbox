Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVCHWlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVCHWlr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 17:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVCHWlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 17:41:46 -0500
Received: from fire.osdl.org ([65.172.181.4]:24261 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261575AbVCHWlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 17:41:17 -0500
Date: Tue, 8 Mar 2005 14:41:05 -0800
From: Chris Wright <chrisw@osdl.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, chrisw@osdl.org,
       torvalds@osdl.org
Subject: Re: Linux 2.6.11.1
Message-ID: <20050308224105.GV5389@shell0.pdx.osdl.net>
References: <4228D43E.1040903@pobox.com> <422E2223.5060906@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422E2223.5060906@tmr.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Bill Davidsen (davidsen@tmr.com) wrote:
> Jeff Garzik wrote:
> >>nfsd--svcrpc-add-a-per-flavor-set_client-method.patch
> >
> >is this critical?
> 
> Wasn't part of the Linus proposal that it had to fix an oops or 
> non-functional feature?

We're working on the criteria, should have some updates posted soon.
One important piece is fixing a critical bug or seriously damaged
feature, and another piece is subsystem maintainer signoff/advocacy.
At first pass, this particular patch certainly does not look critical.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
