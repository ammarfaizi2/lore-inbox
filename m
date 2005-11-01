Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbVKANkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbVKANkj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 08:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbVKANkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 08:40:39 -0500
Received: from c-65-96-98-57.hsd1.ma.comcast.net ([65.96.98.57]:39563 "EHLO
	c-65-96-98-57.hsd1.ma.comcast.net") by vger.kernel.org with ESMTP
	id S1750749AbVKANkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 08:40:39 -0500
Date: Tue, 1 Nov 2005 08:40:35 -0500
From: Glenn Maynard <glenn@zewt.org>
To: linux-usb-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: Commit "[PATCH] USB: Always do usb-handoff" breaks my powerbook
Message-ID: <20051101134035.GH17087@zewt.org>
Mail-Followup-To: linux-usb-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <17253.43605.659634.454466@cargo.ozlabs.ibm.com> <200510311741.56638.david-b@pacbell.net> <1130812903.29054.408.camel@gaston> <200510311909.32694.david-b@pacbell.net> <1130815836.29054.420.camel@gaston> <1130837294.9145.80.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130837294.9145.80.camel@localhost.localdomain>
Mail-Copies-To: nobody
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2005 at 09:28:14AM +0000, Alan Cox wrote:
> > > > It is illegal, whatever the platform is, to tap a PCI device MMIO like
> 
> Not "illegal" -> "invalid".
> 
> Please get that right as we have far too many incorrect uses of
> "illegal" in publically visible printk calls. Illegal means "prohibited
> by law".

"Illegal" means "prohibited"; not necessarily "by law", though that's the
most common use.  It's valid in other contexts, such as "prohibited by
the API".  "int *p = 1.5f" is illegal C code.  Google for "illegal chess
moves".

There may be political reasons to prefer "invalid" to "illegal", but that
doesn't make it incorrect.

-- 
Glenn Maynard
