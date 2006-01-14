Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWANOVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWANOVR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 09:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbWANOVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 09:21:17 -0500
Received: from quechua.inka.de ([193.197.184.2]:59559 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1750860AbWANOVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 09:21:16 -0500
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: change eth0 to sn0        ?
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <BAY17-F23F48DE88AB5E02BB7AF8A97190@phx.gbl>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1ExmHK-00087S-00@calista.inka.de>
Date: Sat, 14 Jan 2006 15:21:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ratheesh k <ratheesh.ksz@hotmail.com> wrote:
> eth0      Link encap:Ethernet  HWaddr 00:11:2F:38:07:D9
>           inet addr:172.16.7.104  Bcast:172.16.7.255  Mask:255.255.252.0
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:6506 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:5120 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:1256 txqueuelen:1000
>          RX bytes:1951142 (1.8 Mb)  TX bytes:1027381 (1003.3 Kb)
>          Interrupt:23 Base address:0x3800

>     $ ifconfig eth0 down
      # nameif sn0 00:11:2F:38:07:D9

Gruss
Bernd
