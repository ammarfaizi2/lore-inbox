Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283002AbRLIFFg>; Sun, 9 Dec 2001 00:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283006AbRLIFFZ>; Sun, 9 Dec 2001 00:05:25 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41745 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S283002AbRLIFFO>; Sun, 9 Dec 2001 00:05:14 -0500
Date: Sat, 8 Dec 2001 20:59:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: <linux-kernel@vger.kernel.org>, <axboe@suse.de>, <pat@it.com.au>,
        <tfries@umr.edu>, <ankry@mif.pg.gda.pl>
Subject: Re: PATCH: linux-2.5.1-pre7/drivers/block/xd.c compilation fix
 (version 2)
In-Reply-To: <20011208204225.A7213@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.33.0112082057540.9037-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 8 Dec 2001, Adam J. Richter wrote:
>
> 	Linus, if nobody says otherwise, I recommend that you apply
> this patch.

Well, I already applied your previous one, in fact, and it's in the
just-uploaded pre8 kernel. Mind verifying that and sending the incremental
update?

Btw, do you actually _have_ a machine that uses the xd driver, or was this
patch done just out of some perverse joy in theoretical retrocomputing?

		Linus

