Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbVH2MZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbVH2MZp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 08:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbVH2MZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 08:25:45 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:23702 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751180AbVH2MZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 08:25:45 -0400
Date: Mon, 29 Aug 2005 14:25:13 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.13
Message-ID: <20050829122513.GD17088@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.58.0508281708040.3243@g5.osdl.org> <1125313050.5611.11.camel@localhost.localdomain> <1125317850.6496.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1125317850.6496.7.camel@localhost>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 August 2005 22:17:30 +1000, Nigel Cunningham wrote:
> On Mon, 2005-08-29 at 20:57, Steven Rostedt wrote:
> > On Sun, 2005-08-28 at 17:17 -0700, Linus Torvalds wrote:
> > 
> > > 
> > > Paul Mackerras:
> > >   Remove race between con_open and con_close
> > 
> > Hey, I'm the first to report this with the fix and Paul gets the credit?
> > I guess I'll crawl back to my little world (RT) where they actually
> > appreciate me. :-(
> 
> Did you report it or fix it? :>

Doesn't really matter to me.  A good bug report is often 90% of the
work, with the actual fix falling into the misc. category.  Testers
really deserve some credit.  ;)

Ok, many bug reports are also quite useless.  Good testers therefore
deserve even more credit.

Jörn

-- 
The competent programmer is fully aware of the strictly limited size of
his own skull; therefore he approaches the programming task in full
humility, and among other things he avoids clever tricks like the plague. 
-- Edsger W. Dijkstra
