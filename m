Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281824AbRK1Afd>; Tue, 27 Nov 2001 19:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281833AbRK1AfT>; Tue, 27 Nov 2001 19:35:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24075 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281824AbRK1AfG>; Tue, 27 Nov 2001 19:35:06 -0500
Date: Tue, 27 Nov 2001 16:29:17 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.1-pre2 does not compile
In-Reply-To: <200111272209.fARM9tk18991@ns.caldera.de>
Message-ID: <Pine.LNX.4.33.0111271628430.1629-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Nov 2001, Christoph Hellwig wrote:
>
> While we are at breaking scsi, would you take a patch to remove the
> old-style (2.0) scsi error handling completly, forcing drivers still
> using it to be fixed?  Early 2.5 looks like a good time for that to me..

I agree, that sounds like a good thing, and as I consider the block layer
to be one of the major pushes for 2.5.x it makes perfect sense.

		Linus

