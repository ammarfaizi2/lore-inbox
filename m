Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130128AbRAQXYm>; Wed, 17 Jan 2001 18:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129847AbRAQXYc>; Wed, 17 Jan 2001 18:24:32 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:21770 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129991AbRAQXYW>; Wed, 17 Jan 2001 18:24:22 -0500
Date: Wed, 17 Jan 2001 18:25:12 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: eth1: Transmit timed out, status 0000, PHY status 0000 (fwd)
Message-ID: <Pine.LNX.4.31.0101171822520.859-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

I've forwarded it for you, however you likely didn't realize hat
lkml is an "open" mailing list, ie: you don't need to be a
subscriber to post.  This is so that non-members can file bug
reports, and send spam, etc..  ;o)

Take care.



----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

---------- Forwarded message ----------
Date: Wed, 17 Jan 2001 10:46:54 +0100
From: Ph. Marek <marek@mail.bmlv.gv.at>
To: mharris@opensourceadvocate.org
Content-Type: text/plain; charset="us-ascii"
Subject: Re: eth1: Transmit timed out, status 0000, PHY status 0000

Hi Mike!

I'm not on lkml but I follow the discussions from time to time and saw your
mail.
(as I'm not subscribed, please forward this to lkml)


I've had the same problem using DLink 530 using 10baseT. DOS-diagnostic
said "No connection". Even trying to say
	modprobe tulip options=1
(use 10baseT) didn't work.


Then I got a crossed 10base2 cable and - IT WORKED (for me) without any
problems, though I said option=4 (10base2, full duplex).


Hope this helps!


Regards,

Phil


"A Firewall is really much like a sophisticated traffic cop; it detects and
stops unauthorized or suspicious movement in or out of the network. But
security is more than a Firewall; it's a process. You can't just put in a
Firewall and think you're secure."

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
