Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbVDERuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbVDERuP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 13:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbVDERto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 13:49:44 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:6274 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261858AbVDERcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 13:32:14 -0400
Message-Id: <200504051730.j35HUsSf007552@laptop11.inf.utfsm.cl>
To: Sven Luther <sven.luther@wanadoo.fr>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Humberto Massa <humberto.massa@almg.gov.br>,
       debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice. 
In-Reply-To: Message from Sven Luther <sven.luther@wanadoo.fr> 
   of "Tue, 05 Apr 2005 16:02:21 +0200." <20050405140221.GB24361@pegasos> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 05 Apr 2005 13:30:54 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 05 Apr 2005 13:30:55 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Luther <sven.luther@wanadoo.fr> said:
> On Tue, Apr 05, 2005 at 08:16:48AM -0400, Jeff Garzik wrote:
> > Humberto Massa wrote:
> > >But, the question made here was a subtler one and you are all biting 
> > >around the bush: there *are* some misrepresentations of licenses to the 
> > >firmware blobs in the kernel (-- ok, *if* you consider that hex dumps 
> > >are not source code). What Sven asked was: "Hey, can I state explicitly 
> > >the distribution state in the source files, by means of adding some 
> > >comments?".
> > 
> > >I think even a clarification "this firmware hexdump is considered to be 
> > >the source code, and it's GPL'd" would do, but I must put my asbestos 
> > >suit everytime I say it. :-)
> > 
> > We do not add comments to the kernel source code which simply state the 
> > obvious.
> 
> The only thing here is that it has to be obvious not only to you, but to the
> judge too :)
> 
> In this case, it is not comments, but proper copyright attribution, which was
> added in the tg3.c case since the first checkin :
> 
> /*
>  * tg3.c: Broadcom Tigon3 ethernet driver.
>  *
>  * Copyright (C) 2001, 2002, 2003, 2004 David S. Miller (davem@redhat.com)
>  * Copyright (C) 2001, 2002, 2003 Jeff Garzik (jgarzik@pobox.com)
>  * Copyright (C) 2004 Sun Microsystems Inc.
>  *
>  * Firmware is:
>  *      Copyright (C) 2000-2003 Broadcom Corporation.
>  */
> 
> The firmware part was not present in the original checkin you did in 2002.
> Adding something about the licencing status of it would be enough.
> 
> Or even adding some comment in the toplevel COPYING file saying that firmware
> blobs come under their own licence or something such, and then listing all the
> firmware blobs and their licencing condition in a separate toplevel file would
> be enough.
> 
> Friendly,
> 
> Sven Luther
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
