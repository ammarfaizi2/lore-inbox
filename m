Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132200AbQKDAUb>; Fri, 3 Nov 2000 19:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132201AbQKDAUV>; Fri, 3 Nov 2000 19:20:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32530 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132200AbQKDAUD>; Fri, 3 Nov 2000 19:20:03 -0500
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
To: wendling@ganymede.isdn.uiuc.edu (Bill Wendling)
Date: Sat, 4 Nov 2000 00:19:10 +0000 (GMT)
Cc: kuznet@ms2.inr.ac.ru, ak@suse.de (Andi Kleen),
        linux-kernel@vger.kernel.org
In-Reply-To: <20001103160108.D16644@ganymede.isdn.uiuc.edu> from "Bill Wendling" at Nov 03, 2000 04:01:08 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13rr39-00046Z-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> } Andi, neither you nor me nor Alan nor anyone are able to audit
> } all this unnevessarily overcomplicated code. It was buggy, is buggy
> } and will be buggy. It is inavoidable, as soon as you have hundreds
> } of drivers.
> } 
> If they are buggy and unsupported, why aren't they being expunged from
> the main source tree and placed into a ``contrib'' directory or something
> for people who may want those drivers?

Because by 2.4.5 it will be working ;). Pain power 8)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
