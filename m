Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287639AbRLaUbC>; Mon, 31 Dec 2001 15:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287646AbRLaUaw>; Mon, 31 Dec 2001 15:30:52 -0500
Received: from mail.cogenit.fr ([195.68.53.173]:35521 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S287639AbRLaUai>;
	Mon, 31 Dec 2001 15:30:38 -0500
Date: Mon, 31 Dec 2001 21:30:24 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Micah Anderson <micah@riseup.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.20 crashing every other day
Message-ID: <20011231213024.A22942@fafner.intra.cogenit.fr>
In-Reply-To: <20011231115217.P19151@riseup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011231115217.P19151@riseup.net>; from micah@riseup.net on Mon, Dec 31, 2001 at 11:52:17AM -0800
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Micah Anderson <micah@riseup.net> :
[data corruption]
> This is an AMD 800mhz system with 256MB RAM, every partition, except
[...]
> 00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 03)

See:
<URL:http://www.uwsg.iu.edu/hypermail/linux/kernel/0109.1/0690.html>
<URL:http://www.cs.Helsinki.fi/linux/linux-kernel/2001-48/0958.html>
<URL:http://www.cs.Helsinki.fi/linux/linux-kernel/2001-48/1113.html>

> 00:11.0 Ethernet controller: 3Com Corporation 3c900B-TPO [Etherlink XL TPO] (rev 04)
> Linux 2.2.20RAID (root@sarai) (gcc 2.95.2 20000220 ) #2 1CPU [sarai.(none)]
                                     ^^^^^^
Buggy compiler. Drop it. 

--
Ueimor
