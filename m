Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130462AbQLUBWR>; Wed, 20 Dec 2000 20:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130797AbQLUBWH>; Wed, 20 Dec 2000 20:22:07 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:49163 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130462AbQLUBV5>; Wed, 20 Dec 2000 20:21:57 -0500
Subject: Re: CPRM copy protection for ATA drives
To: lk@mailandnews.com
Date: Thu, 21 Dec 2000 00:54:07 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3lmtazngb.fsf@fork.man2.dom> from "lk@mailandnews.com" at Dec 20, 2000 11:23:48 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E148tzm-0002KI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does anyone have any details on this? I presume that the drive
> firmware is capable of identifying copy-protected data during
> a write. I also presume that nobody on lkml would condone

It seems to be very similar to the DVD stuff, including ideas for play once
only blocks and the like. Pay per read hard disk...

> such a terrible idea. I imagine that this system is pretty
> easy to defeat if you can modify the filesystem. Perhaps even

Its probably very hard to defeat. It also in its current form means you can
throw disk defragmenting tools out. Dead, gone. Welcome to the United Police
State Of America.

> The consequences of being able to corrupt other people's backups
> by introducing "copy-protected" data are intriguing...

I'm just waiting for a few class action law suits against drive manufacturers
when people's backup tools cannot cope

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
