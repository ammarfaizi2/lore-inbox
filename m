Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263269AbRFGVpc>; Thu, 7 Jun 2001 17:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263284AbRFGVpW>; Thu, 7 Jun 2001 17:45:22 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:48523 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S263269AbRFGVpN>; Thu, 7 Jun 2001 17:45:13 -0400
Date: Thu, 7 Jun 2001 15:44:57 -0600
Message-Id: <200106072144.f57LivR32508@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Keitaro Yosimura <ramsy@linux.or.jp>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help i18n system
In-Reply-To: <Pine.LNX.4.21.0106071351300.6604-100000@penguin.transmeta.com>
In-Reply-To: <20010607165007.A299.RAMSY@linux.or.jp>
	<Pine.LNX.4.21.0106071351300.6604-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
> Configure.help certainly isn't all that kernel version dependent,
> and could successfully be maintained completely outside the kernel,
> I suspect.

It might not change much, but it can from time to time. The meaning of
a particular option can evolve over time. I wouldn't want to see
options have sections like "for kernel x.y.z the behaviour is this,
but for kernel a.b.c the behaviour is thus". It's just clutter.

Another issue is ease of use. I just want to be able to download a
single tarball, and then be able to go offline and configure, compile,
read docs and so on. One example of this is when setting up a new
box. Another is when I'm on the road, dial in and download a new patch
and then hop on a plane and start playing with it.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
