Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310255AbSCKRSn>; Mon, 11 Mar 2002 12:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310382AbSCKRRx>; Mon, 11 Mar 2002 12:17:53 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41995 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310255AbSCKRRd>; Mon, 11 Mar 2002 12:17:33 -0500
Subject: Re: [Fwd: Re: Dog slow IDE]
To: R.E.Wolff@BitWizard.nl (Rogier Wolff)
Date: Mon, 11 Mar 2002 17:32:26 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        Lionel.Bouton@inet6.fr (Lionel Bouton), linux-kernel@vger.kernel.org
In-Reply-To: <200203111714.SAA01820@cave.bitwizard.nl> from "Rogier Wolff" at Mar 11, 2002 06:14:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16kTes-0001Ad-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Bus  0, device  16, function  0:
>     PCI bridge: Advanced Micro Devices [AMD] AMD-768 [??] PCI (rev 4).
>       Master Capable.  No bursts.  Min Gnt=12.
> 
> Sounds like a PCI bridge, the machine works just fine. What's "not
> supported" about it?

The 768 chip is a bridge, and IDE controller, a USB controller (broken in
the current chip) an i810 compatible audio controller etc..

The IDE bit from memory is the "7441"
