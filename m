Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268127AbTAKTZR>; Sat, 11 Jan 2003 14:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268129AbTAKTZR>; Sat, 11 Jan 2003 14:25:17 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60424 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268127AbTAKTZQ>; Sat, 11 Jan 2003 14:25:16 -0500
Date: Sat, 11 Jan 2003 11:29:14 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Ulrich Drepper <drepper@redhat.com>, <davidm@hpl.hp.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: make AT_SYSINFO platform-independent
In-Reply-To: <20030111185744.A5009@infradead.org>
Message-ID: <Pine.LNX.4.44.0301111128150.25432-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 11 Jan 2003, Christoph Hellwig wrote:
> 
> -EWHATSUP

Ehh, Uli is a bit sensitive, and thinks everybody blames him for 
everything. I told him the AT_SYSINFO interface is stable, so he wants to 
make it clear that _I_ am the one to blame, not him.

Anyway, as I said in another mail, I think 18 is a bad choice, and I'll 
leave it at 32.

		Linus

