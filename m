Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132434AbRCZNEi>; Mon, 26 Mar 2001 08:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132435AbRCZNE2>; Mon, 26 Mar 2001 08:04:28 -0500
Received: from snark.tuxedo.org ([207.106.50.26]:40711 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132434AbRCZNEP>;
	Mon, 26 Mar 2001 08:04:15 -0500
Date: Mon, 26 Mar 2001 08:06:58 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Bjorn Wesen <bjorn@sparta.lu.se>
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk, trini@kernel.crashing.org,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML1 cleanup patch, take 2
Message-ID: <20010326080658.A16485@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Bjorn Wesen <bjorn@sparta.lu.se>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>, torvalds@transmeta.com,
	alan@lxorguk.ukuu.org.uk, trini@kernel.crashing.org,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <200103260955.f2Q9tfo14568@snark.thyrsus.com> <Pine.LNX.3.96.1010326133257.7071A-100000@medusa.sparta.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1010326133257.7071A-100000@medusa.sparta.lu.se>; from bjorn@sparta.lu.se on Mon, Mar 26, 2001 at 01:39:07PM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Wesen <bjorn@sparta.lu.se>:
> On Mon, 26 Mar 2001, Eric S. Raymond wrote:
> > (2) Fix up 20 cris-architecture configuration symbols lacking a CONFIG_
> >     prefix, so they obey CML1/CML2 conventions and can be detected by
> >     `make dep', also static-analysis tools and consistency checkers.
> >     This is a BUG FIX in CML1.
> 
> No need for you to fret on this; it's partly fixed in the version in
> Alan's tree and the rest will be cleaned up in our next update.

Good!  That will simplify my life a lot.  Assuming Linus takes that ac patch.

Greg Banks may have suggested a tolerable solution to the other problem.
I'm working on it now.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

There's a truism that the road to Hell is often paved with good intentions.
The corollary is that evil is best known not by its motives but by its
*methods*.
