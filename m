Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129625AbQKURCz>; Tue, 21 Nov 2000 12:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129999AbQKURCq>; Tue, 21 Nov 2000 12:02:46 -0500
Received: from ns1.sevenkings.net ([216.126.141.50]:1799 "EHLO
	ns1.sevenkings.net") by vger.kernel.org with ESMTP
	id <S129625AbQKURC3>; Tue, 21 Nov 2000 12:02:29 -0500
From: Egan <egan@sevenkings.net>
To: linux-kernel@vger.kernel.org
Subject: 3c527 driver won't receive packets
Date: Tue, 21 Nov 2000 11:32:27 -0500
Message-ID: <7a8l1tcv145omgpmvf02gjsk4p34djjt9f@4ax.com>
In-Reply-To: <DLECJAOCHAKJBLMJFKPIAEPBCCAA.ruben@trymedia.com> <200011211720.MAA04358@ccure.karaya.com>
In-Reply-To: <200011211720.MAA04358@ccure.karaya.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was hoping to use some Etherlink MC/32 cards in my MCA Server 95.

The card will transmit packets, I can see them on another machine with
tcpdump.  But it will not receive any packets.

I've already tried 3 different Etherlink MC/32 cards.  Each one passes
the 3Com diagnostics.  I get the same result with 2.4.0-test11 and
2.2.18pre5.

The same server works fine on the LAN with a 3c529 MCA card.  The
3c529 is a slower card, so I would prefer to use the MC/32 cards if
possible.

Any hints on solving the problem?

Egan


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
