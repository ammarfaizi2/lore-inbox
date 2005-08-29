Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbVH2M3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbVH2M3U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 08:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbVH2M3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 08:29:20 -0400
Received: from [203.171.93.254] ([203.171.93.254]:13263 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1751183AbVH2M3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 08:29:19 -0400
Subject: Re: Linux 2.6.13
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050829122513.GD17088@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.58.0508281708040.3243@g5.osdl.org>
	 <1125313050.5611.11.camel@localhost.localdomain>
	 <1125317850.6496.7.camel@localhost>
	 <20050829122513.GD17088@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=iso-8859-1
Organization: Cyclades
Message-Id: <1125318484.6496.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 29 Aug 2005 22:28:04 +1000
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-08-29 at 22:25, Jörn Engel wrote:
> On Mon, 29 August 2005 22:17:30 +1000, Nigel Cunningham wrote:
> > On Mon, 2005-08-29 at 20:57, Steven Rostedt wrote:
> > > On Sun, 2005-08-28 at 17:17 -0700, Linus Torvalds wrote:
> > > 
> > > > 
> > > > Paul Mackerras:
> > > >   Remove race between con_open and con_close
> > > 
> > > Hey, I'm the first to report this with the fix and Paul gets the credit?
> > > I guess I'll crawl back to my little world (RT) where they actually
> > > appreciate me. :-(
> > 
> > Did you report it or fix it? :>
> 
> Doesn't really matter to me.  A good bug report is often 90% of the
> work, with the actual fix falling into the misc. category.  Testers
> really deserve some credit.  ;)
> 
> Ok, many bug reports are also quite useless.  Good testers therefore
> deserve even more credit.

That's true. A bug report that tells me exactly what I need to do to
reproduce the issue is better than gold.

Regards,

Nigel

> Jörn
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

