Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262746AbUJ0WxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbUJ0WxT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 18:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbUJ0WwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 18:52:11 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:28576 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262778AbUJ0Wtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 18:49:32 -0400
Subject: Re: BK kernel workflow
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@novell.com>,
       Larry McVoy <lm@work.bitmover.com>, Joe Perches <joe@perches.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.61.0410272049040.877@scrub.home>
References: <Pine.LNX.4.58.0410191510210.2317@ppc970.osdl.org>
	 <20041023161253.GA17537@work.bitmover.com>
	 <4d8e3fd304102403241e5a69a5@mail.gmail.com>
	 <20041024144448.GA575@work.bitmover.com>
	 <4d8e3fd304102409443c01c5da@mail.gmail.com>
	 <20041024233214.GA9772@work.bitmover.com>
	 <20041025114641.GU14325@dualathlon.random>
	 <1098707342.7355.44.camel@localhost.localdomain>
	 <20041025133951.GW14325@dualathlon.random>
	 <20041025162022.GA27979@work.bitmover.com>
	 <20041025164732.GE14325@dualathlon.random>
	 <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org>
	 <Pine.LNX.4.61.0410252350240.17266@scrub.home>
	 <Pine.LNX.4.58.0410251732500.427@ppc970.osdl.org>
	 <Pine.LNX.4.61.0410270223080.877@scrub.home>
	 <Pine.LNX.4.58.0410261931540.28839@ppc970.osdl.org>
	 <Pine.LNX.4.61.0410272049040.877@scrub.home>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098913524.7778.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 27 Oct 2004 22:45:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-10-27 at 21:56, Roman Zippel wrote:
> Linus, what happened to the early promises, that the data wouldn't be 
> locked into bk? Is the massively reduced data set in the cvs repository 
> really all we ever get out of it again?

The daily CVS snapshots seem to solve most of that. Yes BK's licensing
model isn't free software friendly, yes its a PITA. With the CVS
snapshots nobody is forcing your hand, its not encrypted and locked away
behind a DRM system.

Alan

