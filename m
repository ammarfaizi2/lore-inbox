Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314284AbSE1MRr>; Tue, 28 May 2002 08:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314277AbSE1MRq>; Tue, 28 May 2002 08:17:46 -0400
Received: from arsenal.visi.net ([206.246.194.60]:8658 "EHLO visi.net")
	by vger.kernel.org with ESMTP id <S314243AbSE1MRp>;
	Tue, 28 May 2002 08:17:45 -0400
X-Virus-Scanner: McAfee Virus Engine
Date: Tue, 28 May 2002 08:10:44 -0400
From: Ben Collins <bcollins@debian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, szepe@pinerecords.com, colin@gibbs.dhs.org,
        linux-kernel@vger.kernel.org, tcallawa@redhat.com,
        sparclinux@vger.kernel.org, aurora-sparc-devel@linuxpower.org
Subject: Re: 2.4 SRMMU bug revisited
Message-ID: <20020528121044.GG30482@blimpo.internal.net>
In-Reply-To: <20020527213016.GB7155@beth.pinerecords.com> <20020527.204114.126236775.davem@redhat.com> <1022587118.4124.49.camel@irongate.swansea.linux.org.uk> <20020528.040524.117889173.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2002 at 04:05:24AM -0700, David S. Miller wrote:
>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: 28 May 2002 12:58:38 +0100
>    
>    Which is a concern since both Linus and Larry made it clear bitkeeper
>    would *NEVER* be required of contributors. Is there nothing generating
>    nightly tarballs off cron right now ?
>    
> As stated in a followup posting, that kind of thing is available.
> 
> I don't see why people fly off the handle on this.  It only matters if
> you need the tree as of 5 minutes ago bleeding edge type stuff.  If
> you can wait a few days, then just hang on for Marcelo's next
> prepatch.

Not trying to add fuel to the fire, but Marcelo's last prepatch was
almost 4 weeks ago (26 days). It makes life hard on even me, because
somehow a little tweak ends up changing the ieee1394 subsystem, and I
find myself resyncing over several pre-releases to get my patches in.

It sometimes seems that the bitkeeper repo is being used to pacify the
bleeding edge junkies (and rightfully so), but at the same time is
allowing the tree maintainers (not point fingers) to be more lax in
getting out frequent pre/full releases to the non-bitkeeper public (like
me). This inadvertently stalls productivity for the rest of us.

My problem getting things into the 2.5 tree seems more related to the
amount of work getting done in that tree as opposed to the lack of
releases, which is entirely acceptable. I'd prefer chasing frequent
releases to chasing invisible ones :)

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://linux1394.sourceforge.net/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
