Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278902AbRKFJ7O>; Tue, 6 Nov 2001 04:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278890AbRKFJ7E>; Tue, 6 Nov 2001 04:59:04 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:64947 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278722AbRKFJ6x>;
	Tue, 6 Nov 2001 04:58:53 -0500
Date: Tue, 6 Nov 2001 04:58:51 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Wojtek Pilorz <wpilorz@bdk.pl>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] disk throughput
In-Reply-To: <Pine.LNX.4.21.0111061000060.16977-100000@celebris.bdk.pl>
Message-ID: <Pine.GSO.4.21.0111060450290.27713-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Nov 2001, Wojtek Pilorz wrote:

> Would it be possible and a good idea to add such 'vector' operations to
> the Linux kernel?

Occam's Razor and all such.  Plus portability problems.

Besides, you get enough information from getdents() if you really want
to play silly games with that.

