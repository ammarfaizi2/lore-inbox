Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264926AbUEMUD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264926AbUEMUD0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 16:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265163AbUEMUCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 16:02:06 -0400
Received: from maxipes.logix.cz ([81.0.234.97]:6607 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S264926AbUEMUAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 16:00:14 -0400
Date: Thu, 13 May 2004 22:00:14 +0200 (CEST)
From: Michal Ludvig <michal@logix.cz>
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>, jmorris@redhat.com, davem@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Support for VIA PadLock crypto engine
In-Reply-To: <40A3C639.4FD98046@users.sourceforge.net>
Message-ID: <Pine.LNX.4.53.0405132157060.19062@maxipes.logix.cz>
References: <Xine.LNX.4.44.0405120933010.10943-100000@thoron.boston.redhat.com>
   <Pine.LNX.4.53.0405121546200.24118@maxipes.logix.cz>  
 <40A37118.ED58E781@users.sourceforge.net> <20040513113028.085194a3.akpm@osdl.org>
 <40A3C639.4FD98046@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2004, Jari Ruusu wrote:

> Andrew Morton wrote:
> > Jari Ruusu <jariruusu@users.sourceforge.net> wrote:
> > >  The cryptoloop implementation is busted in more than one way, so it is
> > >  useless for security needs:
> >
> > Is dm-crypt any better?
>
> Nope. dm-crypt has same exploitable cryptographic flaws.

Could you be more descriptive?

Michal Ludvig
-- 
* A mouse is a device used to point at the xterm you want to type in.
* Personal homepage - http://www.logix.cz/michal
