Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129471AbRAaWqU>; Wed, 31 Jan 2001 17:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129472AbRAaWqL>; Wed, 31 Jan 2001 17:46:11 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8459 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129471AbRAaWqA>; Wed, 31 Jan 2001 17:46:00 -0500
Subject: Re: VT82C686A corruption with 2.4.x
To: safemode@voicenet.com (safemode)
Date: Wed, 31 Jan 2001 22:46:07 +0000 (GMT)
Cc: tori@tellus.mine.nu (Tobias Ringstrom),
        hahn@coffee.psychology.mcmaster.ca (Mark Hahn),
        david@fortyoz.org (David Raufeisen), vojtech@suse.cz (Vojtech Pavlik),
        linux-kernel@vger.kernel.org
In-Reply-To: <3A78945F.C82E7CAF@voicenet.com> from "safemode" at Jan 31, 2001 05:40:31 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14O60w-0003IO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> better than i ever got with 2.4 even when only one drive was on a channel.
> Right now my k7-2 750 is at 849mhz with a FSB of 114Mhz and PCI at 34Mhz.

Hint: people who overclock machines get suprising odd results and bad stuff
happens. Please dont waste developers time unless you can reproduce it at
the intended speed for the components

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
