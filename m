Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130825AbQKGXwC>; Tue, 7 Nov 2000 18:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130781AbQKGXvq>; Tue, 7 Nov 2000 18:51:46 -0500
Received: from comunit.de ([195.21.213.33]:20058 "HELO comunit.de")
	by vger.kernel.org with SMTP id <S130772AbQKGXv0>;
	Tue, 7 Nov 2000 18:51:26 -0500
Date: Wed, 8 Nov 2000 00:51:24 +0100 (CET)
From: Sven Koch <haegar@cut.de>
To: David Lang <david.lang@digitalinsight.com>
cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>, <kernel@kvack.org>,
        Martin Josefsson <gandalf@wlug.westbo.se>,
        Tigran Aivazian <tigran@veritas.com>, Anil kumar <anils_r@yahoo.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Installing kernel 2.4
In-Reply-To: <Pine.LNX.4.21.0011071606490.8417-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.4.30.0011080047260.10874-100000@space.comunit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000, David Lang wrote:

> depending on what CPU you have the kernel (and compiler) can use different
> commands/opmizations/etc, if you want to do this on boot you have two
> options.

Wouldn't it be possible to compile the parts of the kernel needed to
uncompress and to detect the cpu with lower optimizations and then abort
with an error message?

"Error: Kernel needs a PIII" sounds much better than just stoping dead.

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
