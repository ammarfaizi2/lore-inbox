Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264952AbRFZOHx>; Tue, 26 Jun 2001 10:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264953AbRFZOHo>; Tue, 26 Jun 2001 10:07:44 -0400
Received: from cmr0.ash.ops.us.uu.net ([198.5.241.38]:47827 "EHLO
	cmr0.ash.ops.us.uu.net") by vger.kernel.org with ESMTP
	id <S264952AbRFZOHa>; Tue, 26 Jun 2001 10:07:30 -0400
Message-ID: <3B389702.47C03532@uu.net>
Date: Tue, 26 Jun 2001 10:06:58 -0400
From: Alex Deucher <adeucher@UU.NET>
Organization: UUNET
X-Mailer: Mozilla 4.74 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: joeja@mindspring.com, linux-kernel@vger.kernel.org
Subject: Re: AMD thunderbird oops
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get oopses too when I use kernels compiled for athlon on my redhat
7.1, athlon 850 system.  runs rock solid when I compile for i686.  I
assumed the athlon optimizations in the kernel were broken, or gcc's
athlon optimization was, as I seem to recall some discussion of this a
while back on the LKML.

athlon 850 (200 FSB)
512 MB RAM
IWILL KK266

Alex

----------------------------

I just upgradede my system to an 1200Mhz AMD Athlon Thundirbird (266Mhz
FSB) processor / 512Meg of RAM, and an
Asus kt7a motherboard. 

It is oppsing left and right. I recompiled the kernel with Athelon as
the CPU but keep getting these oopses.. 

I also get these same problems while trying to install RH 7.1 

Anyone know is this a supported processor / MB and has anyone had these
problems? 

Joe please cc me as I am not on this list. 
- 
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in 
the body of a message to majordomo@vger.kernel.org 
More majordomo info at http://vger.kernel.org/majordomo-info.html 
Please read the FAQ at http://www.tux.org/lkml/
