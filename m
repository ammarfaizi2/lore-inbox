Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130445AbRBAReZ>; Thu, 1 Feb 2001 12:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130229AbRBAReP>; Thu, 1 Feb 2001 12:34:15 -0500
Received: from marvin.cdf.toronto.edu ([128.100.31.3]:57305 "HELO
	marvin.cdf.toronto.edu") by vger.kernel.org with SMTP
	id <S129528AbRBARdx>; Thu, 1 Feb 2001 12:33:53 -0500
Date: Thu, 1 Feb 2001 12:33:49 -0500 (EST)
From: <apark@cdf.toronto.edu>
To: <linux-kernel@vger.kernel.org>
Subject: 2.2.16 3c90x ?
Message-ID: <Pine.GSO.4.30.0102011220540.5429-100000@marvin.cdf>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just wondering...  How safe is it to switch from 10Mbit network to
100Mbit network while the machine is up?

I have two cables - one leading to 10Mbit network and the other 100Mbit
when I switched the cables (I can guarantee that there was no routing issue)
from 10Mbit to 100Mbit while machine was up, it just froze solid.

I'm using 3Com 3c905C Tornado network card and the corresponding driver
is 3c90x.

Thanks

-A

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
