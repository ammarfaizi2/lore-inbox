Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318039AbSGWMQ6>; Tue, 23 Jul 2002 08:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318040AbSGWMQ6>; Tue, 23 Jul 2002 08:16:58 -0400
Received: from tartarus.telenet-ops.be ([195.130.132.34]:16787 "EHLO
	tartarus.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S318039AbSGWMQ5>; Tue, 23 Jul 2002 08:16:57 -0400
Date: Tue, 23 Jul 2002 14:20:13 +0200 (CEST)
From: Michael De Nil <michael@aerythmic.be>
X-X-Sender: linux@LiSa
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Tulip-driver && SMC1255TX -> kernel fails
Message-ID: <Pine.LNX.4.44.0207231409280.21178-100000@LiSa>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey

I have bought an SMC 1255TX-card.
In the manual is said that I should use the Tulip-driver.
I was able to load the module tulip.o from kernel 2.4.19-pre10, but when I
start my network (/etc/init.d/networking start) on my debian-machine, the
screen starts flashing the message:
Eth0: (i) System Error occured (0)
with i = number increasing by 1

I didn't see any of this in the changelog up to rc3..


Greetings
	Michael

-----------------------------------------------------------------------
                Michael De Nil -- michael@aerythmic.be
      Linux LiSa 2.4.19-rc2 #1 vr jul 19 22:10:00 CEST 2002 i686
  14:09:01 up 3 days,  3:24, 10 users,  load average: 0.00, 0.00, 0.00
-----------------------------------------------------------------------

