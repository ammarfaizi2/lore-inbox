Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbUL3APy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbUL3APy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 19:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbUL3APx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 19:15:53 -0500
Received: from ridcully.inittab.de ([213.146.113.136]:15572 "EHLO
	mail1.inittab.de") by vger.kernel.org with ESMTP id S261469AbUL3APd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 19:15:33 -0500
Date: Thu, 30 Dec 2004 01:15:27 +0100
From: Norbert Tretkowski <tretkowski@inittab.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Patch: 2.6.10 - CMSPAR in mxser.c undeclared
Message-ID: <20041230001527.GA32554@rollcage.inittab.de>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20041229081957.GA31981@rollcage.inittab.de> <1104331638.30080.14.camel@localhost.localdomain> <20041229230334.GO26051@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041229230334.GO26051@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Al Viro wrote:
> On Wed, Dec 29, 2004 at 07:56:45PM +0000, Alan Cox wrote:
> > On Mer, 2004-12-29 at 08:19, Norbert Tretkowski wrote:
> > > {standard input}: Assembler messages:
> > > {standard input}:5: Warning: setting incorrect section attributes for .got
> > > drivers/char/mxser.c: In function `mxser_ioctl_special':
> > > drivers/char/mxser.c:1564: error: `CMSPAR' undeclared (first use in this function)
> > > drivers/char/mxser.c:1564: error: (Each undeclared identifier is reported only once
> > > drivers/char/mxser.c:1564: error: for each function it appears in.)
> > 
> > What environment/architecture are you building this on (having built it
> > myself just fine ?)
> 
> alpha or ppc, for example.

Yes, alpha.

Norbert
