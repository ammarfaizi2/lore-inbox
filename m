Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQKURGp>; Tue, 21 Nov 2000 12:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129208AbQKURGf>; Tue, 21 Nov 2000 12:06:35 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9290 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129431AbQKURGV>; Tue, 21 Nov 2000 12:06:21 -0500
Subject: Re: 3c527 driver won't receive packets
To: egan@sevenkings.net (Egan)
Date: Tue, 21 Nov 2000 16:36:48 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7a8l1tcv145omgpmvf02gjsk4p34djjt9f@4ax.com> from "Egan" at Nov 21, 2000 11:32:27 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13yGPZ-0004tt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The card will transmit packets, I can see them on another machine with
> tcpdump.  But it will not receive any packets.

I've had a couple of reports like this. Basically I own two MC/32 cards and
one PS/2 and it 'works for me'

> Any hints on solving the problem?

Someone sent me an improved 3c527 driver. If you want to become a tester of it
then drop me a mail off list.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
