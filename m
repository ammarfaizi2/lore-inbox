Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266992AbRGMKH6>; Fri, 13 Jul 2001 06:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266994AbRGMKHs>; Fri, 13 Jul 2001 06:07:48 -0400
Received: from [213.97.45.174] ([213.97.45.174]:30220 "EHLO pau.intranet.ct")
	by vger.kernel.org with ESMTP id <S266992AbRGMKHb>;
	Fri, 13 Jul 2001 06:07:31 -0400
Date: Fri, 13 Jul 2001 12:07:17 +0200 (CEST)
From: Pau Aliagas <linux4u@wanadoo.es>
X-X-Sender: <pau@pau.intranet.ct>
To: Rik van Riel <riel@conectiva.com.br>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, "C. Slater" <cslater@wcnet.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Switching Kernels without Rebooting?
In-Reply-To: <Pine.LNX.4.33L.0107121504270.20836-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0107131204390.4531-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2001, Rik van Riel wrote:

> On Thu, 12 Jul 2001, Albert D. Cahalan wrote:
>
> > I think I see a business opportunity here.
>
> 	[snip technically risky idea]
>
> > The 24x7 places might be willing to pay somebody to do this.
>
> Unlikely. They need hardware redundancy anyway, so they'll
> just upgrade their cluster node-by-node, without doing
> risky and potentially data-corrupting things like live
> kernel upgrades.

I see business in a different way: instead of ISP or ASP you provide a
backup cluster node where you can migrate your processes before rebooting.
Everything keeps on working, no magic involved.

So we can invent the CNP (Cluster Node Provider)

Pau

