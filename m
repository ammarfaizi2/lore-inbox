Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135935AbRDTOqE>; Fri, 20 Apr 2001 10:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135936AbRDTOpz>; Fri, 20 Apr 2001 10:45:55 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:50181 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135935AbRDTOpk>; Fri, 20 Apr 2001 10:45:40 -0400
Subject: Re: [parisc-linux] Re: OK, let's try cleaning up another nit. Is anyone paying attention?
To: esr@thyrsus.com
Date: Fri, 20 Apr 2001 15:44:34 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        acahalan@cs.uml.edu (Albert D. Cahalan),
        willy@ldl.fc.hp.com (Matthew Wilcox),
        james.rich@m.cc.utah.edu (james rich), linux-kernel@vger.kernel.org,
        parisc-linux@parisc-linux.org
In-Reply-To: <20010420101951.A6011@thyrsus.com> from "Eric S. Raymond" at Apr 20, 2001 10:19:51 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qc9E-0001PW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll continue asking stupid questions, then.  Like, under this system how
> can either you or the port maintainers maintain a good representation of 
> how far out of sync they are with the main tree?

diff and read the output.

[bizzare sociopolitical mumble deleted]

> well, though.  One is the kind I'm bumping into right now, where
> somebody legitimately needs to make small (almost trivial) changes
> scattered all through the tree.

Yep. But such changes are rare. Or should be. 

> Another is the case where a piece of code that needs to be changed doesn't
> have an active maintainer for a third party like me to go to.
> What's the neighborly way to deal with these?

If I get patches for stuff that doesnt seem to have a maintainer I apply them.
On the odd occasion a scream is heard in the distance it means I now know
there is an active maintainer.



