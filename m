Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314829AbSFDQZA>; Tue, 4 Jun 2002 12:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314929AbSFDQY7>; Tue, 4 Jun 2002 12:24:59 -0400
Received: from pD9E23D09.dip.t-dialin.net ([217.226.61.9]:59046 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S314829AbSFDQYy>; Tue, 4 Jun 2002 12:24:54 -0400
Date: Tue, 4 Jun 2002 10:24:44 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Oliver Pitzeier <o.pitzeier@uptime.at>
cc: axp-kernel-list@redhat.com, "'Ivan Kokshaysky'" <ink@jurassic.park.msu.ru>,
        <linux-kernel@vger.kernel.org>
Subject: RE: kernel 2.5.20 on alpha (RE: [patch] Re: kernel 2.5.18 on alpha)
In-Reply-To: <000001c20bd1$0cad7580$010b10ac@sbp.uptime.at>
Message-ID: <Pine.LNX.4.44.0206041020070.3833-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 4 Jun 2002, Oliver Pitzeier wrote:
> Kernel bug at /usr/src/linux-2.5.20/include/linux/device.h:75
> I check what is on line 75 in device.h!

You find BUG_ON(atomic_read(&bus_refcount));

It might already be fixed by some of Irwing's patches.

> PS: Anybody want's the patches???

Sure as hell, if there are any new.

Regards,
Thunder
-- 
ship is leaving right on time	|	Thunder from the hill at ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere

