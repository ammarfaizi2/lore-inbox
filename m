Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277351AbRJJSAH>; Wed, 10 Oct 2001 14:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277350AbRJJR75>; Wed, 10 Oct 2001 13:59:57 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:608 "EHLO
	c0mailgw12.prontomail.com") by vger.kernel.org with ESMTP
	id <S277351AbRJJR7x>; Wed, 10 Oct 2001 13:59:53 -0400
Message-ID: <3BC48C0E.760488AA@starband.net>
Date: Wed, 10 Oct 2001 13:57:34 -0400
From: war <war@starband.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ATA/100 Promise Board
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any idea why DMA is sometimes on and sometimes not for a few cdrom
drives I have hooked up to my promise controller?

Whether it is on or off, whenever I copy a CD from a (dma) cdrom whether
it dma is on or off it slows my system down big time.  Move the cursor
around in X, and it lags, watch X-Chat, the characters you type in
slowly appear 3-5 seconds after.

Hook the same drives up to the motherboard ide interfaces and there is
no lag at all.

This has always been the case with my cdroms.

When I had my HD on the Promise, it did DMA etc just fine.

Is there a problem with the driver if a HD is not on there it doesn't do
DMA correctly or something?

