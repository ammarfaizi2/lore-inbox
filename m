Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317560AbSGTXDa>; Sat, 20 Jul 2002 19:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317566AbSGTXDa>; Sat, 20 Jul 2002 19:03:30 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:21548 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S317560AbSGTXD3>; Sat, 20 Jul 2002 19:03:29 -0400
Date: Sat, 20 Jul 2002 17:06:32 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Andrea Arcangeli <andrea@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.19-rc2-aa1 vm blow after 1 2/3 days
Message-ID: <Pine.LNX.4.44.0207201702270.3309-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After 1 day 16 hours heaven came falling down on my i386 corner. The DHCP 
server suddenly fell into a deep sleep, all connections through were still 
working, but all connections in were dead. SysRQ worked. But since it was 
the DHCP, some of the clients followed, seemingly having DHCP requests as 
vectors.

The machine was still quite responsible to keypresses, when I pressed any 
key it appeared on the screen within 5 minutes. I did a SysRQ-E SysRQ-I, 
then things were fine, but I couldn't input (screen showed always the same 
dead console), after SysRQ-S SysRQ-U SysRQ-B all things were fine...

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

