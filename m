Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130460AbQL1DEt>; Wed, 27 Dec 2000 22:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131021AbQL1DEk>; Wed, 27 Dec 2000 22:04:40 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22544 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130460AbQL1DEV>; Wed, 27 Dec 2000 22:04:21 -0500
Subject: Re: 2.2.18 dies on my 486..
To: mharris@opensourceadvocate.org (Mike A. Harris)
Date: Thu, 28 Dec 2000 02:35:47 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel mailing list)
In-Reply-To: <Pine.LNX.4.31.0012220359540.666-100000@asdf.capslock.lan> from "Mike A. Harris" at Dec 27, 2000 08:05:25 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14BSuz-00038b-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just upgraded my 486 firewall's kernel to pure 2.2.18 from
> 2.2.17, with no other changes, and now it dies with all sorts
> of hard disk failures.
> 
> I get:
> 
> hdb: lost interrupt
> And stuff about DRQ lost...

What hardware config, what hdparm tuning options ?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
