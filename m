Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286261AbRL0Mtb>; Thu, 27 Dec 2001 07:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286264AbRL0MtK>; Thu, 27 Dec 2001 07:49:10 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:54710 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S286261AbRL0MtA>; Thu, 27 Dec 2001 07:49:00 -0500
Date: Thu, 27 Dec 2001 14:47:36 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: EEPro100 problems in SMP on 2.4.5 ?
Message-ID: <Pine.LNX.4.33.0112271443100.8153-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The oldest kernel i've tried is 2.4.10-ac11 on my SMP box and my
mysterious "hangs" (10-20s at a time) disappeared when i switched to
2.4.17-pre2. The box is dual P3 on Serverworks LE chipset. I tried
switching cards from the onboard eepro100 to a seperate dual eepro100 card
and that also exhibited the same problems, so there *might* be something
with the driver. Currently i'm using 3c59x, but i can still test with the
onboard eepro100, let me know if you need guinea pigs.

Cheers,
	Zwane Mwaikambo


