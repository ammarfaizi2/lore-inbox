Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156589AbPIZWhi>; Sun, 26 Sep 1999 18:37:38 -0400
Received: by vger.rutgers.edu id <S156488AbPIZWfx>; Sun, 26 Sep 1999 18:35:53 -0400
Received: from lightning.swansea.uk.linux.org ([194.168.151.1]:21747 "EHLO the-village.bc.nu") by vger.rutgers.edu with ESMTP id <S156614AbPIZWec>; Sun, 26 Sep 1999 18:34:32 -0400
Subject: Re: PPPoE
To: darshu@sympatico.ca (Gary Simmons)
Date: Sun, 26 Sep 1999 23:32:23 +0100 (BST)
Cc: linux-kernel@vger.rutgers.edu
In-Reply-To: <Pine.LNX.4.10.9909261715200.2222-100000@localhost.localdomain> from "Gary Simmons" at Sep 26, 99 05:16:07 pm
Content-Type: text
Message-Id: <E11VMqH-0007Bz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-kernel@vger.rutgers.edu

> service, currently both DHCP and PPPoE work but within a month I will be
> forced to use PPPoE. They have provided a userspace PPPoE driver and have
> distributed both the binary and source thereto. The problem however is
> despite the driver working, it uses a monsterous 30% CPU usage. I recall
> hearing of an effort to develop the PPPoE kernelspace driver that was much
> faster, what is the status of this? I could provide the source to the

There is a 2.3.x driver for PPP in kernel space. It won't ever be in 2.2.x.
If you look on freshmeat you will find a GPL'd userspace PPPoE for Linux
2.0.x/2.2.x that is a lot more efficient

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
