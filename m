Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289098AbSBISMp>; Sat, 9 Feb 2002 13:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289055AbSBISMf>; Sat, 9 Feb 2002 13:12:35 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:46090 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S289098AbSBISMU>; Sat, 9 Feb 2002 13:12:20 -0500
Date: Sat, 9 Feb 2002 19:12:13 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Andreas Dilger <adilger@turbolabs.com>
Subject: Re: pull vs push (was Re: [bk patch] Make cardbus compile in -pre4)
Message-ID: <20020209181213.GA32401@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <Pine.LNX.4.33.0202081824070.25114-100000@segfault.osdlab.org> <20020208203931.X15496@lynx.turbolabs.com> <20020209092607.UHF12059.femail26.sdc1.sfba.home.com@there> <20020209030825.A9826@lynx.turbolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020209030825.A9826@lynx.turbolabs.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2002 at 03:08:25AM -0700, Andreas Dilger wrote:

> OK, so Linus has been using BK for a couple of weeks now, and some of the
> lieutenants have started setting up BK repositories at bkbits.net.  Is
> there _any_ way that one can understand the heirarchy of repositories
> at bkbits.net?  There's "linus", "linux", "linux25", and a bunch of other
> obvious branch repositories.  Which one should kernel developers
> clone/pull from?  It would be nice if there was a heirarchy or something
> which showed the parent-child relationship.

The 'linus' one seems to be the parent, because if I try to pull from
it bk tells me that the tree is for the private use of Linus only.

And all the other 2.5 repositories seem to be slighly out of date
(the linux/linux-2.5 one is at -pre3 instead of -pre5 etc).

So, what is supposed to be the definitive, public bk repository, 
to pull from in order to have the latest changes ? (the one which will
go on bk.kernel.org eventually) 

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
