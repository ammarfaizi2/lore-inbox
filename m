Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRA2XDS>; Mon, 29 Jan 2001 18:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129610AbRA2XDH>; Mon, 29 Jan 2001 18:03:07 -0500
Received: from 24-240-45-22.hsacorp.net ([24.240.45.22]:32641 "EHLO
	penguin.linuxhardware.org") by vger.kernel.org with ESMTP
	id <S129562AbRA2XCu>; Mon, 29 Jan 2001 18:02:50 -0500
Date: Mon, 29 Jan 2001 18:02:23 -0500 (EST)
From: Kernel Related Emails <kernel@penguin.linuxhardware.org>
To: linux-kernel@vger.kernel.org
Subject: DVD Disk Detection
Message-ID: <Pine.LNX.4.21.0101291759200.6259-100000@penguin.linuxhardware.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was just wondering if anyone had any suggestions to check to see if a
DVD is in a users DVD drive.  Currently if you run a CDROM_DISC_STATUS on
a DVD you get a CDS_DATA_1 returned.  What kernel level call would
destinguish between an actual Data CD and a DVD?

Thanks,
Kris Kersey
kernel@linuxhardware.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
