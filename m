Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266132AbRGGMGy>; Sat, 7 Jul 2001 08:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266133AbRGGMGp>; Sat, 7 Jul 2001 08:06:45 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61705 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266132AbRGGMG3>; Sat, 7 Jul 2001 08:06:29 -0400
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit m
To: davem@redhat.com (David S. Miller)
Date: Sat, 7 Jul 2001 13:06:16 +0100 (BST)
Cc: bcrl@redhat.com (Ben LaHaise), jes@sunsite.dk (Jes Sorensen),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        hiren_mehta@agilent.com ("MEHTA,HIREN (A-SanJose,ex1)"),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <15174.40867.89472.953231@pizda.ninka.net> from "David S. Miller" at Jul 06, 2001 10:35:31 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Iqqm-0005jr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > that the expected lifespan for 32 bit systems is now less than 3 years, so
>  > elaborate planning that delays implementation buys us nothing more than a
>  > smaller window of usefulness.
> Maybe by then only 64-bit cpus will matter.  Who knows.

Reality check.

Embedded PCI 32bit processors are going to be very common
People are only now retiring 486's

So add another seven or eight years to your estimate
