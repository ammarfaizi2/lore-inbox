Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130650AbQLPB5P>; Fri, 15 Dec 2000 20:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130866AbQLPB5F>; Fri, 15 Dec 2000 20:57:05 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19211 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130650AbQLPB5D>; Fri, 15 Dec 2000 20:57:03 -0500
Subject: Re: Signal 11gy
To: dan@tools.c4usa.com (Dan Egli)
Date: Sat, 16 Dec 2000 01:28:52 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0012141708160.13899-100000@tools.c4usa.com> from "Dan Egli" at Dec 14, 2000 05:11:47 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14769h-0002Ar-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's not in the X tree or anything, but here's a personal example.
> Machine: Dual P3 550
> HDD: Dual Ultra2Wide Seagate 18GB Hdd
> OS: RedHat 7
> Compile Target: Linux Kernel 2.2.17
> Result with gcc 2.96: Failure (syntax errors in the i386 branch of the
> arch tree)
> Result with compat-egcs-62: Success on the first try.

It isnt a bug in the compiler. Its a bug in the kernel tree.  Its a bug in
the old compiler that it didnt error it before.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
