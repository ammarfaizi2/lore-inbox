Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271201AbTGWSvF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 14:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271213AbTGWSvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 14:51:05 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:57106
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S271201AbTGWSvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 14:51:00 -0400
Date: Wed, 23 Jul 2003 11:58:06 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Erik Andersen <andersen@codepoet.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Promise SATA driver GPL'd
In-Reply-To: <1058956331.5520.13.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10307231154110.13376-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

It is also more interesting that it has sensitive touch spots where they
state there is no problem and no errata.  So I am glad to see you have
stepped up to replace me, and don't be surprized when you hard lock the
card and the system because the feature does not exist.

This is the stuff nobody talks about and the value I added and created,
good luck in finding the folks who deploy various asics and are willing to
discuss in confidence solutions against the variations.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On 23 Jul 2003, Alan Cox wrote:

> On Mer, 2003-07-23 at 02:59, Andre Hedrick wrote:
> > I have already cut all ties with Promise so here is the deal.
> > I no longer have to count the number of fingers on my hand between hand
> > shakes.  IE no extras and not shortages.
> 
> Thats ok - now they are doing GPL drivers themselves they don't need
> you any more.
> 
> Promise did a SCSI CAM driver because their hardware can queue commands
> without TCQ - which drivers/ide can't cope with. Otherwise I'd just have
> used the same type of changes the FreeBSD people did for 2037x.
> 
> Its also interesting because it has a hardware XOR engine.
> 

