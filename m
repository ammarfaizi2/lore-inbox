Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129340AbQK0SD0>; Mon, 27 Nov 2000 13:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129581AbQK0SDQ>; Mon, 27 Nov 2000 13:03:16 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:50387 "EHLO
        delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
        id <S129340AbQK0SDE>; Mon, 27 Nov 2000 13:03:04 -0500
Date: Mon, 27 Nov 2000 18:30:48 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Mr. Big" <mrbig@sneaker.sch.bme.hu>
cc: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PROBLEM: crashing kernels
In-Reply-To: <Pine.LNX.3.96.1001126164611.8011A-100000@sneaker.sch.bme.hu>
Message-ID: <Pine.GSO.3.96.1001127182529.13774T-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2000, Mr. Big wrote:

> How could an APIC 'forget' how to deliver the interrupts? Could this mean
> a problem with the mainboard, or with the CPU?

 Do you have an USB host controller in your system?  If so, could you
please send me an output of `/sbin/lspci' and the contents of
/proc/interrupts?  I wonder if this might be the reason...

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
