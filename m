Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136042AbRDVLkS>; Sun, 22 Apr 2001 07:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136043AbRDVLj6>; Sun, 22 Apr 2001 07:39:58 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:1551 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S136042AbRDVLjx>;
	Sun, 22 Apr 2001 07:39:53 -0400
Date: Sun, 22 Apr 2001 13:39:47 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: "Eric S. Raymond" <esr@thyrsus.com>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Request for comment -- a better attribution system
Message-ID: <20010422133947.A21908@se1.cogenit.fr>
In-Reply-To: <esr@thyrsus.com> <200104220228.f3M2St1s023522@sleipnir.valparaiso.cl> <20010422001209.G15644@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010422001209.G15644@thyrsus.com>; from esr@thyrsus.com on Sun, Apr 22, 2001 at 12:12:09AM -0400
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond <esr@thyrsus.com> ecrit :
[...]
> Indeed this is the case.  I think such global cleanups are, in fact, less
> frequent than they should be precisely *because* lkml's social machinery
> discourages them.

May be it's a good thing: I^H Joe Average has some bright idea, does a
global cleanup, consume maintainers time. Problem: idea was not so bright or
actually really low priority one. Make him loose some hours and he will
think twice about the best way to spend time improving the kernel.
If we see a growing number of entry in the credits file for global changes
while drivers are not ported from 2.x to 2.x+2 (for example), there is be a 
*real* problem.
People get discouraged because of this ? I hope they'll never have to
elaborate fixes for braindead hardware.
Look again at l-k archive: people do global changes (see VFS, network api, 
etc...).

[...]
> > Question is, is it really worth it to create specialized tools for this
> > very rare case?
> 
> Yes, if the rare case of supporting global cleanups actually needs to be a
> more common one.  Think about that for a while, please.

I did and I feel we're building gaswork for nothing.
 
-- 
Ueimor
