Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVDMK6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVDMK6k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 06:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVDMK6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 06:58:40 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:50475
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261291AbVDMK6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 06:58:38 -0400
Date: Wed, 13 Apr 2005 12:59:44 +0200
From: Andrea Arcangeli <andrea@cpushare.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Eger <eger@havoc.gtf.org>, Petr Baudis <pasky@ucw.cz>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: more git updates..
Message-ID: <20050413105944.GN1521@opteron.random>
References: <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050412040519.GA17917@havoc.gtf.org> <20050412081613.GA18545@pasky.ji.cz> <20050412204429.GA24910@havoc.gtf.org> <Pine.LNX.4.58.0504121411030.4501@ppc970.osdl.org> <20050412234005.GJ1521@opteron.random> <Pine.LNX.4.58.0504121644430.4501@ppc970.osdl.org> <20050413001408.GL1521@opteron.random> <Pine.LNX.4.58.0504121809380.4501@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504121809380.4501@ppc970.osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 06:10:27PM -0700, Linus Torvalds wrote:
> Go wild. I did mine in six days, and you've been whining about other 
> peoples SCM's for three years.

Even if I spend 6 days doing git, you'd never have thrown away BK in
exchange for git.

> In other words - go and _do_ something instead of whining. I'm not 
> interested.

CVS and SVN are already an order of magnitude more efficient than git at
storing and exporting the data and they shouldn't annoy you during the
checkins either, they have a backend much more efficient than git too,
and yet you seem not to care about them.

My suggestion was simply to at least change git to coalesce the diffs
like CVS/SCCS, I'm only making a suggestion to give git a chance to have
a backend at least as efficient as the one that CVS uses and to avoid
running rsync on a 2.8G uncompressible blob. I don't have enough spare
time to do something myself, my spare time would be too short anyway to
make a difference in SCM space, so I'd rather spend it all in more
innovative space where it might have a slight change to make a
difference.
