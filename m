Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbTJETuk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 15:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbTJETuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 15:50:40 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:29714
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263795AbTJETuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 15:50:39 -0400
Date: Sun, 5 Oct 2003 12:47:41 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Maciej Zenczykowski <maze@cela.pl>
cc: David Woodhouse <dwmw2@infradead.org>, Rob Landley <rob@landley.net>,
       "Henning P. Schmiedehausen" <hps@intermeta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
In-Reply-To: <Pine.LNX.4.44.0310052120440.12277-100000@gaia.cela.pl>
Message-ID: <Pine.LNX.4.10.10310051242550.21746-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Usage of the kernel headers only, is using the effective API for that
snapshot.  It is clear in many copyright cases under the terms of fair use
and reverse engineering to obtain operational functionality is legal and
upheld.

Touching or using copied C-code is fatal.

Reading the C-code and creating another work which is identical in
functionality and completely original, it is not derived regardless what
anybody thinks or tells you.  GPL only protects the actual file or
document.  It is a total waste on protecting the content expressed.

People confuse the two, and must admit I did so in the past.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Sun, 5 Oct 2003, Maciej Zenczykowski wrote:

> > You are so young and fresh to the game, it is cute.
> > 
> > http://www.gcom.com/home/support/whitepapers/linux-gnu-license.html
> 
> Can a module even be considered LGPL?  After all a module interfaces with
> the kernel via including files from the kernel source - doesn't this
> automatically mean that it is a derived work of at least a few of the
> kernel headers (the module specific ones for example).  These headers
> contribute code to the module as well: INC_MOD_USE_COUNT and the like...
> And since the kernel is GPLed doesn't this mean that the entire module is
> GPLed?
> 
> On the other hand any running program on linux dynamically links (via 
> syscalls) against the kernel... I think everyone agrees that dynamically 
> linking against the kernel in this manner should be allowed and not a 
> violation of the GPL of the kernel source...
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

