Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130218AbQK0Xrg>; Mon, 27 Nov 2000 18:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129931AbQK0Xr0>; Mon, 27 Nov 2000 18:47:26 -0500
Received: from p3EE1EE54.dip.t-dialin.net ([62.225.238.84]:52745 "EHLO master")
        by vger.kernel.org with ESMTP id <S129744AbQK0XrO>;
        Mon, 27 Nov 2000 18:47:14 -0500
Date: Tue, 28 Nov 2000 01:30:01 +0100
From: Udo Held <udo@udoheld.de>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        netdev@oss.sgi.com
Subject: [udo@udoheld.de: Hardware recognization error on Davicom 9102 with Tulip DS21140 driver]
Message-ID: <20001128013001.A1459@udoheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---- Forwarded message from Udo Held <udo@udoheld.de> -----

Date: Tue, 28 Nov 2000 00:01:26 +0100
From: Udo Held <udo@udoheld.de>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
	netdev@oss.sgi.com
Subject: Hardware recognization error on Davicom 9102 with Tulip DS21140 driver
User-Agent: Mutt/1.2.5i

> Hi!
> 
> I didn't know which driver was the right one for my network card so I
> just compiled all network-card drivers that where listed into my kernel
> I tried it with test9 and test11. The DS21140 Tulip driver found my card
> and crashes the system during boot up. My card is a Davicom 9102(?). It's
> working fine with the right driver.

The system crashes with an oops. I'm not able
to copy and paste it without pencil and paper, because it's hanging
during booting up. If you really need that output please tell me.
Imo you should just fix that the Tulip driver thinks there is a card
with a DS21140 chipset.

I'm using the right experimental driver and it's working. So please 
don't mail me about using the right driver.

[..]

Cheers,
Udo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
