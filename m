Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbUL1LbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbUL1LbS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 06:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbUL1LbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 06:31:18 -0500
Received: from em.njupt.edu.cn ([202.119.230.11]:63381 "HELO njupt.edu.cn")
	by vger.kernel.org with SMTP id S261201AbUL1LbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 06:31:16 -0500
Message-ID: <304236788.18264@njupt.edu.cn>
X-WebMAIL-MUA: [10.10.136.115]
From: "Zhenyu Wu" <y030729@njupt.edu.cn>
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org
Date: Tue, 28 Dec 2004 20:26:28 +0800
Reply-To: "Zhenyu Wu" <y030729@njupt.edu.cn>
X-Priority: 3
Subject: Re: [2.6 patch] net/rxrpc/: misc possible cleanups
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Where is the patch, the simple lines below?


>From: "David S. Miller" <davem@davemloft.net>
>Reply-To: 
>To: Adrian Bunk <bunk@stusta.de>
>Subject: Re: [2.6 patch] net/rxrpc/: misc possible cleanups
>Date:Mon, 27 Dec 2004 21:18:04 -0800
>
>On Wed, 15 Dec 2004 02:26:12 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > The patch below contains the following possible cleanups:
> > - make some needlessly global code static
> > - remove the following unused global function:
> >   - transport.c: rxrpc_clear_transport
> > - remove the following unneeded EXPORT_SYMBOL:
> >   - rxrpc_syms.c: rxrpc_call_flush
> 
> Looks good, applied.
> 
> Thanks Adrian.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


