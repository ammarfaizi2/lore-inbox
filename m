Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265375AbUBPGtQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 01:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265379AbUBPGtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 01:49:16 -0500
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:25618 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S265375AbUBPGtO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 01:49:14 -0500
Date: Mon, 16 Feb 2004 07:49:13 +0100 (CET)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: der.eremit@email.de
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: IPV4 as module?
In-Reply-To: <E1ArdRX-00005H-Tf@localhost>
Message-ID: <Pine.LNX.4.58L.0402160746070.13415@rudy.mif.pg.gda.pl>
References: <1lBZb-4vn-23@gated-at.bofh.it> <1lQXH-2pY-7@gated-at.bofh.it>
 <1mOhm-27W-31@gated-at.bofh.it> <1n4Fj-La-15@gated-at.bofh.it>
 <1oEQf-2nq-7@gated-at.bofh.it> <E1ArdRX-00005H-Tf@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Feb 2004 der.eremit@email.de wrote:

> On Fri, 13 Feb 2004 07:20:07 +0100, you wrote in linux.kernel:
> 
> >> That's not all correct. You can fit 700 MB data on a CD-ROM, but booting
> >> is still emulated from a 1.44 MB floppy (or some other floppy/HDD
> >> images, but many BIOSses won't accept those (or handle them correctly)).
> > Baloney.  Most BIOSes support "no emulation" booting these days; in fact,
> > there are more that don't do floppy emulation correctly than the few very
> > old BIOSes which didn't do no emulation.
> 
> Even if wanting to support BIOSes that don't do "no emulation", all it
> takes is simple initrd to locate and mount the iso9660 filesystem off the
> real device - and that easily fits on a 2.88 MB floppy image used for
> emulated floppy boot. Should also fit on an 1.44 MB image, although I've
> not seen a BIOS yet that didn't like a 2.88 MB image on a CD.

But back to topic .. can someone say something more and detailed about
things which dissallow now separation IPV4 stack in module ?

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
