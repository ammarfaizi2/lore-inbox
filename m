Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbQL1Kfa>; Thu, 28 Dec 2000 05:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129775AbQL1KfV>; Thu, 28 Dec 2000 05:35:21 -0500
Received: from ns1.crl.go.jp ([133.243.3.1]:31210 "EHLO ns1.crl.go.jp")
	by vger.kernel.org with ESMTP id <S129408AbQL1KfH>;
	Thu, 28 Dec 2000 05:35:07 -0500
Date: Thu, 28 Dec 2000 19:04:32 +0900 (JST)
From: Tom Holroyd <tomh@po.crl.go.jp>
To: Ville Herva <vherva@mail.niksula.cs.hut.fi>
cc: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: VM: do_try_to_free_pages failed
In-Reply-To: <20001228111541.G1265@niksula.cs.hut.fi>
Message-ID: <Pine.LNX.4.30.0012281903560.2348-100000@holly.crl.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > kernel: VM: do_try_to_free_pages failed for xntpd...
> > kernel: VM: do_try_to_free_pages failed for klogd...
> > last message repeated 15 times
> > kernel: VM: do_try_to_free_pages failed for tail...
> > last message repeated 15 times
> > kernel: VM: do_try_to_free_pages failed for init...
> > last message repeated 15 times
> > kernel: VM: do_try_to_free_pages failed for vmstat...
>
> Known problem; should be fixed in 2.2.19pre2 or higher (that include
> Andrea Arcangeli's vm-global-7 patch).

Yup, I can't make it happen on pre3.

Dr. Tom Holroyd
"I am, as I said, inspired by the biological phenomena in which
chemical forces are used in repetitious fashion to produce all
kinds of weird effects (one of which is the author)."
	-- Richard Feynman, _There's Plenty of Room at the Bottom_

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
