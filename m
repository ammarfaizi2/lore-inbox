Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132571AbQKWODf>; Thu, 23 Nov 2000 09:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132601AbQKWOD0>; Thu, 23 Nov 2000 09:03:26 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42770 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S132571AbQKWODO>; Thu, 23 Nov 2000 09:03:14 -0500
Subject: Re: ixj compile problems in 2.4.0-test11
To: FyreMoon@fyremoon.net
Date: Thu, 23 Nov 2000 13:28:16 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <58599.195.11.55.51.974985864.squirrel@www.fyremoon.net> from "John Crowhurst" at Nov 23, 2000 01:24:24 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13ywQD-0007M1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ixj.c: In function      xj_ioctl':
> ixj.c:4703: D_PHONE_RING_START' undeclared (first use in this function)

You have some kind of corruption here

You might want to unpack and build the new kernel with a known good kernel
rather than test9

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
