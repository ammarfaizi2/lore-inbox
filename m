Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131114AbQL1Lp2>; Thu, 28 Dec 2000 06:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131203AbQL1LpS>; Thu, 28 Dec 2000 06:45:18 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:27466 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S131114AbQL1LpB>;
	Thu, 28 Dec 2000 06:45:01 -0500
Message-ID: <20001228121437.A23961@win.tue.nl>
Date: Thu, 28 Dec 2000 12:14:37 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.19pre3
In-Reply-To: <20001228021859.A4661@emma1.emma.line.org> <E14BSwU-00038p-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <E14BSwU-00038p-00@the-village.bc.nu>; from Alan Cox on Thu, Dec 28, 2000 at 02:37:19AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2000 at 02:37:19AM +0000, Alan Cox wrote:

> > I have my system clock drift roughly -1 s/min, though my CMOS clock is
> > fine unless tampered with.

> adjtimex will let you tell Linux the clock on the board is crap too

But may tamper with the CMOS clock
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
