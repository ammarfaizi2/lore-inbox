Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135949AbRDTP4M>; Fri, 20 Apr 2001 11:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135952AbRDTP4C>; Fri, 20 Apr 2001 11:56:02 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:4366 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S135949AbRDTPzt>; Fri, 20 Apr 2001 11:55:49 -0400
Date: Fri, 20 Apr 2001 08:51:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Eric S. Raymond" <esr@thyrsus.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Matthew Wilcox <willy@ldl.fc.hp.com>,
        james rich <james.rich@m.cc.utah.edu>, linux-kernel@vger.kernel.org,
        parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] Re: OK, let's try cleaning up another nit. Is anyone paying attention?
Message-ID: <20010420085148.V13403@opus.bloom.county>
In-Reply-To: <20010420101951.A6011@thyrsus.com> <E14qc9E-0001PW-00@the-village.bc.nu> <20010420105934.A6668@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010420105934.A6668@thyrsus.com>; from esr@thyrsus.com on Fri, Apr 20, 2001 at 10:59:34AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2001 at 10:59:34AM -0400, Eric S. Raymond wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > > well, though.  One is the kind I'm bumping into right now, where
> > > somebody legitimately needs to make small (almost trivial) changes
> > > scattered all through the tree.
> > 
> > Yep. But such changes are rare. Or should be. 
> 
> Knowing that doesn't help me much, since I'm trying to fix up a global
> namespace that touches everybody :-(.

Which does boil down to having to work with trees other than Linus or
Alans.  Remember, the official tree is not always the up-to-date tree,
or in the case of other arches, the most relevant tree.  But if you send
something off to a maintainer, there's a good chance (if they're still active)
they'll do what you ask, and it'll get to Linus/Alan the next time they sync.
As long as the problem gets fixed, it shouldn't be as important if it's fixed
in everyones tree right now, or in a release or two.  If it's some sort of
huge bug it just might get fixed sooner.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
