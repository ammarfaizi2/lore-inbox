Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131268AbQLQAsC>; Sat, 16 Dec 2000 19:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131091AbQLQArv>; Sat, 16 Dec 2000 19:47:51 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64781 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130211AbQLQArn>; Sat, 16 Dec 2000 19:47:43 -0500
Subject: Re: 8139too problem in 2.2.18
To: covici@ccs.covici.com (John Covici)
Date: Sun, 17 Dec 2000 00:19:42 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0012161828180.628-100000@ccs.covici.com> from "John Covici" at Dec 16, 2000 06:31:28 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E147RYH-0003OM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi.  I have a RealTech 8139 Ethernet card and I am using kernel
> 2.2.18.  I tried to use the new driver 8139too as a module, but when
> doing an insmod or modprobe on the module I got "symbol forparameter
> debug not found".  There was nothing obvious in the module source, so
> any assistance would be appreciated.

Use an older version of modutils
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
