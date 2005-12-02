Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932728AbVLBLbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932728AbVLBLbr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 06:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbVLBLbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 06:31:47 -0500
Received: from ns.dynamicweb.hu ([195.228.155.139]:64953 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1750996AbVLBLbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 06:31:46 -0500
Message-ID: <011401c5f733$46a3cd60$0400a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: "Marc Koschewski" <marc@osknowledge.org>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <016c01c5f6cc$0e28e6d0$0400a8c0@dcccs> <1133481721.9597.37.camel@lade.trondhjem.org> <00f801c5f72e$df2e58c0$0400a8c0@dcccs> <20051202110805.GA7224@stiffy.osknowledge.org>
Subject: Re: 2.6.15-rc3: adduser: unable to lock password file
Date: Fri, 2 Dec 2005 12:26:34 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > OK, i will try it, if i can.... (this is a productive online system,
maybe
> > next reboot)
>
> I'd rather suggest to _not_ run -rc kernels on productive systems. :)

Thanks for the warning! :-)

I know it, already.
But have no choice. :(
The older kernels didnt know what i have needed! :-/

eg: i try the 2.6.15-rc3 because 2.6.14.2 gives me this messages:

KERNEL: assertion (!sk->sk_forward_alloc) failed at net/core/stream.c (279)
KERNEL: assertion (!sk->sk_forward_alloc) failed at net/ipv4/af_inet.c (148)
nfs: server 192.168.2.100 not responding, still trying
nfs: server 192.168.2.100 not responding, still trying
nfs: server 192.168.2.100 not responding, still trying
nfs: server 192.168.2.100 not responding, still trying
nfs: server 192.168.2.100 not responding, still trying
NETDEV WATCHDOG: eth0: transmit timed out
e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
nfs: server 192.168.2.100 OK
nfs: server 192.168.2.100 OK
nfs: server 192.168.2.100 OK
nfs: server 192.168.2.100 OK
nfs: server 192.168.2.100 OK

So, i really did not see different! :-D

Cheers,

Janos

>
> Marc

