Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289724AbSAJWYj>; Thu, 10 Jan 2002 17:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289738AbSAJWY3>; Thu, 10 Jan 2002 17:24:29 -0500
Received: from azvale.lnk.telstra.net ([139.130.147.152]:54024 "EHLO
	portal.dffa.com.au") by vger.kernel.org with ESMTP
	id <S289724AbSAJWYS>; Thu, 10 Jan 2002 17:24:18 -0500
Date: Fri, 11 Jan 2002 06:21:25 +0800 (WST)
From: David C P Gray <davidg@enet.com.au>
To: <linux-kernel@vger.kernel.org>
Subject: Re: eth0: entered promiscuous mode
In-Reply-To: <E16Omo1-000099-00@sites.inka.de>
Message-ID: <Pine.LNX.4.33.0201110614520.2227-100000@iago.enet.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Jan 2002, Bernd Eckenfels wrote:

> In article <20020110205946.GB24838@zhadum.bjavor.d2g.com> you wrote:
> > Can somebody please tell me what the above message means?
>
> it means you run a root program which requested the network card to go into
> promic mode. promisc mode means, the card will receive all packets on the
> wire, not only those destinated to the card. a few sniffing/scan
> detector/accounting apps require this, and some legal apps for network
> configuration (like dhcp/bootp/... ) and arpwatch may require it.

VMware can also trigger this message. It uses promiscuous mode to
provide access to the LAN for guest OS sessions.

Cheers,
David.



