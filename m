Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbUDHVX5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 17:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbUDHVX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 17:23:57 -0400
Received: from mail1.mail.iol.ie ([193.120.142.151]:21638 "EHLO
	mail1.mail.iol.ie") by vger.kernel.org with ESMTP id S262438AbUDHVXz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 17:23:55 -0400
Date: Thu, 8 Apr 2004 22:23:50 +0100
From: Kenn Humborg <kenn@linux.ie>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: Re: drivers/char/dz.[ch]: reason for keeping?
Message-ID: <20040408212350.GA30123@excalibur.research.wombat.ie>
References: <20040404101241.A10158@flint.arm.linux.org.uk> <20040404111712.GE27362@lug-owl.de> <20040404122958.A14991@flint.arm.linux.org.uk> <20040404120051.GF27362@lug-owl.de> <Pine.LNX.4.55.0404071304170.5705@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0404071304170.5705@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 01:16:48PM +0200, Maciej W. Rozycki wrote:
> On Sun, 4 Apr 2004, Jan-Benedict Glaw wrote:
> > Old ./drivers/char/dz.c + VAX changes + SERIO changes, that is :)  I
> > guess best practice is that VAX people first merge up with MIPS folks,
> > then we snatch the old driver together and have a beer...
> 
>  It sounds like a plan. :-)

Sorry for coming in late on this.

There is no problem with dropping drivers/char/dz.[ch] from the official
tree.  Us Linux/VAX guys work off our own CVS tree on SourceForge, so we
can continue to carry the drivers/char/dz.[ch] until we've got the
new driver working.

So, Jan-Benedict, there is no major panic to get the new driver working
for us before Rusty/Linus remove the old one.

Later,
Kenn (another Linux/VAX guy)

