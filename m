Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVCEVQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVCEVQH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 16:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVCEVQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 16:16:06 -0500
Received: from fire.osdl.org ([65.172.181.4]:37780 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261169AbVCEVP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 16:15:59 -0500
Date: Sat, 5 Mar 2005 13:17:28 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       chrisw@osdl.org
Subject: Re: Linux 2.6.11.1
In-Reply-To: <20050305174654.J3282@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0503051316510.2304@ppc970.osdl.org>
References: <20050304175302.GA29289@kroah.com> <20050304124431.676fd7cf.akpm@osdl.org>
 <20050304205842.GA32232@kroah.com> <20050304131537.7039ca10.akpm@osdl.org>
 <Pine.LNX.4.58.0503041353050.11349@ppc970.osdl.org> <20050304135933.3a325efc.akpm@osdl.org>
 <20050304220518.GC1201@kroah.com> <20050305095139.A26541@flint.arm.linux.org.uk>
 <4229EA0A.8010608@pobox.com> <Pine.LNX.4.58.0503050930430.2304@ppc970.osdl.org>
 <20050305174654.J3282@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 5 Mar 2005, Russell King wrote:
>
> On Sat, Mar 05, 2005 at 09:40:59AM -0800, Linus Torvalds wrote:
> > I love BK, but what BK does well is merging and maintaining trees full of 
> > good stuff. What BK sucks at is experimental stuff where you don't know 
> > whether something should be eventually used or not.
> 
> Wait a minute - why would stuff going into 2.6.x.y be "experimental"
> stuff?  Wasn't stability the whole point of this tree?

The point being that _before_ a patch gets accepted, it's in that "limbo" 
state, waiting for people to veto it or say "yes".

That limbo state is not well done with BK. 

		Linus
