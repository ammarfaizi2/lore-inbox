Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284500AbRLRShe>; Tue, 18 Dec 2001 13:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284484AbRLRSg4>; Tue, 18 Dec 2001 13:36:56 -0500
Received: from m851-mp1-cvx1c.edi.ntl.com ([62.253.15.83]:20206 "EHLO
	pinkpanther.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S284497AbRLRSgp>; Tue, 18 Dec 2001 13:36:45 -0500
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200112181550.fBIFoc316453@pinkpanther.swansea.linux.org.uk>
Subject: Re: CONFIG_SOUND_DMAP: Confusing Configure.help entry.
To: crimsun@email.unc.edu (Daniel T. Chen)
Date: Tue, 18 Dec 2001 15:50:38 +0000 (GMT)
Cc: nkbj@image.dk (Niels Kristian Bech Jensen),
        linux-kernel@vger.kernel.org (Linux kernel developer's mailing list)
In-Reply-To: <Pine.A41.4.21L1.0112152149430.11590-100000@login3.isis.unc.edu> from "Daniel T. Chen" at Dec 15, 2001 09:53:40 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The final line should probably be clarified to read: "Say Y if you have
> 16MB or more RAM and an ISA soundcard but N if you have a PCI sound
> card."

Unrelated to PCI cards (some of which has ISA limits)

> > should be enabled unless you have more the 16MB of RAM (or a PCI sound 

s/unless/if


