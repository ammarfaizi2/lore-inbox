Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129927AbQKWBVb>; Wed, 22 Nov 2000 20:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130517AbQKWBVV>; Wed, 22 Nov 2000 20:21:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54140 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S129792AbQKWBVI>; Wed, 22 Nov 2000 20:21:08 -0500
Subject: Re: silly [< >] and other excess
To: Andries.Brouwer@cwi.nl
Date: Thu, 23 Nov 2000 00:51:09 +0000 (GMT)
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <UTC200011230038.BAA142694.aeb@aak.cwi.nl> from "Andries.Brouwer@cwi.nl" at Nov 23, 2000 01:38:53 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13ykbY-0006im-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The EIP is not pushed out of sight horizontally, but vertically.
> (Maybe you never saw a i386 oops. With [<>] the call trace takes
> twice as many lines (on a 25x80 screen) as without.)

Thats because too many things get put on a line then. And because we
do [<foo>] [<bar>]  not   [<foo>][<bar>] ?

> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
