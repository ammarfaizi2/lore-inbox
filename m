Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267516AbUIWXRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267516AbUIWXRw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 19:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267538AbUIWXRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 19:17:25 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:3557 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267516AbUIWXEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 19:04:52 -0400
Subject: Re: ArcNet and 2.6.8.1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: "David S. Miller" <davem@davemloft.net>, yoshfuji@linux-ipv6.org,
       linux-net@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.OSF.4.05.10409232336180.21511-100000@da410.ifa.au.dk>
References: <Pine.OSF.4.05.10409232336180.21511-100000@da410.ifa.au.dk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095976927.7332.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 23 Sep 2004 23:02:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-23 at 22:46, Esben Nielsen wrote:
> ArcNet can't compete with ethernet as LAN: It can only run 10 Mbit whereas
> 100 Mbit ethernet can run roughly 50 Mbit in practice.

We can saturate 100Mbit ethernet full duplex at a steady 100Mbit, GBit
on decent boxes/cards.

> But ArcNet doesn't degrade in performance when you try to fill it up as
> ethernet does. Thus ArcNet is very good for real-time applications - and
> is used for such in the industry. But that is not an area where people
> usually use Linux.

Nod. Its fair to say you may well be "the arcnet user" by now however
8). Most real time people I've met use fieldbus nowdays for control
systems or ethernet and handshaking plus local timers


