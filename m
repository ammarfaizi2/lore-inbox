Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129948AbQKFR3f>; Mon, 6 Nov 2000 12:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129947AbQKFR30>; Mon, 6 Nov 2000 12:29:26 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12885 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129944AbQKFR3K>; Mon, 6 Nov 2000 12:29:10 -0500
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Mon, 6 Nov 2000 17:29:15 +0000 (GMT)
Cc: vonbrand@inf.utfsm.cl (Horst von Brand),
        dwmw2@infradead.org (David Woodhouse), linux-kernel@vger.kernel.org
In-Reply-To: <3A06F1C4.CB25FA8C@evision-ventures.com> from "Martin Dalecki" at Nov 06, 2000 07:00:36 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13sq56-0006Qg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Drivers are supposed to handle present hardware - if the hardware
> is there - there should be a driver handling it as well.

Thats not how things have worked historically. Thats not consistent with other
modules either.

> The argument for saving some memmory is nonapplicable becouse in
> the case of expected usage in the future you have anyway to assume that
> in this futere there will be sufficient memmory for it there. And then

Rubbish

> Could some one add this to the FAQ ... please!

You got the letters in the wrong order. Your proposal is at best a 
Frequently Questioned Answer

> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
