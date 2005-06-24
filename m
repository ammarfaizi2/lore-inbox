Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263266AbVFXWmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263266AbVFXWmT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 18:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263282AbVFXWmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 18:42:02 -0400
Received: from mail.dvmed.net ([216.237.124.58]:12229 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S263266AbVFXWlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 18:41:25 -0400
Message-ID: <42BC8C10.1040604@pobox.com>
Date: Fri, 24 Jun 2005 18:41:20 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: IDE - sensible probing for PCI systems
References: <1119356601.3279.118.camel@localhost.localdomain>  <Pine.LNX.4.61L.0506211422190.9446@blysk.ds.pg.gda.pl>  <1119363150.3325.151.camel@localhost.localdomain>  <Pine.LNX.4.61L.0506211535100.17779@blysk.ds.pg.gda.pl>  <1119379587.3325.182.camel@localhost.localdomain>  <Pine.LNX.4.61L.0506231903170.31113@blysk.ds.pg.gda.pl> <1119566026.18655.30.camel@localhost.localdomain> <Pine.LNX.4.61L.0506241217490.28452@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.61L.0506241217490.28452@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:
>  Well, keyboard and mouse are USB these days, serial and parallel are PCI, 
> floppies are not used anymore and the ISA DMA controller would only be 

Oh, how I wish this were true!

The pre-production machines I get (i.e. not even on the market yet) 
still have floppy, serial, and PS/2 kbd/mouse.

	Jeff


