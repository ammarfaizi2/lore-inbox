Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbVCHGwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVCHGwx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 01:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVCHGv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 01:51:59 -0500
Received: from fire.osdl.org ([65.172.181.4]:16272 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261832AbVCHGtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 01:49:33 -0500
Date: Mon, 7 Mar 2005 22:49:26 -0800
From: Chris Wright <chrisw@osdl.org>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11-ac1
Message-ID: <20050308064926.GV28536@shell0.pdx.osdl.net>
References: <1110231261.3116.90.camel@localhost.localdomain> <B0B9168A9B666B9CF980CB7C@[192.168.12.2]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B0B9168A9B666B9CF980CB7C@[192.168.12.2]>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Clemens Schwaighofer (cs@tequila.co.jp) wrote:
> --On Monday, March 07, 2005 09:34:22 PM +0000 Alan Cox 
> <alan@lxorguk.ukuu.org.uk> wrote:
> 
> >For a couple of reasons I've not yet merged Greg's 2.6.11.1 yet but this
> >diff should actually apply to either right now.
> >
> >2.6.11-ac1
> >o	Fix jbd race in ext3				(Stephen Tweedie)
> 
> will that patch actually appear in 2.6.11.2? At least it looks like a 
> candidate for me ...

Yes, we are intending to pick up bits from -ac (you might have missed
that in another thread).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
