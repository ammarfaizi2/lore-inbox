Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318316AbSGRTvJ>; Thu, 18 Jul 2002 15:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318318AbSGRTvJ>; Thu, 18 Jul 2002 15:51:09 -0400
Received: from [207.251.72.21] ([207.251.72.21]:44814 "EHLO
	s-ny-exchconn01.island.com") by vger.kernel.org with ESMTP
	id <S318316AbSGRTvI>; Thu, 18 Jul 2002 15:51:08 -0400
Message-ID: <628900C9F8A7D51188E000A0C9F3FDFA024FF095@S-NY-EXCH01>
From: Robert Sinko <RSinko@island.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Wrong CPU count 
Date: Thu, 18 Jul 2002 15:52:51 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After upgrading  from kernel 2.4.7-10smp to 2.4.9-34smp using the Red Hat
RPM downloaded from RH Network, the CPU count on the machine reported by
dmesg and listed in /proc/cpuinfo was 4 rather than the actual 2.

This has occured on all 4 Dell 2650's that I've installed this patch on.  I
don't have any other mult-processor machines available to test this with.

Things seem to run OK, but this is a bit ominous.  Has anyone seem this
problem with this or other PC Models?

Thanks,
Bob


DISCLAIMER: The information contained herein is confidential and is intended
solely for the addressee(s). It shall not be construed as a recommendation
to buy or sell any security. Any unauthorized access, use, reproduction,
disclosure or dissemination is prohibited. Neither ISLAND nor any of its
subsidiaries or affiliates shall assume any legal liability or
responsibility for any incorrect, misleading or altered information
contained herein. Thank you.


