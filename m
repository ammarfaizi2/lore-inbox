Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129524AbQKYRvV>; Sat, 25 Nov 2000 12:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131315AbQKYRvC>; Sat, 25 Nov 2000 12:51:02 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:3088
        "EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
        id <S129524AbQKYRul>; Sat, 25 Nov 2000 12:50:41 -0500
Date: Sat, 25 Nov 2000 09:20:19 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fasttrak100 questions...
In-Reply-To: <8voa7g$d1r$1@forge.tanstaafl.de>
Message-ID: <Pine.LNX.4.10.10011250917530.9130-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2000, Henning P. Schmiedehausen wrote:

> No, it does not. Distributing does. You will never get this right. You
> can compile into your kernel anything you like as long as you don't
> give it away.

And you will never boot it because the resources conflict with out the
module, go try it.  I promise you that it will never boot if you build it
in the kernel.  Also the terms of acceptance of the module also means you
can not built it inter the kernel.

Cheers,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
