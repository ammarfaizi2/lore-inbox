Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129545AbQKINTx>; Thu, 9 Nov 2000 08:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129551AbQKINTn>; Thu, 9 Nov 2000 08:19:43 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50000 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129545AbQKINTb>; Thu, 9 Nov 2000 08:19:31 -0500
Subject: Re: Stange NFS messages - 2.2.18pre19
To: ionut@moisil.cs.columbia.edu (Ion Badulescu)
Date: Thu, 9 Nov 2000 13:19:56 +0000 (GMT)
Cc: vaxerdec@frontiernet.net (Scott McDermott), linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <200011090656.eA96u3Y22945@moisil.dev.hydraweb.com> from "Ion Badulescu" at Nov 08, 2000 10:56:03 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13trcV-00018q-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I really really think this should be backed out -- or at the very least
> disabled. The code wasn't part of the dhiggen merge, it wasn't tested,
> and it doesn't work well. Heck, it's still experimental and not recommended
> in 2.4.0-test.

Its now an experimental option in my pre21 build tree. So people can play with
it and debug it if they wish

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
