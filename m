Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbQKGM0R>; Tue, 7 Nov 2000 07:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129642AbQKGM0I>; Tue, 7 Nov 2000 07:26:08 -0500
Received: from pizda.ninka.net ([216.101.162.242]:53381 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130397AbQKGMZs>;
	Tue, 7 Nov 2000 07:25:48 -0500
Date: Tue, 7 Nov 2000 04:10:38 -0800
Message-Id: <200011071210.EAA03622@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
CC: jordy@napster.com, linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
In-Reply-To: <E13t7lX-0007LD-00@the-village.bc.nu> (message from Alan Cox on
	Tue, 7 Nov 2000 12:22:14 +0000 (GMT))
Subject: Re: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
In-Reply-To: <E13t7lX-0007LD-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Tue, 7 Nov 2000 12:22:14 +0000 (GMT)
   From: Alan Cox <alan@lxorguk.ukuu.org.uk>

   If their system is confused by tcp options in data segments then
   the SACK stuff in 2.4 may well be the trigger.

SACK is on by default in both the 2.2.x and 2.4.x traces...

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
