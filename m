Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270605AbTHORK0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 13:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270608AbTHORK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 13:10:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:27832 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270605AbTHORKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 13:10:22 -0400
Date: Fri, 15 Aug 2003 10:06:56 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Joshua Kwan <joshk@triplehelix.org>
Cc: ndiamond@wta.att.ne.jp, linux-kernel@vger.kernel.org
Subject: Re: Trying to run 2.6.0-test3
Message-Id: <20030815100656.19f1770f.rddunlap@osdl.org>
In-Reply-To: <20030815164300.GA31121@triplehelix.org>
References: <0a5b01c36305$4dec8b80$1aee4ca5@DIAMONDLX60>
	<20030815111442.A12422@flint.arm.linux.org.uk>
	<0d7c01c3632a$668da140$1aee4ca5@DIAMONDLX60>
	<20030815164300.GA31121@triplehelix.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Aug 2003 09:43:00 -0700 Joshua Kwan <joshk@triplehelix.org> wrote:

| On Fri, Aug 15, 2003 at 09:39:07PM +0900, Norman Diamond wrote:
| > I will do that in my next build.  For some reason I wasn't sure if yenta
| > would handle 16-bit cards.  But this turns out not to be necessary.  Also
| > the PCMCIA suggestions which Felipe Alfaro Solana suggested (the suggestions
| > which I intended to try) turned out not to be necessary.  The winner is the
| > next one:
| 
| Note that if you don't already have CONFIG_ISA enabled, 16-bit CardBus
| devices will refuse to work.

16-bit PCMCIA is ISA-like, 32-bit CardBus is basically PCI.
I've never heard of 16-bit CardBus.  Are there some?

--
~Randy
