Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289338AbSBJHso>; Sun, 10 Feb 2002 02:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289340AbSBJHse>; Sun, 10 Feb 2002 02:48:34 -0500
Received: from [63.231.122.81] ([63.231.122.81]:13933 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S289338AbSBJHsb>;
	Sun, 10 Feb 2002 02:48:31 -0500
Date: Sun, 10 Feb 2002 00:47:48 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Patrick Mochel <mochel@osdl.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [bk patch] Make cardbus compile in -pre4
Message-ID: <20020210004748.G9826@lynx.turbolabs.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0202081824070.25114-100000@segfault.osdlab.org> <20020208203931.X15496@lynx.turbolabs.com> <3C649F4F.7E190D26@mandrakesoft.com> <20020209002920.Z15496@lynx.turbolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020209002920.Z15496@lynx.turbolabs.com>; from adilger@turbolabs.com on Sat, Feb 09, 2002 at 12:29:20AM -0700
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:
> from at least one developer I have already done a partial pull,
> ie taken only partial changes. In that case the changes I disagreed with
> were at the end, so it was easy enough to just do a "bk pull" into
> another tree, do a "bk undo", and only merge after that.
> 
> But I agree - if I end up having to do that more than occasionally, I'm
> going to ask that developer to stop using bk at least as far as I'm
> concerned (ie he can use bk for himself, but I wouldn't accept bk
> patches from developers who cannot keep their stuff cleanly separated).

What about BK CSET (or regular patch) submissions from non-core
developers?  Would you accept CSETs via email if they are preceeded
by a unified diff and explanation?  This would make it much easier
for any non-core developer to avoid having to re-sync their changes
with you if/when you accept that change into your tree.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

