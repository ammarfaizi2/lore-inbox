Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130339AbQKUOMm>; Tue, 21 Nov 2000 09:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130463AbQKUOMd>; Tue, 21 Nov 2000 09:12:33 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:521 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130339AbQKUOMR>; Tue, 21 Nov 2000 09:12:17 -0500
Date: Tue, 21 Nov 2000 07:42:10 -0600
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Tobias Ringstrom <tori@tellus.mine.nu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] dmfe.c network driver update for 2.4
Message-ID: <20001121074210.G2918@wire.cadcamlab.org>
In-Reply-To: <Pine.LNX.4.21.0011162241450.23936-100000@svea.tellus> <3A145806.FF5F0066@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A145806.FF5F0066@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Nov 16, 2000 at 04:56:22PM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Jeff Garzik]
> Pretty much all ISA and PCI drivers need to be portable and SMP
> safe...  if not so, it's a bug.  That said, there is certainly more
> motivation to make a popular PCI driver is SMP safe than an older ISA
> driver.

Usually, but you never know...

  "o       SMP optimised 3c501"
		-- 2.1.132ac2 changelog

(:

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
