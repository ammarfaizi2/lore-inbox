Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264244AbTEOUMt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 16:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264245AbTEOUMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 16:12:49 -0400
Received: from palrel11.hp.com ([156.153.255.246]:10425 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S264244AbTEOUMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 16:12:47 -0400
Date: Thu, 15 May 2003 13:25:38 -0700
To: Greg KH <greg@kroah.com>
Cc: Martin Diehl <lists@mdiehl.de>, Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.69] rtnl-deadlock with usermodehelper and keventd
Message-ID: <20030515202538.GC18643@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <Pine.LNX.4.44.0305151443180.1435-100000@notebook.home.mdiehl.de> <20030515201255.GA18643@bougret.hpl.hp.com> <20030515201936.GA10591@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030515201936.GA10591@kroah.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 01:19:36PM -0700, Greg KH wrote:
> On Thu, May 15, 2003 at 01:12:55PM -0700, jt@bougret.hpl.hp.com wrote:
> > 	Greg,
> > 
> > 	This is a HotPlug problem, so would you mind forwarding this
> > to the relevant person and help Martin ?
> 
> But it's a networking subsystem hotplug problem, right?  That's way out
> of my league.

	That's why I say "forwarding", I know that we are all humans
after all ;-).

> I do agree it looks like a real problem, Martin did a great job in
> tracking this down.

	Yes, I'm glad he is back, that way I can dedicate a bit more
time to pending wireless stuff ;-)

> thanks,
> 
> greg k-h

	Jean
