Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129428AbQLVMZH>; Fri, 22 Dec 2000 07:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131632AbQLVMY5>; Fri, 22 Dec 2000 07:24:57 -0500
Received: from queen.bee.lk ([203.143.12.182]:7940 "EHLO bee.lk")
	by vger.kernel.org with ESMTP id <S129428AbQLVMYt>;
	Fri, 22 Dec 2000 07:24:49 -0500
Date: Fri, 22 Dec 2000 17:53:19 +0600 (LKT)
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Robert B. Easter" <reaster@comptechnews.com>,
        linux-kernel@vger.kernel.org
Subject: Re: recommended gcc compiler version
In-Reply-To: <E149NvR-0004Kz-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0012221746160.320-100000@bee.lk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Dec 2000, Alan Cox wrote:

> For i386
> 
> 2.2.18
> 	gcc 2.7.2 or egcs-1.1.2

Just a remainder for debian users. There is a debian package gcc272 which
is said to be the "GNU C compiler's C part", for "backword compatibility
purposes". I recompiled my kernel after an

  apt-get install gcc272

and after setting

  HOSTGCC = gcc272

in kernel source tree Makerile.


Anuradha

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
