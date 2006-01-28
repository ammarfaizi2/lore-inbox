Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422790AbWA1CGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422790AbWA1CGl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 21:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422791AbWA1CGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 21:06:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8103 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422790AbWA1CGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 21:06:40 -0500
Date: Fri, 27 Jan 2006 21:06:13 -0500 (EST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Chase Venters <chase.venters@clientec.com>,
       "linux-os \\(Dick Johnson\\)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
In-Reply-To: <1138387136.26811.8.camel@localhost>
Message-ID: <Pine.LNX.4.64.0601272101510.3192@evo.osdl.org>
References: <43D114A8.4030900@wolfmountaingroup.com> 
 <20060120111103.2ee5b531@dxpl.pdx.osdl.net>  <43D13B2A.6020504@cs.ubishops.ca>
 <43D7C780.6080000@perkel.com>  <43D7B20D.7040203@wolfmountaingroup.com> 
 <43D7B5C4.5040601@wolfmountaingroup.com> <43D7D05D.7030101@perkel.com> 
 <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com> 
 <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com> 
 <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse> 
 <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org> <1138387136.26811.8.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Jan 2006, Alan Cox wrote:

> On Mer, 2006-01-25 at 17:39 -0500, Linus Torvalds wrote:
> > In other words: the _default_ license strategy is always just the 
> > particular version of the GPL that accompanies a project. If you want to 
> > license a program under _any_ later version of the GPL, you have to state 
> > so explicitly. Linux never did.
> 
> Not correct. See section 9.

Sorry, I think you're wrong.

We've _always_ said which license explicitly. It's in the COPYING file.

Even before the clarification, the COPYING file has always said 


                    GNU GENERAL PUBLIC LICENSE
                       Version 2, June 1991

 Copyright (C) 1989, 1991 Free Software Foundation, Inc.
                       51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 Everyone is permitted to copy and distribute verbatim copies
	...

at the very top.

How can you say that we didn't specify a version?

If you distribute a program, and you just say "I license this under the 
GPL", THEN you don't specify a verion.

But if you distribute a program, and the ONLY license that is associated 
with it is a specific version of a license file, then that's what you 
have, UNLESS SOMETHING SAYS OTHERWISE.

This is basic copyright law, btw, and has nothing to do with the GPL per 
se. If you don't have a license, you don't have any copyright AT ALL.

Linux kernel files don't say "This is licensed under the GPL". Not mine, 
at least. I don't see the point, and I never have. There's a COPYING file 
that specifies what the license is, and that COPYING file very much 
specifies a very _specific_ version of the GPL. Always has.

		Linus
