Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312295AbSCTXtB>; Wed, 20 Mar 2002 18:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312296AbSCTXso>; Wed, 20 Mar 2002 18:48:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43025 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312295AbSCTXsZ>; Wed, 20 Mar 2002 18:48:25 -0500
Subject: Re: Bad Illegal instruction traps on dual-Xeon (p4) Linux Dell box
To: tepperly@llnl.gov (Tom Epperly)
Date: Thu, 21 Mar 2002 00:04:01 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3C991BE6.70504@llnl.gov> from "Tom Epperly" at Mar 20, 2002 03:31:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16nq3l-0003lM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One box, tux06, has the latest Dell BIOS, A05. I don't know how to 
> determine if it has the latest microcode updates. Where can one get the 
> current microcode updates, and how do I install it?

The microcode updates change the stepping value for the CPU afaik.

> According to cat /proc/cpuinfo, two boxes tux06 & tux34 have stepping 
> 10, and tux47 has stepping 2. I have seen the unexplained "Illegal 
> instruction" messages on tux34 and tux47, but I haven't run the modified 
> kernel on them. root access is restricted here.

Humm. I'm still as baffled as Dell I'm afraid
