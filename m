Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132233AbRACPSB>; Wed, 3 Jan 2001 10:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132227AbRACPRv>; Wed, 3 Jan 2001 10:17:51 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26632 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132132AbRACPRr>; Wed, 3 Jan 2001 10:17:47 -0500
Subject: Re: Timeout: AT keyboard not present?
To: Andries.Brouwer@cwi.nl
Date: Wed, 3 Jan 2001 14:49:00 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, sfr@gmx.net
In-Reply-To: <UTC200101031432.PAA136866.aeb@texel.cwi.nl> from "Andries.Brouwer@cwi.nl" at Jan 03, 2001 03:32:38 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14DpDr-000449-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How you got into scancode mode 1 I don't know
> (maybe by sending the command f0 01 to the keyboard).
> Do things improve if you rip this strange messy AUX_RECONNECT
> stuff out of drivers/char/pc_keyb.c?

2.2.18 the aux reconnect handling is off by default
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
