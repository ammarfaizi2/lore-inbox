Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132224AbRDCQ5k>; Tue, 3 Apr 2001 12:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132281AbRDCQ5a>; Tue, 3 Apr 2001 12:57:30 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26375 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132224AbRDCQ5S>; Tue, 3 Apr 2001 12:57:18 -0400
Subject: Re: EATA driver with DPT SmartRAID V
To: dyp@perchine.com (Denis Perchine)
Date: Tue, 3 Apr 2001 17:59:05 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200104031639.XAA32695@gw.ac-sw.com> from "Denis Perchine" at Apr 03, 2001 11:38:12 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kU96-0008RI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Bus  1, device   1, function  0:
>     PCI bridge: Distributed Processing Technology PCI Bridge (rev 2).
>       Master Capable.  Latency=64.  Min Gnt=3.
>   Bus  1, device   1, function  1:
>     I2O: Distributed Processing Technology SmartRAID V Controller (rev 2).

This card isnt supported by the eata driver.

