Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262816AbVA1TlC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262816AbVA1TlC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 14:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbVA1ThH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 14:37:07 -0500
Received: from colo.lackof.org ([198.49.126.79]:3286 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S262766AbVA1Teo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 14:34:44 -0500
Date: Fri, 28 Jan 2005 12:34:57 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Grant Grundler <grundler@parisc-linux.org>, Jesse Barnes <jbarnes@sgi.com>,
       Greg KH <greg@kroah.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Matthew Wilcox <matthew@wil.cx>,
       linux-pci@atrey.karlin.mff.cuni.cz, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Patch to control VGA bus routing and active VGA device.
Message-ID: <20050128193457.GC32135@colo.lackof.org>
References: <9e47339105011719436a9e5038@mail.gmail.com> <20050125042459.GA32697@kroah.com> <9e473391050127015970e1fedc@mail.gmail.com> <200501270828.43879.jbarnes@sgi.com> <20050128173222.GC30791@colo.lackof.org> <9e47339105012810362a0a7018@mail.gmail.com> <20050128191549.GA32135@colo.lackof.org> <9e4733910501281126423ed066@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910501281126423ed066@mail.gmail.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 02:26:40PM -0500, Jon Smirl wrote:
> Next year we are going to see a lot of multiple VGAs. Depending on
> configuration the Nvidia4 chipset can support from one up to eight PCI
> Express video cards simultaneously.

Oh geez....someone is going to implement IO port space on PCI express device?!

/me gets out the cluebat...

grant
