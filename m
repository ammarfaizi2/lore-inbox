Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265041AbTFCPMP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 11:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265042AbTFCPMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 11:12:15 -0400
Received: from air-2.osdl.org ([65.172.181.6]:6073 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265041AbTFCPMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 11:12:13 -0400
Date: Tue, 3 Jun 2003 08:25:05 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Henning Schmiedehausen <hps@intermeta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about style when converting from K&R to ANSI C.
Message-Id: <20030603082505.33bc3561.rddunlap@osdl.org>
In-Reply-To: <1054651445.25694.70.camel@forge.intermeta.de>
References: <1054446976.19557.23.camel@spc>
	<20030601132626.GA3012@work.bitmover.com>
	<1054519757.161606@palladium.transmeta.com>
	<20030603123256.GG1253@admingilde.org>
	<20030603124501.GB13838@suse.de>
	<bbi77j$mb3$1@tangens.hometree.net>
	<20030603133925.GG20413@holomorphy.com>
	<1054651445.25694.70.camel@forge.intermeta.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You did good (or even well considering that you are a
non-native speaker).  Yes, whitespace is a trivial problem.

~Randy


On 03 Jun 2003 16:44:05 +0200 Henning Schmiedehausen <hps@intermeta.de> wrote:

| The footnote was a non-native language speakers' attempt at self-irony.
| 
| If normal people think about development environments beyond vi, they
| would consider VisualStudio an improvement. Or eclipse.
| 
| Trust me, "whitespace" or "tabs" are the smallest of your problems
| there.
| 
| Ah well, silly me, trying humour on LKLM. ;-)
| 
| 	Regards
| 		Henning
| 
| 
| On Tue, 2003-06-03 at 15:39, William Lee Irwin III wrote:
| > On Tue, Jun 03, 2003 at 01:18:43PM +0000, Henning P. Schmiedehausen wrote:
| > > <sarcasm>
| > > Bah, all this newfangled crap like ctags. We've used grep for 30 years
| > > and there is no reason to change this now. 
| > > </sarcasm>
| > > Dave, the arguments some people bring to simply cling to their
| > > formatting reminds me of the arguments that the church had in the 14th
| > > century to still prove that the sun revolves around the earth. Simply
| > > ignore them. I'm grateful that there are programming environments
| > > beyond vi. [1] :-)
| > > 	Regards
| > > 		Henning
| > > [1] emacs 
| > 
| > Spraying garbage all over source code destroys editor agnosticism, even
| > if some editor exists that can hide all the crap like trailing
| > whitespace, spaces where tabs belong, and screwed-up indentation. Use
| > emacs all you want. Don't force others to use some particular editor by
| > spewing garbage all over the kernel source that requires some special
| > editor to hide.
| > 
| > 
| > -- wli
