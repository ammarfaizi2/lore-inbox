Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319689AbSIMPuM>; Fri, 13 Sep 2002 11:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319690AbSIMPuM>; Fri, 13 Sep 2002 11:50:12 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:58378 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S319689AbSIMPuM>; Fri, 13 Sep 2002 11:50:12 -0400
Date: Fri, 13 Sep 2002 11:47:45 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Hans Reiser <reiser@Namesys.COM>
cc: Nikita Danilov <Nikita@Namesys.COM>, Bryan Whitehead <driver@jpl.nasa.gov>,
       Nick LeRoy <nleroy@cs.wisc.edu>, jw schultz <jw@pegasys.ws>,
       linux-kernel@vger.kernel.org
Subject: Re: XFS?
In-Reply-To: <3D81DD9E.4050303@namesys.com>
Message-ID: <Pine.LNX.3.96.1020913113354.23423A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Sep 2002, Hans Reiser wrote:

> Bill Davidsen wrote:

> >No, that's probably a good thing. I don't care how good any programming
> >team might be, an implementation written from scratch probably should burn
> >in for a while before going in anywhere it might be used for production.
> >
> >And with all respect to the group, a 4th rewite from scratch in only a few
> >years suggests that the ratio of coding to designing is pretty high.

> As for the notion that the more designing you do, the less rewriting you 
> need to do, it is a bit like the belief that the better your scientific 
> theories the less you need to perform experiments.

Exactly so. I spent several decades doing software development at GE's
Corporate R&D Center, and I had ample proof that both of those things are
true. I think the phrase you want in English is "fewer experiments you
need to perform," but you did see the principle.
 
> Projects that are no longer attempting rewrites of their cores are dead 
> in their soul, and their authors should pass them on to someone younger.

Hear that, Linus? Off to the retirement home with you unless you "rm *"
your source tree and "go back to Baltimore and start over again as a
virgin." Actually I think that Linux is an example of major software
designed from the start to be rewritten in parts and to evolve as a whole.
no clean sheet of paper needed.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

