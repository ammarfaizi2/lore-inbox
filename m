Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWGXKcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWGXKcy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 06:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWGXKcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 06:32:54 -0400
Received: from mail.gmx.de ([213.165.64.21]:43992 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932104AbWGXKcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 06:32:53 -0400
X-Authenticated: #428038
Date: Mon, 24 Jul 2006 12:32:50 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Hans Reiser <reiser@namesys.com>
Cc: Matthias Andree <matthias.andree@gmx.de>, Jeff Garzik <jeff@garzik.org>,
       Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060724103250.GB26553@merlin.emma.line.org>
Mail-Followup-To: Hans Reiser <reiser@namesys.com>,
	Jeff Garzik <jeff@garzik.org>, Theodore Tso <tytso@mit.edu>,
	LKML <linux-kernel@vger.kernel.org>
References: <44C12F0A.1010008@namesys.com> <20060722130219.GB7321@thunk.org> <44C26F65.4000103@namesys.com> <44C28A8F.1050408@garzik.org> <20060724084133.GC24299@merlin.emma.line.org> <44C48043.7010708@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C48043.7010708@namesys.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12 (2006-07-17)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2006, Hans Reiser wrote:

> I mean, god, sometimes I think users are like little children waiting
> for the pie that is in the oven and who want to take it out now before
> it finishes cooking so they can eat it, and they are very angry about
> it, and I should just understand that and not try to reason with it (but
> also not give them the pie before it finishes cooking either).   Someone
> please tell me I don't understand the users and it all makes more sense
> than that, please....

namesys.com doesn't list reiserfs 3.6 hash collision limits in an easy
to find place (which would be the same place that boasts about 100,000
files per directory if it wants to be honest).

> No code before its time.  No features in stable branches.  Wait for it. 
> Stop complaining about how you are abandoned, we are working hard.  It's
> going to be the best pie ever.  Wait for it.

I'm not going to eat it while it's still steaming and fogging my glasses.

You're now making the same noise about how good reiser4 is that was made
when reiserfs 3.5 was a patch for Linux 2.2 and that wedged local access
when NFS exported, and 3.6 didn't fix the hash collision issue (but
required a format change, too, right).

-- 
Matthias Andree
