Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129379AbQLBEUz>; Fri, 1 Dec 2000 23:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbQLBEUp>; Fri, 1 Dec 2000 23:20:45 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:9221 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129379AbQLBEUf>; Fri, 1 Dec 2000 23:20:35 -0500
Date: Fri, 1 Dec 2000 21:44:15 -0600
To: Christopher Friesen <cfriesen@nortelnetworks.com>
Cc: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Fasttrak100 questions...
Message-ID: <20001201214415.E25464@wire.cadcamlab.org>
In-Reply-To: <8voa7g$d1r$1@forge.tanstaafl.de> <Pine.LNX.4.21.0011291152500.5109-100000@sol.compendium-tech.com> <20001129210830.J17523@forge.tanstaafl.de> <20001129165236.A9536@vger.timpanogas.org> <3A266EE7.4C734350@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A266EE7.4C734350@nortelnetworks.com>; from cfriesen@nortelnetworks.com on Thu, Nov 30, 2000 at 10:14:47AM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Christopher Friesen]
> I think you should re-read the GPL.  You only have to provide source
> to people to whome you have distributed your new binaries, and you
> only have to provide that source if you are asked for it.

Oh, and you have to provide the complete text of the GPL as well, and
for that you do *not* have a "only if they ask for it" clause.

Or so it seems to some people, like RMS.  See this week's DWN: there is
a nice long discussion in debian-devel about this.  Apparently RMS
demands that all GPL'd Debian binary packages include a copy -- it is
not enough that the Debian base system already has a copy and that all
GPL'd source tarballs include a copy.

I do not agree with this interpretation, because it would mean that any
GPL'd file that can possibly be independently downloaded (such as a .c
file from a CVS server) must include that same 17k document.

...But just so everyone knows: according to RMS, every file on your FTP
server that you provide under the GPL v2 must include a copy of the
GPL.  (Easy enough to do with tar files, harder for other formats, and
never mind the wasted bandwidth.)  Having the GPL in a separate file on
your site does not count, apparently.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
