Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129655AbQKFRa0>; Mon, 6 Nov 2000 12:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130001AbQKFRaJ>; Mon, 6 Nov 2000 12:30:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29269 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129944AbQKFR3s>; Mon, 6 Nov 2000 12:29:48 -0500
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Mon, 6 Nov 2000 17:30:12 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), kaos@ocs.com.au (Keith Owens),
        jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org
In-Reply-To: <3A06F3F1.37F84C10@evision-ventures.com> from "Martin Dalecki" at Nov 06, 2000 07:09:53 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13sq61-0006Qs-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not quite: plugging physically hardware in and out is compleatly
> different
> then just loading a driver and unconditionally unloading it even when
> the hardware is still there!

Actually its no different.

Suppose I unplug my USB speakers and plug them back in again (perhaps Im just
adding a hub). Do you unload and reload the driver ? If so how do you preserve
the mixer levels ?

Same problem...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
