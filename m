Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWAPXYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWAPXYp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 18:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWAPXYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 18:24:45 -0500
Received: from xenotime.net ([66.160.160.81]:25808 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751282AbWAPXYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 18:24:44 -0500
Date: Mon, 16 Jan 2006 15:24:42 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Jens Axboe <axboe@suse.de>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>,
       Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, hch@infradead.org
Subject: Re: drivers/block/ps2esdi.c
In-Reply-To: <20060116232349.GX3945@suse.de>
Message-ID: <Pine.LNX.4.58.0601161524020.24990@shark.he.net>
References: <43CC0F74.9090409@linuxwireless.org> <Pine.LNX.4.58.0601161329000.24990@shark.he.net>
 <20060116232349.GX3945@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2006, Jens Axboe wrote:

> On Mon, Jan 16 2006, Randy.Dunlap wrote:
> > On Mon, 16 Jan 2006, Alejandro Bonilla Beeche wrote:
> >
> > > It looks like the Linux-2.6 tree is still broken...
> > >
> > > Just FYI
> > >
> > >
> > 	depends on MCA && MCA_LEGACY && BROKEN
> >                                         ^^^^^^
> >
> > so please send patches to fix it (the driver) if you care about it.
>
> Well this breakage is new though, Christoph looks like fallout from the
> geo stuff.

Aha.  Thanks.

-- 
~Randy
