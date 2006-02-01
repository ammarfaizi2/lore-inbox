Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWBAATs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWBAATs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 19:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWBAATs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 19:19:48 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:24975 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S932256AbWBAATr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 19:19:47 -0500
Date: Wed, 1 Feb 2006 00:20:08 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@sheen.jakma.org
To: Linus Torvalds <torvalds@osdl.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
In-Reply-To: <Pine.LNX.4.64.0601311430130.7301@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0601312332520.3920@sheen.jakma.org>
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
 <Pine.LNX.4.64.0601311152070.7301@g5.osdl.org> <43DFDEF9.2030001@keyaccess.nl>
 <Pine.LNX.4.64.0601311430130.7301@g5.osdl.org>
Mail-Copies-To: paul@hibernia.jakma.org
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: al aqsar fluffy jihad cute musharef kittens jet-A1 ear avgas wax ammonium bad qran dog inshallah allah al-akbar martyr iraq hammas hisballah rabin ayatollah korea revolt pelvix mustard gas x-ray british airways washington peroxide cool
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<trimming the wide Cc list due to complaints>

On Tue, 31 Jan 2006, Linus Torvalds wrote:

> Notice how the GPLv2 text says that it applies to any program that 
> just says it is licensed under the General Public License.
>
> I'm convinced _that_ is how you get "no version specified" in section 9.
> You have a program that just says "This is licensed under the GPL",
> instead of doing the full thing.

> And I say that the Linux kernel has contained a notice placed by the
> copyright holder (the "COPYING" file) that says that it's to be
> distributed under (and I quote from the top):
>
>                    GNU GENERAL PUBLIC LICENSE
>                       Version 2, June 1991
>
> and that's it.

Well, most people would recognise this to be exactly the same text of 
the GPLv2 as published by the FSF, as used by many software 
programmes:

 	http://www.gnu.org/licenses/gpl.txt

and hence would have trouble recognising that you intended this to 
also be the text governing exactly which version(s) of the GPL apply 
linux specifically.

Note that if what you say is correct, that the immutable header of 
the GPLv2 acts so as to apply a version restriction on any specific 
covered programme per default, then that would mean:

1a. The "If the Program does not specify a version" text of Section 9
     of the GPLv2 is utterly without effect and meaningless.

1b. Indeed, the whole of section 9 might be without effect (the
     version is already specified). (It'd depend on the exact
     text of the preamble maybe, but it'd be quite ambigious).

2. Hence all GPLv2 programmes which do not have include some
    additional "or any later version" preamble text definitely will
    not automatically upgrade to GPLv3 when it is finally published.

You've mentioned intent a few times before as being a strong factor 
in interpretation[1], you have to therefore ask what RMS and the FSF 
intended when they included section 9: did they really intend that 
the GPLv2's 'Version 2, June 1991' would completely override the text 
regarding cases where "the Program does not specify a version number 
of this License"? The intent surely of section 9 was to allow for the 
GPLv2 to be upgraded smoothly, even where a programme applied it 
imprecisely.

Hence, logically, the intent of the framers must have been that the 
'Version 2, June 1991' was to act as a version identifier for the GPL 
text only, rather than to be interpreted as the version applying to 
the whole programme.

That the licence then goes on to discuss how to apply the GPL (the 
third part you mentioned before), and mention how to do so (including 
the "any later version" text) further suggests that simply including 
a copy of the the text of the license itself does not constitute 
tying down the version.

Note that I'm only arguing with you on your interpretation of the GPL 
- which I believe is flawed and deserves to be contradicted lest 
others assume it - not on which version of the GPL applies to Linux 
in its aggregate (which definitely is "v2 only", and has been for 
ages).

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Ernest asks Frank how long he has been working for the company.
 	"Ever since they threatened to fire me."
