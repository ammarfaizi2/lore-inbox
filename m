Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129730AbRAAW4Z>; Mon, 1 Jan 2001 17:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129913AbRAAW4O>; Mon, 1 Jan 2001 17:56:14 -0500
Received: from [213.97.36.143] ([213.97.36.143]:61447 "EHLO pau.intranet.ct")
	by vger.kernel.org with ESMTP id <S129730AbRAAW4F>;
	Mon, 1 Jan 2001 17:56:05 -0500
Date: Mon, 1 Jan 2001 23:26:28 +0100 (CET)
From: Pau Aliagas <pau@newtral.com>
To: <linux-kernel@vger.kernel.org>
Subject: missing symbols in prerelease
Message-ID: <Pine.LNX.4.30.0101012325100.1184-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


depmod: *** Unresolved symbols in
/lib/modules/2.4.0-prerelease/kernel/drivers/net/irda/toshoboe.o
depmod: 	__bad_udelay
depmod: *** Unresolved symbols in
/lib/modules/2.4.0-prerelease/kernel/drivers/video/atyfb.o
depmod: 	__bad_udelay



Pau

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
