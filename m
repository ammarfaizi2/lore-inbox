Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264772AbTFLHIL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 03:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264782AbTFLHIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 03:08:11 -0400
Received: from ip-86-245.evc.net ([212.95.86.245]:23193 "EHLO hal9003.1g6.biz")
	by vger.kernel.org with ESMTP id S264772AbTFLHIB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 03:08:01 -0400
From: Nicolas <linux@1g6.biz>
Organization: 1G6
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: 536EP linux winmodem
Date: Thu, 12 Jun 2003 09:24:30 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <Sea2-F56iZAtGYkNUTv0001fda1@hotmail.com> <200306101642.05357.linux@1g6.biz> <20030611195403.GB477@elf.ucw.cz>
In-Reply-To: <20030611195403.GB477@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200306120924.30928.linux@1g6.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



You have access to a part of the sources :(

http://linmodems.technion.ac.il/packages/Intel/

but there is a big "536epcore.lib", 
I don't know if it is workable in a 2.5 kernel ...
I was just trying to compile the source part and it doesn't
because of irq related stuffs at this time.

Maybe I'm too naive, and 
536epcore.lib is a big problem...

Nicolas.

Le Mercredi 11 Juin 2003 21:54, Pavel Machek a écrit :
> Hi!
>
> > Sorry to disturb with a winmodem ...
> > don't flame me please !
> >
> > Is there somebody having a working 536EP linux modem driver
> > on 2.5.xx series ?, I began to port the old
> > driver but with many irq problems related stuff, just
> > compilation stage at this time ... :(
>
> Do you have driver sources?
> 								Pavel
>
> > 00:0a.0 Communication controller: Intel Corp. 536EP Data Fax Modem
> >         Subsystem: Creatix Polymedia GmbH V.9X DSP Data Fax Modem
> >         Flags: bus master, medium devsel, latency 32, IRQ 17
> >         Memory at e8000000 (32-bit, non-prefetchable) [size=4M]
> >         Capabilities: <available only to root>

