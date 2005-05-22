Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVEVSvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVEVSvd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 14:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVEVSvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 14:51:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32221 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261606AbVEVSvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 14:51:23 -0400
Subject: Re: When we detect that a 16550 was in fact part of a NatSemi
	SuperIO chip
From: Arjan van de Ven <arjan@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050522194438.A9854@flint.arm.linux.org.uk>
References: <200505220008.j4M08uE9025378@hera.kernel.org>
	 <1116763033.19183.14.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0505220953300.2307@ppc970.osdl.org>
	 <1116785646.6285.24.camel@laptopd505.fenrus.org>
	 <20050522194438.A9854@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Sun, 22 May 2005 20:51:17 +0200
Message-Id: <1116787877.6285.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-05-22 at 19:44 +0100, Russell King wrote:
> On Sun, May 22, 2005 at 08:14:06PM +0200, Arjan van de Ven wrote:
> > On Sun, 2005-05-22 at 09:59 -0700, Linus Torvalds wrote:
> > > 
> > > On Sun, 22 May 2005, David Woodhouse wrote:
> > > > 
> > > > Linus, please do not apply patches from me which have my personal
> > > > information mangled or removed.
> > > 
> > > I've asked Russell not to do it, but the fact is, he's worried about legal 
> > > issues, and while I've also tried to resolve those (by having the OSDL 
> > > lawyer try to contact some lawyers in the UK), that hasn't been clarified 
> > > yet.
> > 
> > there is a potential nasty interaction with the UK moral rights thing
> > where an author can demand that his authorship claim remains intact...
> > so if David objects to his authorship being mangled (and partially
> > removed) he may have a strong legal position to do so.
> 
> Actually, that only depends on whether you decide that Signed-off-by:
> reflects authorship.


author David Woodhouse <dwmw2@org.rmk.(none)> Sat, 21 May 2005 15:52:23 +0100

that looks far more like an authorship statement and is also munged.


