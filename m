Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKDAPC>; Fri, 3 Nov 2000 19:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129066AbQKDAOv>; Fri, 3 Nov 2000 19:14:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30226 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129033AbQKDAOf>; Fri, 3 Nov 2000 19:14:35 -0500
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Sat, 4 Nov 2000 00:14:53 +0000 (GMT)
Cc: david@linux.com (David Ford), alan@redhat.org (Alan Cox), tytso@mit.edu,
        linux-kernel@vger.kernel.org
In-Reply-To: <3A0329DA.38A90824@mandrakesoft.com> from "Jeff Garzik" at Nov 03, 2000 04:10:50 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13rqz1-00046G-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Not unless it was fixed in test10 release.  I have a PC LinkSys dual 10/100 and
> > 56K card that will kill the machine if you physically pull it out no matter what
> > cardctl/module steps are taken.
> > 
> > It uses the ne2k and serial drivers.
> 
> Part of that might be that serial doesn't support hotplug without
> patching.

Linksys rings a bell with an outstandng 2.2 lockup on pcmcia. I think this might
be a driver bug ?

> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
