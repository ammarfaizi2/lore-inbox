Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279228AbRKIJ1g>; Fri, 9 Nov 2001 04:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279684AbRKIJ11>; Fri, 9 Nov 2001 04:27:27 -0500
Received: from [194.213.32.133] ([194.213.32.133]:30337 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S279228AbRKIJ1M>;
	Fri, 9 Nov 2001 04:27:12 -0500
Date: Thu, 8 Nov 2001 12:51:59 +0000
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] disk throughput
Message-ID: <20011108125159.A74@toy.ucw.cz>
In-Reply-To: <Pine.GSO.4.21.0111051811150.27086-100000@weyl.math.psu.edu> <Pine.LNX.4.33.0111051543440.15533-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33.0111051543440.15533-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Nov 05, 2001 at 03:50:38PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> By definition, "slow growth" is amenable to defragmentation. And by
> definition, fast growth isn't. And if we're talking about speedups on the

Heh, last time I looked, defrage2fs crashed on >2G partition and was 
clearly not maintained. Has things changed?

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

