Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbWBIIyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWBIIyp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 03:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965209AbWBIIyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 03:54:45 -0500
Received: from mail.gmx.net ([213.165.64.21]:45457 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750993AbWBIIyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 03:54:44 -0500
X-Authenticated: #14349625
Subject: Re: [k2.6.16-rc1-mm5] kernel BUG at include/linux/mm.h:302!
From: MIke Galbraith <efault@gmx.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <43EAFF6D.1040604@yahoo.com.au>
References: <1139473463.8028.13.camel@homer> <43EAFF6D.1040604@yahoo.com.au>
Content-Type: text/plain
Date: Thu, 09 Feb 2006 09:59:30 +0100
Message-Id: <1139475570.8418.5.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-09 at 19:38 +1100, Nick Piggin wrote:
> MIke Galbraith wrote:
> > Greetings,
> > 
> > Excuse me if this is already known, I've been too busy tinkering to read
> > lkml.
> > 
> 
> It should be fixed as of current -git (not sure about the latest
> -mm though). It would be good if you could verify that 2.6.16-rc2-git7
> works OK for you.

Well shoot.  I'd be happy to if I could find it.  That extension makes
me suspect I need to gitified to get there from here.  Yes?  I'm more
accustomed to digging bits and pieces out of mondo patches... no SCM
thingies here.

	-Mike  (SCM wimp)

