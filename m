Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136227AbRDVRX5>; Sun, 22 Apr 2001 13:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136228AbRDVRXr>; Sun, 22 Apr 2001 13:23:47 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:33762 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S136227AbRDVRX0>;
	Sun, 22 Apr 2001 13:23:26 -0400
Date: Sun, 22 Apr 2001 13:23:21 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Francois Romieu <romieu@cogenit.fr>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Request for comment -- a better attribution system
In-Reply-To: <20010422125132.A29277@thyrsus.com>
Message-ID: <Pine.GSO.4.21.0104221251580.28681-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 22 Apr 2001, Eric S. Raymond wrote:

> Alexander Viro <viro@math.psu.edu>:
> > Sigh... Would these broken things, by any chance, be "my grand ideas are
> > not met with applause"?
> 
> Nope.  Not at all.  Stay tuned, because I'll explain.
> 
> And before you write me off as one of the $BIGNUM clueless
> visionaries, you might do well to remember that I actually *have*
> radically changed the world lkml operates in.  At least twice.

	So had certain wa.us-based company. If you refer to your "Cathedral
and Bazaar" - pardon me the bluntness, but it doesn't speak well of your
clue level.  L-k is not a place for detailed analysis of that text, so let
me just point to the fact that
	* you've ignored the robustness of design behind the UNIX kernel.
These beasts keep going without falling apart even after serious injuries.
	* you've ignored another factor - maintainer with a taste and ability
to say "no".
	* you've made a completely unwarranted assumption - that widely-used
and available code actually gets reviewed by many people.  It's demonstrably
false.

	Ability to do PR != having a shred of clue in other areas.
I'm sure that you can come up with relevant examples yourself.

