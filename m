Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129232AbRBHMJg>; Thu, 8 Feb 2001 07:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129032AbRBHMJQ>; Thu, 8 Feb 2001 07:09:16 -0500
Received: from mauve.demon.co.uk ([158.152.209.66]:7955 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S130730AbRBHMJI>; Thu, 8 Feb 2001 07:09:08 -0500
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200102081208.MAA09949@mauve.demon.co.uk>
Subject: Re: PS/2 Mouse/Keyboard conflict and lockup
To: linux-kernel@vger.kernel.org
Date: Thu, 8 Feb 2001 12:08:47 +0000 (GMT)
In-Reply-To: <E14Qm1u-0002nf-00@the-village.bc.nu> from "Alan Cox" at Feb 08, 2001 08:02:12 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > I'm not sure whether this is related to the ominous ps/2 mouse bug
> > you have been chasing, but this problem is 100% reproducible and
> > very annoying.
<snip>

I'm also seeing a ps/2 mouse bug, with 2.4.0-pre5 (I think) on a 
CS433 (486/33 laptop) 
Freezes after some time in X, killing keyboard.
Is there a generic approach to finding where this sort of problem lies?
I note that there were problems in the 2.0.n era, that were fixed in
2.0.n+3 or so (I think 30), on the ct475, that were similar.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
