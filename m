Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287255AbRL2XqI>; Sat, 29 Dec 2001 18:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287250AbRL2XqA>; Sat, 29 Dec 2001 18:46:00 -0500
Received: from ns.suse.de ([213.95.15.193]:48910 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287270AbRL2Xpo>;
	Sat, 29 Dec 2001 18:45:44 -0500
Date: Sun, 30 Dec 2001 00:45:41 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Stewart Smith <stewart@softhome.net>
Cc: <timothy.covell@ashavan.org>, <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Linux Bug Tracking & Feature Tracking DB
In-Reply-To: <5DF55AEA-FCB4-11D5-880A-00039350C45A@softhome.net>
Message-ID: <Pine.LNX.4.33.0112300038040.1336-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Dec 2001, Stewart Smith wrote:

> What about instead of tracking bugs and if they've been squashed. Why
> don't we build a database of known bugs with different kernel versions.
> i.e. You can go to the site and get a complete list of every single bug
> that people have entered about 2.0.36 you're still running on that box
> under the stairs.
> People could then 'vote' on the bug, so we could keep track of what's a
> big problem for a lot of people, and what's something that just one
> person found not to work.

Congratulations, you just invented bugzilla 8)
The only thing I dislike about bugzilla (and lookalikes) is that
someone has to go through them pruning them, updating them etc
and this is a lot of work.
Look at $vendor_of_choice's bugzilla entry for the kernel.
You'll see hundreds, nay, thousands of reports filed.

It's an immense amount of data to track.
Some people have no problem with this, others loath it.

The advantage email has over this are too numerous to list,
but they start with the fact that lots of kernel developers are
lazy[*]. 2-3 keypresses to archive a patch for looking at later/merging
are about the level of involvement thats aimed for.
Having to start a browser, go to the bugzilla site, log in, search/browse
for bugs etc.. way too involved.

Dave.

[*] In the sense that if life can be made easier, it should be.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

