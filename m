Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbUL2XDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbUL2XDg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 18:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbUL2XDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 18:03:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1699 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261436AbUL2XDf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 18:03:35 -0500
Date: Wed, 29 Dec 2004 23:03:34 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Norbert Tretkowski <tretkowski@inittab.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Patch: 2.6.10 - CMSPAR in mxser.c undeclared
Message-ID: <20041229230334.GO26051@parcelfarce.linux.theplanet.co.uk>
References: <20041229081957.GA31981@rollcage.inittab.de> <1104331638.30080.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104331638.30080.14.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2004 at 07:56:45PM +0000, Alan Cox wrote:
> On Mer, 2004-12-29 at 08:19, Norbert Tretkowski wrote:
> > {standard input}: Assembler messages:
> > {standard input}:5: Warning: setting incorrect section attributes for .got
> > drivers/char/mxser.c: In function `mxser_ioctl_special':
> > drivers/char/mxser.c:1564: error: `CMSPAR' undeclared (first use in this function)
> > drivers/char/mxser.c:1564: error: (Each undeclared identifier is reported only once
> > drivers/char/mxser.c:1564: error: for each function it appears in.)
> 
> What environment/architecture are you building this on (having built it
> myself just fine ?)

alpha or ppc, for example.
