Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbVBHWOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVBHWOq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 17:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVBHWOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 17:14:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52359 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261595AbVBHWOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 17:14:40 -0500
Date: Tue, 8 Feb 2005 16:41:46 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jean Tourrilhes <jt@hpl.hp.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] Wireless Extension v17 (resend)
Message-ID: <20050208184145.GD10799@logos.cnet>
References: <20050208181637.GB29717@bougret.hpl.hp.com> <20050208180116.GA10695@logos.cnet> <20050208215112.GB3290@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050208215112.GB3290@bougret.hpl.hp.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2005 at 01:51:12PM -0800, Jean Tourrilhes wrote:
> On Tue, Feb 08, 2005 at 04:01:16PM -0200, Marcelo Tosatti wrote:
> > 
> > Hi Jean,
> > 
> > I'm very ignorant about wireless but it doesnt appear to me that "Wireless Extension v17"
> > is a critical feature.
> 
> 	You are right, it's not critical, and I was already thinking
> of not pushing WE-18 to you (the WPA update). I'll stop updating 2.4.X
> with respect to wireless, the patches will be available on my web page
> for people who needs it. 

Please dont miss bugfixes for present functionality. Gracias.

> We may revisit this if there is a public
> outcry...

OK!

> > It seems more appropriate to declare it as 2.6 functionality ?
> 
> 	There need to be some unique features in 2.6.X to force people
> to upgrade, I guess...

Faster, cleaner, way more elegant, handles intense loads more gracefully, 
handles highmem decently, LSM/SELinux, etc, etc...

IMO everyone should upgrade whenever appropriate. 

