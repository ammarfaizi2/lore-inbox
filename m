Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbTJEBFy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 21:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbTJEBFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 21:05:54 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:13507 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S262848AbTJEBFx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 21:05:53 -0400
Date: Sat, 4 Oct 2003 18:05:21 -0700
From: Larry McVoy <lm@bitmover.com>
To: Rob Landley <rob@landley.net>
Cc: andersen@codepoet.org, "Henning P. Schmiedehausen" <hps@intermeta.de>,
       Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
Message-ID: <20031005010521.GA21138@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rob Landley <rob@landley.net>, andersen@codepoet.org,
	"Henning P. Schmiedehausen" <hps@intermeta.de>,
	Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
References: <20030914064144.GA20689@codepoet.org> <bk30f1$ftu$2@tangens.hometree.net> <20030915055721.GA6556@codepoet.org> <200310041952.09186.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310041952.09186.rob@landley.net>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.3,
	required 7, AWL)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 04, 2003 at 07:52:09PM -0500, Rob Landley wrote:
> On Monday 15 September 2003 00:57, Erik Andersen wrote:
> > On Mon Sep 15, 2003 at 12:17:37AM +0000, Henning P. Schmiedehausen wrote:
> > > Erik Andersen <andersen@codepoet.org> writes:
> > > >When you are done making noise, please explain how a closed
> > > >source binary only product that runs within the context of the
> > > >Linux kernel is not a derivitive work and therefore not subject
> > > >to the terms of the GPL, per the definition given in the kernel
> > > >COPYING file that grants you your limited rights for copying,
> > > >distribution and modification.
> > >
> > > "Because Linus said so".
> >
> > It does not say "Because Linus said so" in the Linux kernel
> > COPYING file, which is the only official document that grants
> > legal permission to copy, distribute and/or modify the kernel.
> 
> Linus clearly and publicly stated his position on binary only kernel modules 
> almost exactly one year ago:

Yeah, but Linus stating his position about a license doesn't mean diddly.
The kernel is licensed under a license, that license is a contract that
people enter into.  To the extent that it is enforceable, that license
determines what happens, Linus can't retroactively decide to interpret
the license a different way.  The license can't enforce things which
the law doesn't allow.  In particular, the law understands a concept of
a boundary.  And Linus' comments notwithstanding, modules are a pretty
clear boundary.  Even the GPL acks this, it knows that anything which
is clearly separable is not covered.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
