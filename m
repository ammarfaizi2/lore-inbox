Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263657AbUCUOor (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 09:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263658AbUCUOor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 09:44:47 -0500
Received: from chaos.analogic.com ([204.178.40.224]:43649 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263657AbUCUOoq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 09:44:46 -0500
Date: Sun, 21 Mar 2004 09:46:35 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Richard Browning <richard@redline.org.uk>
cc: Len Brown <len.brown@intel.com>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       linux-kernel@vger.kernel.org,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Subject: Re: ANYONE? Re: SMP + Hyperthreading / Asus PCDL Deluxe / Kernel
 2.4.x 2.6.x / Crash/Freeze
In-Reply-To: <200403201433.40357.richard@redline.org.uk>
Message-ID: <Pine.LNX.4.53.0403210940380.11483@chaos>
References: <A6974D8E5F98D511BB910002A50A6647615F4B99@hdsmsx402.hd.intel.com>
 <1079072878.3885.33.camel@dhcppc4> <1079075236.3885.52.camel@dhcppc4>
 <200403201433.40357.richard@redline.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Mar 2004, Richard Browning wrote:

> Gents
>
> Is there anyone in kernelland who is tackling this? I'm currently in the
> throes of recompiling everything with -march=pentium3 -O2 to see if these
> simple flags make a difference (as I reiterate, Windoze XP works without
> problem). I refuse to believe that I will have to use XP in order to get my
> money's worth. I've always thought anything Doze can do, GNU/Linux does
> better!

I have been using 2.4.24 with SMP and hyperthreading with no
problems. FYI, the reference to Windows is useless, because
M$ was unable to make any SMP stuff function without crashes
since windows 2000/professional, later Windows versions don't
use your additional CPUs at all, they just report that they
exist. FYI, see if you can find your CPU resources at all
in XP!!!  They just don't want you to know!


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


