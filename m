Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285616AbRLRGNl>; Tue, 18 Dec 2001 01:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285617AbRLRGNf>; Tue, 18 Dec 2001 01:13:35 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3342 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285616AbRLRGNT>; Tue, 18 Dec 2001 01:13:19 -0500
Date: Mon, 17 Dec 2001 22:12:21 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Troy Benjegerdes <hozer@drgw.net>
cc: Andre Hedrick <andre@linux-ide.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Domian Validation (Re: 2.5.1 - intermediate bio stuff..)
In-Reply-To: <20011218000432.C25200@altus.drgw.net>
Message-ID: <Pine.LNX.4.33.0112172210470.2416-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Dec 2001, Troy Benjegerdes wrote:
>
> Translation: Andre has been in a few too many ATA meetings and can't think
> without using storage industry insider-speak ;)

We know ;)

> I only had a 6 months internship in storage, but I believe what he's
> talking about are sound engineering principles.

No. Sound software engineering principles is to design good interfaces,
and make the low level code adhere to them.

Andre comes from the other end - he writes and talks about low-level code,
and thinks that should drive how upper layers work.

			Linus

