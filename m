Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266590AbTGKAlJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 20:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269709AbTGKAlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 20:41:09 -0400
Received: from dp.samba.org ([66.70.73.150]:62414 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266590AbTGKAlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 20:41:07 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16142.2842.795232.351128@cargo.ozlabs.ibm.com>
Date: Fri, 11 Jul 2003 10:55:54 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.75
In-Reply-To: <Pine.LNX.4.44.0307101709360.5091-100000@home.osdl.org>
References: <p73isqaos29.fsf@oldwotan.suse.de>
	<Pine.LNX.4.44.0307101709360.5091-100000@home.osdl.org>
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> On 11 Jul 2003, Andi Kleen wrote:
> >
> > Linus Torvalds <torvalds@osdl.org> writes:
> > > 
> > > Also, the only real point of a stable release is for distribution makers.
> > > That pretty much cuts the list of "needs to be supported" down to x86,
> > > ia64, x86-64 and possibly sparc/alpha.
> > 
> > No ppc, ppc64, s390?
> 
> Do we have distributions that intend to make releases using those? I
> suspect not, but hey, don't get me wrong: I'd love to see them working
> out-of-the-box.

SuSE has a ppc64 version of their enterprise server edition and I
think they include ppc32 kernels too.  Terrasoft does a distribution
aimed at powermac users.  Mandrake and Gentoo have ppc versions of
their distributions.  And of course there is Debian/PPC, which is what
I use.  I think ppc and ppc64 have well and truly eclipsed alpha and
sparc, in terms of the size of the market for distributions, by now.

In fact ppc and ppc64 are in pretty good shape in your tree as far as
the desktop and server machines are concerned.

Paul.
