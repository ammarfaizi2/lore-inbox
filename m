Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318691AbSHQNDK>; Sat, 17 Aug 2002 09:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318693AbSHQNDJ>; Sat, 17 Aug 2002 09:03:09 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:27090 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S318691AbSHQNDJ>; Sat, 17 Aug 2002 09:03:09 -0400
To: linux-kernel@vger.kernel.org
From: Jonathan Hudson <jonathan@daria.co.uk>
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
x-no-productlinks: yes
Subject: 2.4.20-pre3 hangs on boot on Duron/VIA
X-Newsgroups: fa.linux.kernel
Content-Type: text/plain; charset=iso-8859-1
NNTP-Posting-Host: daria.co.uk
Message-ID: <1a5f.3d5e4a78.902bc@trespassersw.daria.co.uk>
Date: Sat, 17 Aug 2002 13:07:04 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.20-pre3 hangs on boot on a Duron/VIA system, immediately after
displaying the line:

 Initializing RT netlink socket 

2.4.20-pre2 (and -ac3) boot normally

 PCI: Probing PCI hardware 
 Disabling VIA memory write queue (PCI ID 0305, rev 02): [55] 89 & 1f -> 09 
 Unknown bridge resource 0: assuming transparent 
 Linux NET4.0 for Linux 2.4 
 Based upon Swansea University Computer Society NET3.039 
 Initializing RT netlink socket 
 Starting kswapd 
 ACPI: Core Subsystem version [20011018] 
 ACPI: Subsystem enabled 
 matroxfb: Matrox G400 (AGP) detected

Compiler was gcc 3.2. Further details on request if required.

Thanks
