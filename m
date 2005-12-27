Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbVL0VED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbVL0VED (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 16:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbVL0VED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 16:04:03 -0500
Received: from mail.acc.umu.se ([130.239.18.156]:39328 "EHLO mail.acc.umu.se")
	by vger.kernel.org with ESMTP id S1751144AbVL0VEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 16:04:01 -0500
Date: Tue, 27 Dec 2005 22:03:59 +0100
From: David Weinehall <tao@acc.umu.se>
To: Alex Davis <alex14641@yahoo.com>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051227210359.GG20654@vasa.acc.umu.se>
Mail-Followup-To: Alex Davis <alex14641@yahoo.com>,
	Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
References: <20051216052913.GD30754@redhat.com> <20051216061605.46520.qmail@web50211.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051216061605.46520.qmail@web50211.mail.yahoo.com>
User-Agent: Mutt/1.4.2.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 10:16:05PM -0800, Alex Davis wrote:
> 
> 
> --- Dave Jones <davej@redhat.com> wrote:
> 
> > On Thu, Dec 15, 2005 at 09:20:54PM -0800, Alex Davis wrote:
> >  > The problem is that, with laptops, most of the time you DON'T
> >  > have a choice: HP and Dell primarily use a Broadcomm integrated
> >  > wireless card in ther products.  As of yet, there is no open
> >  > source driver for Broadcomm wireless.
> > 
> > We've already been through all this the previous times this came up.
> > 
> > http://bcm43xx.berlios.de
> > 
> > Whilst it's in early stages, it's making progress.
> > 
> > 		Dave
> > 
> > 
> I understand that, and am grateful for the effort, but the point is
> it's not ready. Are you expecting people to lose an important feature
> of their laptop until you get the driver ready? 

Yeah, it must be oh so important for the laptop owners with that
particular chipset to run the -mm experimental kernels instead of, their
distro kernel or the stable 2.6-kernel series or Linus latest
installment (or even a git-snapshot or checkout...)


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
