Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263527AbTLXCsY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 21:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263528AbTLXCsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 21:48:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:24481 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263527AbTLXCsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 21:48:23 -0500
Date: Tue, 23 Dec 2003 18:48:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: dilinger@voxel.net, linux-kernel@vger.kernel.org,
       linux-pcmcia@lists.infradead.org, jt@hpl.hp.com
Subject: Re: [PATCH 5/7] more CardServices() removals (drivers/net/wireless)
Message-Id: <20031223184827.4cfb87e2.akpm@osdl.org>
In-Reply-To: <3FE8FC2E.3080701@pobox.com>
References: <1072229780.5300.69.camel@spiral.internal>
	<20031223182817.0bd3dd3c.akpm@osdl.org>
	<3FE8FC2E.3080701@pobox.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Ummm...  there are many changes to the pcmcia net drivers in my 
>  net-drivers-2.5-exp queue.

That's OK; I just want to get all these ducks lined up in one place at this
time.  As we've decided to implement this API switchover we do need to make
sure we got everything.  Or at least understand which bits are missing and
why.

>  My latest patchkits are always posted at
>  http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/

Nothing there for 2.6.0?
