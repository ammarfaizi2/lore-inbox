Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbTDZQMD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 12:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbTDZQMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 12:12:03 -0400
Received: from [81.80.245.157] ([81.80.245.157]:45189 "EHLO smtp.alcove-fr")
	by vger.kernel.org with ESMTP id S261814AbTDZQMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 12:12:02 -0400
Date: Sat, 26 Apr 2003 18:23:23 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Ben Collins <bcollins@debian.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The IEEE-1394 saga continued... [ was: IEEE-1394 problem on init ]
Message-ID: <20030426162323.GD18917@vitel.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Ben Collins <bcollins@debian.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030423142353.GL354@phunnypharm.org> <20030423145122.GL820@hottah.alcove-fr> <20030423144857.GN354@phunnypharm.org> <20030423152914.GM820@hottah.alcove-fr> <Pine.LNX.4.53L.0304231609230.5536@freak.distro.conectiva> <20030423202002.GA10567@vitel.alcove-fr> <20030423202453.GA354@phunnypharm.org> <20030423204258.GB10567@vitel.alcove-fr> <20030426082956.GB18917@vitel.alcove-fr> <20030426144017.GD2774@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030426144017.GD2774@phunnypharm.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 26, 2003 at 10:40:18AM -0400, Ben Collins wrote:

> > Since I reported issues about this 3 days ago, I would have appreciated
> > being CC:'ed on the patch mail, so I could have reported issues 
> > like this _before_ such a patch being applied. 
> 
> BTW, there are atleast 2 dozen people looking for this patch. I tested
> it and several others on the linux1394 mailing list tested it. If you
> want to be more closely involved with linux1394 specifically, then don't
> expect me to search you out...

So if I report a bug I must be subscribed to your list to get the answer,
that's it ? 

You don't have to 'come search me out'. *I* sent you a bug report, the least
you could do is to CC: me on the answers. (Or gently tell me that this is
a known bug being discussed on your list and inviting me to go there to
find the answers).

> come to us where our development happens.
> We have a commit list to the repo and a developers list.

As I said in the previous mail, I did check the archives and saw nothing
trivially relevant. But of course, I could have missed something.

> I've never sent my patches to the list prior to inclusion in the kernel,
> and a lot of folks don't, depending on neccessity. I don't see the need
> to start now, not when interested parties have a place to go to see the
> patches before hand anyway.

Keeping the development discussions on your own list is of course ok,
but I believe posting an announce on lkml each time you send something
for inclusion in the main kernel would be a good idea. Especially when
you're not sending patches every day and when your patches tend to be
considerably big.

This is what (a lot of) other subsystem maintainers do.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
