Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132125AbQKVCqy>; Tue, 21 Nov 2000 21:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132169AbQKVCqo>; Tue, 21 Nov 2000 21:46:44 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:35594 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S132125AbQKVCqi>; Tue, 21 Nov 2000 21:46:38 -0500
Date: Tue, 21 Nov 2000 20:16:31 -0600
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jpranevich@lycos-inc.com, linux-kernel@vger.kernel.org
Subject: Re: linux-2.2.18-pre19 asm/delay.h problem?
Message-ID: <20001121201631.I2918@wire.cadcamlab.org>
In-Reply-To: <0525699E.00832462.00@SMTPNotes1.ma.lycos.com> <E13yNHb-0005O4-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E13yNHb-0005O4-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Nov 21, 2000 at 11:57:02PM +0000
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Alan Cox]
> You got it. The module is doing an overlarge delay

Perhaps people would stop asking this question if the symbol were
renamed from __bad_udelay() to, say, __use_mdelay_instead_please().

Sort of like the DNS zone (somewhere at UCLA was it?) where they had
something like 'quit 86400 IN CNAME use.exit.to.get.out.of.nslookup.'

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
