Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129810AbRANBCw>; Sat, 13 Jan 2001 20:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129998AbRANBCc>; Sat, 13 Jan 2001 20:02:32 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:52497 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129810AbRANBC2>; Sat, 13 Jan 2001 20:02:28 -0500
Date: Sat, 13 Jan 2001 20:03:25 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Shawn Starr <Shawn.Starr@Home.net>
cc: Donald Becker <becker@scyld.com>, <vortex@scyld.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PROBLEM]: Strange network problems with 2.4.0 and 3c59x.o
In-Reply-To: <3A5F791F.BCC236C1@Home.net>
Message-ID: <Pine.LNX.4.31.0101132002310.9731-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2001, Shawn Starr wrote:

Snoop through /proc, and you'll find a file where you can disable
"ecn" support.

echo 0 > /proc....



>Date: Fri, 12 Jan 2001 16:37:35 -0500
>From: Shawn Starr <Shawn.Starr@Home.net>
>To: Donald Becker <becker@scyld.com>, vortex@scyld.com,
>     linux-kernel@vger.kernel.org
>Content-Type: text/plain; charset=iso-8859-15
>Subject: [PROBLEM]: Strange network problems with 2.4.0 and 3c59x.o
>
>Here's something strange that i've been noticing with 2.4.0. Some websites I am
>unable to access now. For example:
>
>http://www.scotiabank.ca/simplify/index.html
>
>if your in Canada and you have Scotia banking online, try and access their
>banking sites. It will just hang. However upon trying the same in Windows 2000
>(cough). The site works fine.
>
>Could there be a network driver issue as even trying with telnet port 80 fails
>as well?
>
>Im not sure on this one this seems bizarre. I have the same problem with
>www.workopolis.com, theglobeandmail.com, perhaps there's some sort of packet or
>frame not being processed properly?
>
>I can ICMP ping all the sites fine and i can access them from other shells.
>I have spoken to some of their engineers and they say that there is nothing
>blocking/no firewalls configured to deny access to theses sites.
>
>If there's any information you need I'd be glad to try and figure this one out.
>
>Shawn S.
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>Please read the FAQ at http://www.tux.org/lkml/
>



----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

VMS is a text-only adventure game. If you win you can use unix.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
