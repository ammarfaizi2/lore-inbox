Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132325AbRBRRrn>; Sun, 18 Feb 2001 12:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132436AbRBRRrW>; Sun, 18 Feb 2001 12:47:22 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:15366 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S132325AbRBRRrO>;
	Sun, 18 Feb 2001 12:47:14 -0500
Date: Sun, 18 Feb 2001 18:47:08 +0100
From: Frank de Lange <frank@unternet.org>
To: linux-kernel@vger.kernel.org
Subject: Re: reiserfs on 2.4.1,2.4.2-pre (with null bytes patch) breaks mozilla compile
Message-ID: <20010218184708.B27092@unternet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Minor nit, but I'd rather clear it up now. Which distribution you run
> doesn't matter for debugging. What does matter is that we've got known
> problems with a given compiler, and that compiler goes by a few different
> flavors with the same version number. Since there are known problems, if
> you don't provide the compiler version, I'll ask. If your bug is *really*
> odd, I might ask a few different ways, just to make sure you give the same
> answer every time ;-)

Well, a nit to a nit... In my experience it surely matters which distribution
somebody runs, since that tells a lot about the basic system (libc, probable
compiler, binutils, etc). RH7 is broken in many respects. Since it uses
glibc-2.2 as well, I usually add the notice that I do NOT run RH7 to messages
like these where I mention I use glibc-2.2.x, if only to ward off the usual
'are you running RH7 if yes please upgrade so and so' cycle. Bits and electrons
are much to precious to waste on
useless banter like that...

Cheers//Frank
-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
