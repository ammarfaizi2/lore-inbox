Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129540AbRBLE6N>; Sun, 11 Feb 2001 23:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129681AbRBLE6D>; Sun, 11 Feb 2001 23:58:03 -0500
Received: from zbt61.eastnet.gatech.edu ([128.61.107.189]:15366 "EHLO pinky")
	by vger.kernel.org with ESMTP id <S129540AbRBLE55>;
	Sun, 11 Feb 2001 23:57:57 -0500
Date: Sun, 11 Feb 2001 23:57:53 -0500
To: linux-kernel@vger.kernel.org
Subject: * Re: [patch] 2.4.0, 2.4.0-ac12: APIC lock-ups
Message-ID: <20010211235753.A16799@zarq.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
From: rc@zarq.dhs.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Maciej's io-apic patch fixed the long-standing problems with my
ne2k-pci card (since at least 2.4.0-test10, and absent in 2.2.17).

Ne2k-pci card (D-Link, exact model # would require a reboot and
card pull)
Dual 366 Celeron / Abit BP6 / 128MB (Problem showed up at both 366/550)
Eth0 has over 3 million interrupts, and no loss of connection.
2.4.0 (not .1)

Thanks!
Robert Cicconetti
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
