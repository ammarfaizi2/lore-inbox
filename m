Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265543AbTAJRfC>; Fri, 10 Jan 2003 12:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbTAJRfC>; Fri, 10 Jan 2003 12:35:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53522 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265543AbTAJRfA>; Fri, 10 Jan 2003 12:35:00 -0500
Date: Fri, 10 Jan 2003 09:38:49 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jochen Friedrich <jochen@scram.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
In-Reply-To: <Pine.LNX.4.44.0301101833220.1492-100000@gfrw1044.bocc.de>
Message-ID: <Pine.LNX.4.44.0301100937190.12833-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Jan 2003, Jochen Friedrich wrote:
> 
> Full ACK. There are still archs without working module code, right now
> (parisc and mips come to my mind).

Note that other architectures have never been an issue for releasing new
kernels, and that is _particularly_ true of architectures like parisc and
mips that haven't even _tried_ to track development kernels. In fact, mips
"anti-maintenance" has often actively discouraged people from even
bothering to update mips code when adding new features.

		Linus

