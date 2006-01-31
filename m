Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751693AbWAaW1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbWAaW1c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 17:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbWAaW1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 17:27:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38567 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751692AbWAaW1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 17:27:31 -0500
Date: Tue, 31 Jan 2006 14:25:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Jakma <paul@clubi.ie>
cc: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chase Venters <chase.venters@clientec.com>,
       "linux-os \\(Dick Johnson\\)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
In-Reply-To: <Pine.LNX.4.64.0601312125130.3920@sheen.jakma.org>
Message-ID: <Pine.LNX.4.64.0601311415510.7301@g5.osdl.org>
References: <43D114A8.4030900@wolfmountaingroup.com> 
 <20060120111103.2ee5b531@dxpl.pdx.osdl.net>  <43D13B2A.6020504@cs.ubishops.ca>
 <43D7C780.6080000@perkel.com>  <43D7B20D.7040203@wolfmountaingroup.com> 
 <43D7B5C4.5040601@wolfmountaingroup.com> <43D7D05D.7030101@perkel.com> 
 <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com> 
 <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com> 
 <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse> 
 <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org>  <1138387136.26811.8.camel@localhost>
  <Pine.LNX.4.64.0601272101510.3192@evo.osdl.org> <1138620390.31089.43.camel@localhost.localdomain>
 <Pine.LNX.4.64.0601310931540.7301@g5.osdl.org> <43DF9D42.7050802@wolfmountaingroup.com>
 <Pine.LNX.4.64.0601311032180.7301@g5.osdl.org> <43DFB0F2.4030901@wolfmountaingroup.com>
 <Pine.LNX.4.64.0601311152070.7301@g5.osdl.org> <Pine.LNX.4.64.0601312125130.3920@sheen.jakma.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Jan 2006, Paul Jakma wrote:
>
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0009.1/0096.html
> 
> Until you made that change, a reasonable person might have presumed that lack
> of version statement (no, the actual GPL license version at the top of the GPL
> itself does not count ;) ) would mean section 9 would have applied.

Actually, I don't think it was really debatable even before that, but yes, 
I wanted to cover my ass. _Exactly_ because of that confusion over "any 
version" in section 9.

IOW, it isn't a new confusion. It's an old confusion that I've always felt 
was silly - and incorrect - and that I wanted to address explicitly, 
exactly so that there wouldn't be any ambiguoity.

So I maintain that "version 2" has always been the version of the GPL as 
it pertains to the kernel as far as I'm concerned, but exactly because 
some other people have been confused, I wanted to make it not only 
explicit, but also mention it publicly when the clarification was done, so 
that people who _had_ been confused could just add in the necessary 
verbiage so that code that they owned would fall under the license they 
had _thought_ was the right one.

Note how I called it a "clarification" even back then. It wasn't a change 
to make things GPLv2 - it was _clarifying_ that the kernel had always been 
GPLv2, and acknowledging that there had indeed been confusion.

And hey, if people want to put the confusion at my door, go right ahead. 
I'm just happy I did it five years ago, so that by _now_, things are 
hopefully pretty damn clear-cut.

		Linus
