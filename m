Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130892AbRAHTTN>; Mon, 8 Jan 2001 14:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131213AbRAHTTD>; Mon, 8 Jan 2001 14:19:03 -0500
Received: from dns1.rz.fh-heilbronn.de ([141.7.1.18]:32888 "EHLO
	dns1.rz.fh-heilbronn.de") by vger.kernel.org with ESMTP
	id <S131242AbRAHTS1>; Mon, 8 Jan 2001 14:18:27 -0500
Date: Mon, 8 Jan 2001 20:18:24 +0100 (CET)
From: Oliver Paukstadt <pstadt@stud.fh-heilbronn.de>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: xircom_tulip_cb
Message-ID: <Pine.LNX.4.05.10101082005500.25931-100000@lara.stud.fh-heilbronn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HY HY

I have a Xircom R2BE-100, RealPort2 CardBus Ethernet 10/100.

With RH6.2, 2.2.17 and pcmcia-cs-3.1.19 everything was fine.

With RH7, 2.2.18 and pcmcia-cs-3.1.23 the Card did not work. With ifconfig
-a it was displayed, but it doesn't work.

With 2.4.0-ac2 and Kernel-PCMCIA the same effekt.

Exceuting 'ifconfig eth0 promisc' caused the card to work.

BYtE Oli

+++LINUX++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++Manchmal stehe ich sogar nachts auf und installiere mir eins....+++++++
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
