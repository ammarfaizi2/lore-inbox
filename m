Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143392AbREKU0b>; Fri, 11 May 2001 16:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143393AbREKU0V>; Fri, 11 May 2001 16:26:21 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:39437 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S143392AbREKU0P>; Fri, 11 May 2001 16:26:15 -0400
Subject: Re: Athlon possible fixes
To: jlaako@pp.htv.fi (Jussi Laako)
Date: Fri, 11 May 2001 21:22:52 +0100 (BST)
Cc: linux-kernel@borntraeger.net (Christian =?iso-8859-1?Q?Borntr=E4ger?=),
        linux-kernel@vger.kernel.org
In-Reply-To: <3AFC46FA.D60CA20E@pp.htv.fi> from "Jussi Laako" at May 11, 2001 11:09:30 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14yJR6-0001ec-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ahmm, 2.4.3 doesn't work. Gives some IDE DMA timeouts on boot. Kernel w=
> as
> compiled with Pentium-MMX processor setting, but I don't know if that's
> enough to disable the Athlon code parts (autodetected at runtime?).

That sounds totally unrelated to any Athlon optimisations

> So only working kernel (without noautotune) on that A7V133 machine is
> RedHat's 2.4.2-2 shipped with RedHat 7.1... But that's not good either
> because the system has large reiserfs volume and 2.4.2-2 has some reise=

I wish I knew why the Red Hat one worked 8)

Alan

