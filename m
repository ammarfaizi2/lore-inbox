Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129120AbQJ3OCe>; Mon, 30 Oct 2000 09:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129240AbQJ3OCY>; Mon, 30 Oct 2000 09:02:24 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30530 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129120AbQJ3OCH>; Mon, 30 Oct 2000 09:02:07 -0500
Subject: Re: Need info on the use of certain datastructures and the first C++ keyword patch for 2.2.17
To: kaos@ocs.com.au (Keith Owens)
Date: Mon, 30 Oct 2000 14:02:38 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux_developer@hotmail.com (Linux Kernel Developer),
        linux-kernel@vger.kernel.org
In-Reply-To: <4572.972914218@ocs3.ocs-net> from "Keith Owens" at Oct 31, 2000 12:56:58 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13qFWK-0006uI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As part of the 2.5 kbuild redesign, symbol versions will be completely
> redone.  One of the things on my todo list is to detect this mismatch.
> There are some problems in doing that which I may or may not be able to
> overcome, but if the field names are different between C and C++ then I
> can never detect this mismatch correctly.

The symbol generation code never sees the C++ names, never will and never can.
I still don't see any problem.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
