Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266559AbRG0OJ4>; Fri, 27 Jul 2001 10:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267986AbRG0OJq>; Fri, 27 Jul 2001 10:09:46 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:13837 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S266559AbRG0OJ1>;
	Fri, 27 Jul 2001 10:09:27 -0400
Date: Sat, 28 Jul 2001 00:05:08 -0400
From: Anton Blanchard <anton@samba.org>
To: Alex Buell <alex.buell@tahallah.demon.co.uk>
Cc: "David S. Miller" <davem@redhat.com>,
        Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: cg14 frambuffer bug in 2.2.19 (and probably 2.4.x as well)
Message-ID: <20010728000508.A5602@krispykreme>
In-Reply-To: <Pine.LNX.4.33.0107271357550.2983-100000@tahallah.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107271357550.2983-100000@tahallah.demon.co.uk>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Hi,

> I'll test this as soon as I recompile 2.4.7 with egcs 1.1.2 to prove a
> theory of mine that using 2.95.3 results in non-bootable kernels.

Im compiling my kernels on 2.95.3 at the moment. I found one bug that
turned out to be my fault (in include/asm-sparc/bitops.h), but there
are sure to be more I havent caught yet.

Anton
