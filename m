Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262416AbVBXQVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbVBXQVg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 11:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbVBXQVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 11:21:04 -0500
Received: from smtp10.wanadoo.fr ([193.252.22.21]:45152 "EHLO
	smtp10.wanadoo.fr") by vger.kernel.org with ESMTP id S262416AbVBXQQ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 11:16:28 -0500
X-ME-UUID: 20050224161606269.41B522800141@mwinf1007.wanadoo.fr
Date: Thu, 24 Feb 2005 17:06:57 +0100
To: Meelis Roos <mroos@linux.ee>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Tom Rini <trini@kernel.crashing.org>,
       linuxppc-dev@ozlabs.org, Sven Hartge <hartge@ds9.gnuu.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christian Kujau <evil@g-house.de>
Subject: Re: [PATCH 2.6.10-rc3][PPC32] Fix Motorola PReP (PowerstackII Utah) PCI IRQ map
Message-ID: <20050224160657.GB11197@pegasos>
References: <20041206185416.GE7153@smtp.west.cox.net> <Pine.SOC.4.61.0502221031230.6097@math.ut.ee> <20050224074728.GA31434@pegasos> <Pine.SOC.4.61.0502241746450.21289@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.SOC.4.61.0502241746450.21289@math.ut.ee>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 05:47:15PM +0200, Meelis Roos wrote:
> >Can you try :
> >
> > http://people.debian.org/~luther/d-i/images/daily/powerpc/netboot/vmlinuz-prep.initrd
> 
> Unfortunately there are only floppy and floppy-2.4 dirs under powerpc.

Oh, damn, need to fix my daily builder, should be ok for tomorrow. IN the
meanwhile, you can try : 

  http://people.debian.org/~luther/d-i/images/2005-02-23/powerpc/netboot/vmlinuz-prep.initrd

This is a zImage.prep kernel with builtin initrd, you just put it somewhere
where you can boot it from, usually a tftp server.

Friendly,

Sven Luther

