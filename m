Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263478AbTLXC2M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 21:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbTLXC2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 21:28:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:42132 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263478AbTLXC2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 21:28:10 -0500
Date: Tue, 23 Dec 2003 18:28:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andres Salomon <dilinger@voxel.net>
Cc: linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org,
       jt@hpl.hp.com
Subject: Re: [PATCH 5/7] more CardServices() removals (drivers/net/wireless)
Message-Id: <20031223182817.0bd3dd3c.akpm@osdl.org>
In-Reply-To: <1072229780.5300.69.camel@spiral.internal>
References: <1072229780.5300.69.camel@spiral.internal>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andres Salomon <dilinger@voxel.net> wrote:
>
> Part 5 of 7.
> 
> 
> [005-cs_remove.patch  text/x-patch (6824 bytes)]
>  Revision: linux--mainline--2.6--patch-18
>  Archive: dilinger@voxel.net--2003-spiral
>  Creator: Andres Salomon <dilinger@voxel.net>
>  Date: Sun Dec 21 21:08:50 EST 2003
>  Standard-date: 2003-12-22 02:08:50 GMT
>  Modified-files: drivers/net/pcmcia/3c574_cs.c

hmm, 3c574_cs was done in the other patch series.

I didn't receive patch 7/7.   Was there one?

Could you please aggregate these a bit?  One single patch for each driver
subdir, say.

Thanks.
