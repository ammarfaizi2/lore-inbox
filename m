Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbTIALRf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 07:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbTIALRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 07:17:35 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:63105 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261337AbTIALRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 07:17:34 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Petr Baudis <pasky@ucw.cz>, linux-fbdev-users@lists.sourceforge.net,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0309011051560.5048-100000@waterleaf.sonytel.be>
References: <Pine.GSO.4.21.0309011051560.5048-100000@waterleaf.sonytel.be>
Message-Id: <1062415038.4073.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 01 Sep 2003 13:17:18 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: [Linux-fbdev-users] Re: Total radeonfb failure on both
	2.6.0-test4 and 2.6.0-test4-mm4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> > I'm working on a new driver for 2.6 that include my 2.4 updates, a
> > slightly reworked version of Kronos and Jon i2c DDC code and some
> > more source cleanup (split the driver in separate files actually).
> > 
> > It's not finished yet though. I'm not yet sure I'll add support for
> > dual head in the first version neither, all of this pretty much depends
> > on how much time I'll be able to dedicate to it during the upcoming
> > week.
> 
> What about `release early, release often', and add the dual-head support after
> your first release? ;-)

Yup, I'll probably do just that, but still, there is work to get
to the first release...

Ben.


