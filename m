Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130177AbQLDXxS>; Mon, 4 Dec 2000 18:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130498AbQLDXxI>; Mon, 4 Dec 2000 18:53:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63586 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130177AbQLDXxF>; Mon, 4 Dec 2000 18:53:05 -0500
Subject: Re: 2.4.0-test12-pre4 + cs46xx + KDE 2.0 = frozen system
To: scole@lanl.gov
Date: Mon, 4 Dec 2000 23:22:46 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <00120414271000.01254@spc.esa.lanl.gov> from "Steven Cole" at Dec 04, 2000 02:27:10 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1434wZ-0004Tn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Crystal 4280/461x + AC97 Audio, version 0.14, 13:39:25 Dec  4 2000
> cs461x: Card found at 0xf8ffe000 and 0xf8e00000, IRQ 18
> cs461x: Unknown card (FFFFFFFF:FFFFFFFF) at 0xf8ffe000/0xf8e00000, IRQ 18
> ac97_codec: AC97 Audio codec, id: 0x4352:0x5914 (Unknown)

This is failing to detect the CS46xx. I assume someone has fiddled with the
driver. Does it work correctly on your machine in 2.2.18pre24 ?


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
