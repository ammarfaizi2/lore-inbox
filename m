Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284746AbRLUQr3>; Fri, 21 Dec 2001 11:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284751AbRLUQrT>; Fri, 21 Dec 2001 11:47:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6419 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284746AbRLUQrQ>; Fri, 21 Dec 2001 11:47:16 -0500
Subject: Re: @Linus, Marcello, (Alan?) (regards sisfb)
To: tw@webit.com (Thomas Winischhofer)
Date: Fri, 21 Dec 2001 16:56:56 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), tw@webit.com (Thomas Winischhofer),
        linux-kernel@vger.kernel.org
In-Reply-To: <3C2363F8.28E338CE@falke.mail> from "Thomas Winischhofer" at Dec 21, 2001 05:31:52 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16HSye-0000nC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I used the 2.4.16 code as basis. There have not been any patches since
> that (at least in the 2.4 series).

You have current code from SiS then yes.

> The timings are taken from the machine's BIOS. If that data is wrong, no
> driver will ever work.

Ok. You said you have one interface working, does the new driver refuse to load
for unknown chips ?

I'm not fundamentally opposed to changing the driver - the old one works on
my ancient 6326 but its icky code.

Alan
