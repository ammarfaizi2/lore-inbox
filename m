Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWBBQUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWBBQUZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 11:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbWBBQUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 11:20:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37537 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932122AbWBBQUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 11:20:22 -0500
Date: Thu, 2 Feb 2006 08:19:44 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Pierre Ossman <drzeus-list@drzeus.cx>, Karim Yaghmour <karim@opersys.com>,
       Filip Brcic <brcha@users.sourceforge.net>,
       Glauber de Oliveira Costa <glommer@gmail.com>,
       Thomas Horsten <thomas@horsten.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
In-Reply-To: <1138891081.9861.4.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0602020814320.21884@g5.osdl.org>
References: <Pine.LNX.4.40.0601280826160.29965-100000@jehova.dsm.dk> 
 <43DE57C4.5010707@opersys.com>  <5d6222a80601301143q3b527effq526482837e04ee5a@mail.gmail.com>
  <200601302301.04582.brcha@users.sourceforge.net>  <43E0E282.1000908@opersys.com>
  <Pine.LNX.4.64.0602011414550.21884@g5.osdl.org>  <43E1C55A.7090801@drzeus.cx>
  <Pine.LNX.4.64.0602020044520.21884@g5.osdl.org> <1138891081.9861.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Feb 2006, Alan Cox wrote:

> On Iau, 2006-02-02 at 01:00 -0800, Linus Torvalds wrote:
> > Sure, DRM may mean that you can not _install_ or _run_ your changes on 
> > somebody elses hardware. 
> 
> Last time I checked the Xbox was owned by the person who bought it. Xbox
> Linux hits this problem today. So it may affect "your hardware" too
> unless you make hardware, which is an unusual and privileged position.

Ok, now replace "hardware" by "software", and replace DRM by 
"proprietary", and what's the difference?

The fact is, if you buy proprietary software, you cannot make it do 
everything you want, regardless of of whether you "own" it or not. The 
creator of the software may have designed it so that it only does certain 
things.

Tough. The solution: use open source software.

The same holds true for hardware. If you buy proprietary hardware, you 
cannot make it do everything you want, whether you "own" it or not. The 
manufacturer of the hardware may have designed it so that it only does 
certain things.

Tough. The solution: use open hardware.

The solution is NOT to create a software license that is obviously not 
usable. And the GPLv3 really _is_ obviously not usable for the kernel, 
because it creates insane situations whether the hardware is open or 
closed.

In other words, the problem you state is a problem. But it has nothing to 
do with the GPLv3.

			Linus
