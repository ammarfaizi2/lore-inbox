Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265527AbRF1FAV>; Thu, 28 Jun 2001 01:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265530AbRF1FAM>; Thu, 28 Jun 2001 01:00:12 -0400
Received: from [203.237.41.6] ([203.237.41.6]:1920 "EHLO bellini.kjist.ac.kr")
	by vger.kernel.org with ESMTP id <S265527AbRF1FAF>;
	Thu, 28 Jun 2001 01:00:05 -0400
Date: Thu, 28 Jun 2001 13:58:52 +0900
Message-Id: <200106280458.f5S4wqe02117@bellini.kjist.ac.kr>
From: "G. Hugh Song" <ghsong@kjist.ac.kr>
To: linux-kernel@vger.kernel.org
Subject: Re: NETDEV WATCHDOG with 2.4.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My Linux for Alpha on UP2000 SMP has had the same problem with 
the newer kernels 2.4.* with the tulip network driver.
It's got Netgear 310TX with the Digital's original 21140 chip.
In my case, it has nothing to do with the APIC because Alpha 
does not have anything related to APIC.

I suspected that the the message may indicate various
different situations:

G. Hugh Song

