Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129807AbQK3QhH>; Thu, 30 Nov 2000 11:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129539AbQK3Qg4>; Thu, 30 Nov 2000 11:36:56 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54546 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S129707AbQK3Qgh>; Thu, 30 Nov 2000 11:36:37 -0500
Subject: Re: TCP header bits set in reserved space
To: mes@capelazo.com (Mark Sutton)
Date: Thu, 30 Nov 2000 16:05:54 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.10.10011292033380.27791-100000@lazo.capelazo.com> from "Mark Sutton" at Nov 29, 2000 08:53:32 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E141WDc-0007R9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	I can't seem to find this mentioned anywhere. My 2.4 machine
> sets 2 bits in the TCP header between the 4 data offset bits and control 
> flags. Like so:

ECN

> can see from one that is are these two bits. RFC793 says they must be zero.
> Is 793 still current? Has anyone else seen this?

793 is still current but remember bits of it are superceded by a couple of 
thousand other documents.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
