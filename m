Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316657AbSFKCZX>; Mon, 10 Jun 2002 22:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316659AbSFKCZW>; Mon, 10 Jun 2002 22:25:22 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:13803 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316657AbSFKCZW>; Mon, 10 Jun 2002 22:25:22 -0400
To: Brad Hards <bhards@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: of ethernet names (was [PATCH] Futex Asynchronous
In-Reply-To: <E17HYSZ-0000CY-00@pmenage-dt.ensim.com> <200206110932.44185.bhards@bigpond.net.au>
From: Andi Kleen <ak@muc.de>
Date: 11 Jun 2002 04:25:12 +0200
Message-ID: <m3y9dmimbb.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.070095 (Pterodactyl Gnus v0.95) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Hards <bhards@bigpond.net.au> writes:

> I simply don't grok those pages. I also note caveats about incompleteness, and 
> recommendation to use libnetlink, which is also not documented much.

I'm sorry you don't like my manpages.

I also wrote some manpages on libnetlink, but for some reason they were never
merged in the main distribution so you can only find them in the SuSE rpm
or at http://www.firstfloor.org/~andi/man/libnetlink.3.gz (source)
or http://www.firstfloor.org/~andi/man/libnetlink.3.txt (formatted manpage)

Jamal Hadi wrote a ietf draft on netlink.  I don't know if it's publicly
available (if yes probably somewhere on ftp.ietf.org) it describes quite 
a lot of basic concepts in netlink/rtnetlink although in a bit foreign 
to linux terminology.

I also did a presentation on netlink and related topics at previous to
last year's Ottawa Linux symposium which may be also helpful. The slides
are at http://www.firstfloor.org/~andi/ols/OLSpres.htm

-Andi
