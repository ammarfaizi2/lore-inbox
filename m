Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129822AbQKYTR7>; Sat, 25 Nov 2000 14:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130108AbQKYTRt>; Sat, 25 Nov 2000 14:17:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58690 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S129822AbQKYTRg>; Sat, 25 Nov 2000 14:17:36 -0500
Subject: Re: PROBLEM: crashing kernels
To: mrbig@sneaker.sch.bme.hu (Mr. Big)
Date: Sat, 25 Nov 2000 18:47:31 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1001125194140.1936A-100000@sneaker.sch.bme.hu> from "Mr. Big" at Nov 25, 2000 07:44:49 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13zkMH-0001E1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, I'll try. Since I'm not a kernel developer, I have the fool question,
> wether it is enough to overwrite the .c and .h files in the 2.2.14 source
> tree, or do I need to apply other changes too?

I believe that is all you need to do for that driver

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
