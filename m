Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131809AbRDFQDp>; Fri, 6 Apr 2001 12:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131899AbRDFQDf>; Fri, 6 Apr 2001 12:03:35 -0400
Received: from TK152095.tuwien.teleweb.at ([195.34.152.95]:28920 "EHLO
	elch.elche") by vger.kernel.org with ESMTP id <S131809AbRDFQD2>;
	Fri, 6 Apr 2001 12:03:28 -0400
Date: Fri, 6 Apr 2001 18:03:17 +0200
From: Armin Obersteiner <armin@xos.net>
To: linux-kernel@vger.kernel.org
Subject: linux 2.2.19 smp interrupt problems?
Message-ID: <20010406180317.A30197@elch.elche>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

i get a lot of messages of this kind:

Apr  6 17:44:33 home kernel: eth0: RTL8139 Interrupt line blocked, status 4.
Apr  6 17:44:33 home kernel: eth0: SMP simultaneous entry of an interrupt handler.

linux 2.2.19
dual pentium 166
rtl8139
high network load (encrypted x applications over network)

with a low load i don't get the messages.

everything seems to work fine. are these interrupt problems "bad" or merely
indicators of a high load. can/should one get rid of them?

MfG,
	Armin Obersteiner
--
armin@xos.net                        pgp public key on request        CU
