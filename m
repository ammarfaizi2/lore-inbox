Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132745AbRDPASL>; Sun, 15 Apr 2001 20:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132813AbRDPASC>; Sun, 15 Apr 2001 20:18:02 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:52231 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132745AbRDPARq>; Sun, 15 Apr 2001 20:17:46 -0400
Subject: Re: [PATCH] NTFS comment expanded, small fix.
To: aia21@cam.ac.uk (Anton Altaparmakov)
Date: Mon, 16 Apr 2001 01:18:12 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), aia21@cus.cam.ac.uk,
        R.E.Wolff@BitWizard.nl (Rogier Wolff),
        Linus.Torvalds@Helsinki.FI (Linus Torvalds),
        linux-kernel@vger.kernel.org
In-Reply-To: <5.0.2.1.2.20010416004856.00a572a0@pop.cus.cam.ac.uk> from "Anton Altaparmakov" at Apr 16, 2001 12:52:50 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14owib-0007gL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you have the diffs ready then it would be great if you could do that. 
> (Did the maxbytes stuff enter the mainstream kernel yet? Are you going to 
> feed them together? Or will that be dropped for now?)

maxbytes got to Linus. The checks using it are not all there, but maxbytes
went in early to avoid fs differences being hard to maintain. I've fed him
bits of the fs checking this time. There is some negotiation to be done over
truncate yet
