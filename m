Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751545AbWAaVr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbWAaVr3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 16:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWAaVr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 16:47:29 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:26497 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S1751544AbWAaVr2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 16:47:28 -0500
Date: Tue, 31 Jan 2006 21:45:37 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@sheen.jakma.org
To: Linus Torvalds <torvalds@osdl.org>
cc: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chase Venters <chase.venters@clientec.com>,
       "linux-os \\(Dick Johnson\\)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
In-Reply-To: <Pine.LNX.4.64.0601311152070.7301@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0601312125130.3920@sheen.jakma.org>
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
 <Pine.LNX.4.64.0601311152070.7301@g5.osdl.org>
Mail-Copies-To: paul@hibernia.jakma.org
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: al aqsar fluffy jihad cute musharef kittens jet-A1 ear avgas wax ammonium bad qran dog inshallah allah al-akbar martyr iraq hammas hisballah rabin ayatollah korea revolt pelvix mustard gas x-ray british airways washington peroxide cool
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2006, Linus Torvalds wrote:

> under the GPL", not "GPLv2 or later". The _only_ license rights anybody
> ever had to those files come from the COPYING file, which very clearly
> states that it's "version 2, 1991"

No one has disputed that I think. My understanding of that text, as 
in:


                     GNU GENERAL PUBLIC LICENSE
                        Version 2, June 1991

Is that it refers as the version of the license itself. The 'revision 
ID' of the published license. And that very version of the GPL has a 
clause to allow version 'conversion' in section 9 to other versions.

> The COPYING file was edited (over _five_ years ago) to clarify the issue,

That wasn't clarifying the issue, that was to make sure section 9's 
"any version" could no longer apply. You even seem to have 
acknowledged that very text of section 9 in your announcement of 
2.4.0-test8's COPYING change:

`There's been some discussions of a GPL v3 which would limit 
licensing to certain "well-behaved" parties, and I'm not sure I'd 
agree with such restrictions - and the GPL itself allows for "any 
version" so I wanted to make this part unambigious as far as my 
personal code is concerned."'

From:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0009.1/0096.html

Until you made that change, a reasonable person might have presumed 
that lack of version statement (no, the actual GPL license version at 
the top of the GPL itself does not count ;) ) would mean section 9 
would have applied.

I'm not familiar enough with Linux kernel history to know whether the 
implicit "only version 2" view was widely known amongst kernel 
developers back then, prior to the edit.

> and that has been the case for the last 5+ years.

Right. The "version 2 only" only has been the status quo for 5+ years 
now, so most people must be content with it, grudgingly or not.

> Exactly. That's why I added the clarification on top of the COPYING 
> file: people _have_ been confused.

Read your own email again. :)

> That confusion doesn't stem from Linux, btw, but from the FSF distribution
> of the GPLv2 license itself. The license is distributed as one single
> file, which actually contains three parts: (1) the "preamble", (2) the
> actual license itself and (3) the "How to Apply These Terms to Your New
> Programs" mini-FAQ.
>
> And that third part actually contains the wording "(at your option) any
> later version.",

Right.

But the actual /license/, the second part, says none specified -> 
"any version ever published" in section 9. The "any later version" 
text is in the 3rd part, the suggested preamble.

> files.  In other words, that was never actually part of the license
> itself, but just a "btw, here's how you should use it" post-script.

Right. But there are *two* (any.*version):

1. "Any version", which is:

 	a) In the license itself, to cover case where programme
 	   doesn't specify which version(s) apply, as section 9.
 	   (ie in the "second part").

 	b) the text you refered to in the 2.4.0-test8 above (ie
  	   you were looking at section 9 back then, not the preamble ;) )

2. "Any later version", which is what is mentioned in the preamble
    (the third part).

Alan's reply to you was on the basis of 1. You're arguing based on 2, 
having apparently completely overlooked 1 (though you apparently had 
not back when you composed that 2.4.0-test8 email).

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
God is real, unless declared integer.
