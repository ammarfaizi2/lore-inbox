Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbVKTVXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbVKTVXM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 16:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbVKTVWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 16:22:48 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:60389 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750759AbVKTVWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 16:22:46 -0500
Date: Sat, 19 Nov 2005 23:51:39 +0000
From: Pavel Machek <pavel@suse.cz>
To: Rob Landley <rob@landley.net>
Cc: ncunningham@cyclades.com, Greg KH <greg@kroah.com>,
       Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051119235139.GD1952@spitz.ucw.cz>
References: <20051115212942.GA9828@elf.ucw.cz> <20051116061459.GA31181@kroah.com> <1132120845.25230.13.camel@localhost> <200511190332.29150.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511190332.29150.rob@landley.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > It's not duplicated, Nigel knows what need to be done to work together,
> > > if he so desires.
> >
> > I know that Pavel and I have such different ideas about what should be
> > done that it's not worth the effort.
> 
> So first it was Pavel and Patrick Mochel...
> 
> Then Pavel and Nigel...
> 
> Recently Dave Jones rumbled about a suspend fork...

Pavel and Patrick is solved, and there's no Pavel and Nigel... Its just Pavel
vs. way too much code. See my reply to Dave.

> You sure you software suspend guys haven't been hanging out with the IDE 
> maintainers?

:-)

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

