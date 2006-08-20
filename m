Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751740AbWHTWav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbWHTWav (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 18:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbWHTWav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 18:30:51 -0400
Received: from ns2.suse.de ([195.135.220.15]:15574 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751736AbWHTWau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 18:30:50 -0400
Date: Mon, 21 Aug 2006 00:30:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Greg KH <greg@kroah.com>
Cc: Adrian Bunk <bunk@stusta.de>, Josh Boyer <jwboyer@gmail.com>,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: Adrian Bunk is now taking over the 2.6.16-stable branch
Message-ID: <20060820223046.GB10011@opteron.random>
References: <20060803204921.GA10935@kroah.com> <625fc13d0608031943m7fb60d1dwb11092fb413f7fc3@mail.gmail.com> <20060804230017.GO25692@stusta.de> <20060806004634.GB6455@opteron.random> <20060806045234.GA28849@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060806045234.GA28849@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2006 at 09:52:34PM -0700, Greg KH wrote:
> Greg didn't "elect" anyone, Adrian volunteered to maintain something
> that had been dropped by the -stable developers and no one else was
> going to maintain.

Did you ever call for a maintainer list of volunteers?

To me an official 2.6.16-stable in the hands of the only guy who
proposed himself as maintainer, sounds worse than no stable tree at
all. People won't know anymore if to run Greg's 2.6.18-stable or
2.6.16-stable.

If a 2.6-real-stable tree has to happen because 2.6-stable is not
really stable/trustable enough, then give it up with your
2.6.18-stable and start doing 2.7 and leave 2.6 in the hands of
somebody else.

An official kernel needs a critical mass to have a value, it's simply
a wasted effort to open yet another official tree that will actually
fragment the "production" userbase even more.

If 2.6.18-stable is sustainable with the current model, with the
distro folks being the only ones forking off a real-stable tree, then
you should drop 2.6.16-stable. If instead it's 2.6.18-stable that is
not good enough for production usage and people really needs
2.6.16-stable, you should open 2.7, and not fragment the userbase like
this.

I think it would be great to have the users choosing their preferred
maintainer to end the era of maintainers being decided by other
maintainers like you actually did. A simple website on kernel.org can
achieve it, where users can registers for voting and the maintainers
willing to maintain 2.6-stable can registers themself too. That's at
least less random than the current status if what you said above is
true and if 2.6.16-stable is meant to reach any critical mass.
