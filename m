Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266806AbSLPQ6R>; Mon, 16 Dec 2002 11:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266810AbSLPQ6R>; Mon, 16 Dec 2002 11:58:17 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2825 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266806AbSLPQ6R>; Mon, 16 Dec 2002 11:58:17 -0500
Date: Mon, 16 Dec 2002 09:07:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 1/19
In-Reply-To: <20021216100608.GB7407@reti>
Message-ID: <Pine.LNX.4.44.0212160905190.2799-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for doing the split, great work.

For future reference, it would help if the subject line also had a short
description, something more like

	Subject: [PATCH 1/19] dm: move ioctl numbers to sane place

but that's just a small technical detail and I'll make up my own "short
description" based on your longer in-email ones.

		Linus

