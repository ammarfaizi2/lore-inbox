Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129741AbQLNOMX>; Thu, 14 Dec 2000 09:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129464AbQLNOMN>; Thu, 14 Dec 2000 09:12:13 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:59457 "EHLO
	amsmta02-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129741AbQLNOME>; Thu, 14 Dec 2000 09:12:04 -0500
Date: Thu, 14 Dec 2000 15:49:00 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: brian@worldcontrol.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Is this a compromise and how?
In-Reply-To: <20001214005345.A3732@top.worldcontrol.com>
Message-ID: <Pine.LNX.4.21.0012141548100.2159-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Pretty cool huh?
> 
> Let me know if you would like a copy of the code.
> 
> A quick strace shows that it binds to port 24000.
> 
> It also contains a list of 5 IP addrs.  I suspect it doesn't
> broadcast, but allows people in from those IPs.
> 
> Anyone know what has happened?  I religiously install the redhat
> updates, and am subscribed to the CERT advistors and install
> the fixes the moment I get them.
> 
> The system was RedHat 6.2, linux 2.2.17pre14 at the time the
> breakin occured.
> 
> I've been running firewalled with only services I provide turned
> on for access, and in /etc/inetd.conf.
> 
> What is keeping strlib.h from appearing ls's?  A hacked ls command?

Yep. Looks like a rootkit to me.



	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
