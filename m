Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbUAGX6y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 18:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266325AbUAGX6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 18:58:54 -0500
Received: from [193.138.115.2] ([193.138.115.2]:11275 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S266304AbUAGX6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 18:58:30 -0500
Date: Thu, 8 Jan 2004 00:55:26 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: James Simmons <jsimmons@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Blank Screen in 2.6.0
In-Reply-To: <Pine.LNX.4.44.0401071741570.31020-100000@phoenix.infradead.org>
Message-ID: <Pine.LNX.4.56.0401080052170.9700@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.44.0401071741570.31020-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 Jan 2004, James Simmons wrote:

> Yeah!!!
>
> > The bad news is that it still doesn't work quite right.
>
> I expected that. Newer Nvidia cards are not properly supported.
>

Ok, just know that I'm willing to test any patches you may have for rivafb.


> > Also, after starting X (using the "nv" driver, not a fb X server) - if I
> > switch back to a text console then the screen is completely garbled - I
> > can switch back to X just fine though.
>
> Try using the UseFBDev flag for teh X server. That usually helps.
>

Ok, I'll try that "soonish" and report the result.
For now I'm simply using vesafb which works well.


-- Jesper Juhl

