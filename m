Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265962AbUAFXL4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 18:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266074AbUAFXL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 18:11:56 -0500
Received: from [193.138.115.2] ([193.138.115.2]:3592 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S265962AbUAFXKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 18:10:09 -0500
Date: Wed, 7 Jan 2004 00:07:12 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: James Simmons <jsimmons@infradead.org>
cc: Paul Misner <paul@misner.org>, linux-kernel@vger.kernel.org
Subject: Re: Blank Screen in 2.6.0
In-Reply-To: <Pine.LNX.4.44.0401062301380.21143-100000@phoenix.infradead.org>
Message-ID: <Pine.LNX.4.56.0401070003130.8384@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.44.0401062301380.21143-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Jan 2004, James Simmons wrote:

>
> > I've found that using "rivafb" does not work with my Geforce3, and from
> > talking to various people on IRC about it I get the impression that rivafb
> > is broken for any card newer than Geforce2. "vesafb" though works quite
> > well with never NVidia cards.
>
> The core code to the rivafb is lifted from a older X windows driver. I
> would need to grab the latest X server code which is very different.
>

Ok, thank you for the explanation.


> > If I build my kernels with "rivafb" enabled I get a blank screen as well,
> > but using "vesafb" all is fine (so is just plain vga=normal or
> > vga=extended, but I prefer the fb console :)
>
> Fixed in my latest patches.
>

Great, as soon as those make it into Linus' tree or -mm I'll give them a
test run. Or if you could point me at a location where I can grab them
from I'd be happy to test them even sooner.


/Jesper Juhl


