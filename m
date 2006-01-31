Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbWAaR6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWAaR6W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 12:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWAaR6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 12:58:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30660 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751311AbWAaR6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 12:58:21 -0500
Date: Tue, 31 Jan 2006 09:57:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Chase Venters <chase.venters@clientec.com>,
       "linux-os \\(Dick Johnson\\)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
In-Reply-To: <1138620390.31089.43.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0601310931540.7301@g5.osdl.org>
References: <43D114A8.4030900@wolfmountaingroup.com> 
 <20060120111103.2ee5b531@dxpl.pdx.osdl.net>  <43D13B2A.6020504@cs.ubishops.ca>
 <43D7C780.6080000@perkel.com>  <43D7B20D.7040203@wolfmountaingroup.com> 
 <43D7B5C4.5040601@wolfmountaingroup.com> <43D7D05D.7030101@perkel.com> 
 <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com> 
 <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com> 
 <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse> 
 <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org>  <1138387136.26811.8.camel@localhost>
  <Pine.LNX.4.64.0601272101510.3192@evo.osdl.org> <1138620390.31089.43.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Jan 2006, Alan Cox wrote:
>
> You might also want to ask "if the FSF COPYING text specified the
> program version as you claim then how would you specify versions
> differently". And likewise "How come the FSF itself, author of the
> license, distributes its default COPYING file with code clearly intended
> and marked to be GPL v2 or later".

Alan, you're weasel-wording, and making up arguments that aren't valid.

You can avoid specifying a particular version of the GPL by just saying 
"This project is distributed under the GPL" and pointing to the FSF. Not 
everybody necessarily even includes the LICENSE file.

Please realize that the kernel is one of the largest open-source projects 
in the world, if not _the_ largest. Most projects are much much smaller. 
Many projects are very ad-hoc, and not all of them have necessarily been 
all that careful with adding LICENSE files etc.

As to your "FSF itself" argument, the code the FSF distributes obviously 
_has_ to state "GPL v2 or later" exactly because they want the "or later" 
thing to be effective.

Their suggestions very much is to include the GPL license in its entirety 
_and_ to say "GPL v2 or later" in the files, exactly because they need to 
_expand_ the license from just the one in the license file (ie the "or 
later" part is essentially an open-ended dual license).

None of your arguments in any way argue that Linux wouldn't be GPLv2.

> In short your interpretation of the past state of affairs would not
> stand up to scrutiny.

You can claim anything you like. I think you're wrong. But in the 
meantime, that doesn't matter. If it ever goes to court, you'll see what a 
real judge will claim.

My bet is that my interpretation is the only sane one. 

> The COPYING file is mere aggregation - it is a seperately licensed and
> independant work to the program with incompatible conditions.

The fact that the COPYING file has a different copyright really doesn't 
matter. It's still part of the release. 

It's absolutely not different from having a separate "Release notes" file 
which specifies the copyright conditions. That's how Linux-0.01 did it: 
the thing was outside the actual main tar-ball, and sent out both as part 
of the announcemnt and as a separate file in the same directory on the 
ftp-site.

Yes, it may be "mere aggregation", but that has absolutely _zero_ impact 
on my argument. It's the only license you have to copy Linux, and it very 
much has an EXPLICIT VERSION. Namely version 2.

At no time has Linux ever been distributed without the version of the GPL 
that it is distributed under being in any question at all. THAT is my 
argument. 

And as said - you can argue against it as much as you damn well please. I 
simply don't care. I think you are very obviously wrong, but hey, in the 
end that doesn't matter either. Take it to a judge. Arguing it to me or to 
the public has absolutely zero relevance.

And regardless of what you argue, for the last 5 years there has been the 
explicit explanatory note. And you can't claim that people didn't know 
about it: if I remember correctly, you yourself sent updates to some of 
the files you felt you had copyright on to add the ".. or any later 
version" verbiage when I suggested people do so.

So why are you even arguing? It is an UNDENIABLE FACT that a noticeable 
portion of the Linux kernel is version-2 only. You'd have to do a lot of 
work if you wanted to re-license it - and the burden of proof is on _you_ 
to do so, not on me. Keeping the old license is the _only_ case that 
obviously needs no proof at all, since regardless of circumstances, it's 
always safe.

The fact is, the kernel is not licenseable under GPLv3 without tons of 
work. Work that I'm not in the least interested in doing, or even helping 
with. If you want to start such an effort, I'd suggest:

 - spend hours and hours of your time talking to your lawyers, trying to 
   convince them that your argument has any merit at all. I doubt you'll 
   be able to do that.

 - than start from the state 5 years ago.

Btw, at least in the US, intent actually matters. The fact that I've made 
it clear that my _intent_ was always GPLv2 (and I've been very consistent 
on this) together with the fact that people have accepted the addendum to 
the COPYING file actually _does_ have legal meaning. 

Weasel-wording and trying to work around the fact that the version has 
always been explicitly mentioned is not a way to make a legal argument. 

Yet that's really all your argument boils down to.

I can make very specific arguments for why version 2 ONLY is the specific 
license that covers Linux. In contrast you can only make weasel-wording 
"but you _could_ misunderstand it to mean xyzzy" kind of noises. That 
should tell you something.

			Linus
