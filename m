Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281075AbRKLWgx>; Mon, 12 Nov 2001 17:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281094AbRKLWgp>; Mon, 12 Nov 2001 17:36:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51730 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281079AbRKLWgg>; Mon, 12 Nov 2001 17:36:36 -0500
Subject: Re: [PATCH] VIA timer fix was removed?
To: neale@lowendale.com.au (Neale Banks)
Date: Mon, 12 Nov 2001 22:43:02 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        pellegrini@mpcnet.com.br (Jeronimo Pellegrini),
        nils@wombat.dialup.fht-esslingen.de (Nils Philippsen), vojtech@suse.cz,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.05.10111130849030.3768-100000@marina.lowendale.com.au> from "Neale Banks" at Nov 13, 2001 08:59:04 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163PnC-0007Oi-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Meanwhile, for those of us that have either suspected or confirmed
> problems with the VIA686a workaround (<sigh> possibly due to entirely
> different hardware/BIOS bugs? </sigh>), a method of nobbling the VIA686a
> fix at compile or boot time could be somewhat useful?  Mmm... boot-time is
> probably best as it allows easiet experimentation?

No need - the workaround is 100% harmless if misapplied

