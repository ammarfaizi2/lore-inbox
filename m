Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129776AbQLDKIf>; Mon, 4 Dec 2000 05:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129704AbQLDKIQ>; Mon, 4 Dec 2000 05:08:16 -0500
Received: from [194.213.32.137] ([194.213.32.137]:5636 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129614AbQLDKIO>;
	Mon, 4 Dec 2000 05:08:14 -0500
Message-ID: <20001203235452.C165@bug.ucw.cz>
Date: Sun, 3 Dec 2000 23:54:52 +0100
From: Pavel Machek <pavel@suse.cz>
To: Peter Samuelson <peter@cadcamlab.org>,
        Christopher Friesen <cfriesen@nortelnetworks.com>
Cc: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Fasttrak100 questions...
In-Reply-To: <8voa7g$d1r$1@forge.tanstaafl.de> <Pine.LNX.4.21.0011291152500.5109-100000@sol.compendium-tech.com> <20001129210830.J17523@forge.tanstaafl.de> <20001129165236.A9536@vger.timpanogas.org> <3A266EE7.4C734350@nortelnetworks.com> <20001201214415.E25464@wire.cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20001201214415.E25464@wire.cadcamlab.org>; from Peter Samuelson on Fri, Dec 01, 2000 at 09:44:15PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> [Christopher Friesen]
> > I think you should re-read the GPL.  You only have to provide source
> > to people to whome you have distributed your new binaries, and you
> > only have to provide that source if you are asked for it.
> 
> Oh, and you have to provide the complete text of the GPL as well, and
> for that you do *not* have a "only if they ask for it" clause.
> 
> Or so it seems to some people, like RMS.  See this week's DWN: there is
> a nice long discussion in debian-devel about this.  Apparently RMS
> demands that all GPL'd Debian binary packages include a copy -- it is
> not enough that the Debian base system already has a copy and that all
> GPL'd source tarballs include a copy.
> 
> I do not agree with this interpretation, because it would mean that any
> GPL'd file that can possibly be independently downloaded (such as a .c
> file from a CVS server) must include that same 17k document.
> 
> ...But just so everyone knows: according to RMS, every file on your FTP
> server that you provide under the GPL v2 must include a copy of the
> GPL.  (Easy enough to do with tar files, harder for other formats, and
> never mind the wasted bandwidth.)  Having the GPL in a separate file on
> your site does not count, apparently.

Hmm, add special code for GPL into gzip ;-).
								Pavel
PS: That's crazy. Including it by reference should be enough. I do not
want waste 17K on every file.
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
