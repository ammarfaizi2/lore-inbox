Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136073AbRDVMeN>; Sun, 22 Apr 2001 08:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136075AbRDVMeD>; Sun, 22 Apr 2001 08:34:03 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:48059 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S136073AbRDVMdu>;
	Sun, 22 Apr 2001 08:33:50 -0400
Date: Sun, 22 Apr 2001 08:33:44 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Francois Romieu <romieu@cogenit.fr>
cc: "Eric S. Raymond" <esr@thyrsus.com>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Request for comment -- a better attribution system
In-Reply-To: <20010422133947.A21908@se1.cogenit.fr>
Message-ID: <Pine.GSO.4.21.0104220819490.28681-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 22 Apr 2001, Francois Romieu wrote:

> Look again at l-k archive: people do global changes (see VFS, network api, 
> etc...).

And then we have the situation when about a half of filesystems has no
single maintainer - they are taken care of when needed, but that's it.
We also have _no_ official maintainer of VFS, and that's the way it's
gonna be.

Eric, it would save everyone a lot of time if you actually cared to
pull your head out of your... theoretical constructions and spent
some efforts figuring out how the things really work. Building
infrastructure before you get familiar with the problem domain is
generally considered harmful. That's precisely what you are doing.
Trust me, it doesn't earn you any respect from people familiar
with the problem.

