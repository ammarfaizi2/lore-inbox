Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVF0PNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVF0PNa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 11:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVF0PGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 11:06:00 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:42506 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261751AbVF0OSw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 10:18:52 -0400
Date: Mon, 27 Jun 2005 15:18:50 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: IDE - sensible probing for PCI systems
In-Reply-To: <42BC8C10.1040604@pobox.com>
Message-ID: <Pine.LNX.4.61L.0506271516270.23903@blysk.ds.pg.gda.pl>
References: <1119356601.3279.118.camel@localhost.localdomain> 
 <Pine.LNX.4.61L.0506211422190.9446@blysk.ds.pg.gda.pl> 
 <1119363150.3325.151.camel@localhost.localdomain> 
 <Pine.LNX.4.61L.0506211535100.17779@blysk.ds.pg.gda.pl> 
 <1119379587.3325.182.camel@localhost.localdomain> 
 <Pine.LNX.4.61L.0506231903170.31113@blysk.ds.pg.gda.pl>
 <1119566026.18655.30.camel@localhost.localdomain>
 <Pine.LNX.4.61L.0506241217490.28452@blysk.ds.pg.gda.pl> <42BC8C10.1040604@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jun 2005, Jeff Garzik wrote:

> > Well, keyboard and mouse are USB these days, serial and parallel are PCI,
> > floppies are not used anymore and the ISA DMA controller would only be 
> 
> Oh, how I wish this were true!
> 
> The pre-production machines I get (i.e. not even on the market yet) still have
> floppy, serial, and PS/2 kbd/mouse.

 You must be getting them from wrong vendors. ;-)  How about switching to 
a reasonable platform that doesn't imply DOS compatibility?

  Maciej
