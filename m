Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269080AbRG3Wvr>; Mon, 30 Jul 2001 18:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268769AbRG3Wv2>; Mon, 30 Jul 2001 18:51:28 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:29633 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S268750AbRG3WvY>; Mon, 30 Jul 2001 18:51:24 -0400
Date: Tue, 31 Jul 2001 00:53:44 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Khalid Aziz <khalid@fc.hp.com>,
        Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Support for serial console on legacy free machines
In-Reply-To: <200107302240.f6UMeWg2001230@webber.adilger.int>
Message-ID: <Pine.GSO.3.96.1010731004827.19618G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001, Andreas Dilger wrote:

> What bothers me is that new systems don't have a serial port, and no ISA
> slots, so there is no hope of getting a "serial console" support without
> ACPI (which is rather heavyweight AFAIK).  USB is far too complex to use
> for early-boot debugging, so what else is left?

 You may still get a PCI serial controller card.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

