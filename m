Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbUDGJZK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 05:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbUDGJZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 05:25:10 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:17892 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262470AbUDGJZF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 05:25:05 -0400
Date: Mon, 5 Apr 2004 15:35:35 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: Re: drivers/char/dz.[ch]: reason for keeping?
In-Reply-To: <20040405141957.B31724@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.55.0404051533450.31851@jurand.ds.pg.gda.pl>
References: <20040404101241.A10158@flint.arm.linux.org.uk>
 <Pine.LNX.4.55.0404051504080.31851@jurand.ds.pg.gda.pl>
 <20040405141957.B31724@flint.arm.linux.org.uk>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Apr 2004, Russell King wrote:

> >  drivers/char/dz.[ch] has been verified to work on real hardware, at least 
> > with 2.4.  Can the same be said of drivers/serial/dz.[ch]?  If so, then 
> > the former can be removed from the mainline.
> 
> Ralf has verified that it works before he submitted it to Linus, so
> I guess that means that it does "work on real hardware".

 I see no problem then, though it's unfortunate I haven't got a note on
that.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
