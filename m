Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbWAaTlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWAaTlY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 14:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWAaTlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 14:41:23 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:32171 "EHLO
	ns1.utah-nac.org") by vger.kernel.org with ESMTP id S1751406AbWAaTlX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 14:41:23 -0500
Message-ID: <43DFB0F2.4030901@wolfmountaingroup.com>
Date: Tue, 31 Jan 2006 11:48:18 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chase Venters <chase.venters@clientec.com>,
       "linux-os \\(Dick Johnson\\)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
References: <43D114A8.4030900@wolfmountaingroup.com>  <20060120111103.2ee5b531@dxpl.pdx.osdl.net>  <43D13B2A.6020504@cs.ubishops.ca> <43D7C780.6080000@perkel.com>  <43D7B20D.7040203@wolfmountaingroup.com>  <43D7B5C4.5040601@wolfmountaingroup.com> <43D7D05D.7030101@perkel.com>  <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com>  <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com>  <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse>  <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org>  <1138387136.26811.8.camel@localhost>  <Pine.LNX.4.64.0601272101510.3192@evo.osdl.org> <1138620390.31089.43.camel@localhost.localdomain> <Pine.LNX.4.64.0601310931540.7301@g5.osdl.org> <43DF9D42.7050802@wolfmountaingroup.com> <Pine.LNX.4.64.0601311032180.7301@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601311032180.7301@g5.osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Tue, 31 Jan 2006, Jeff V. Merkey wrote:
>  
>
>>And how many times have you actually stood in front of a Judge over IP and
>>contract issues?
>>    
>>
>
>Well, at least I know what I'm talking about.
>  
>
Linus, it's awfully complicated when a judge has to look at this stuff. 
 From my experience they have
zero understanding of high tech so they always end up looking at 
agreements and wording of contracts
and licenses, since they can understand this.

>  
>
>>The language "GPLv2 or any later version" is what it is. You can change 
>>it moving forward, but you cannot undo the past. You put this language 
>>in there and IT WAS WHAT YOU MEANT AT THE TIME. Trying to alter that 
>>would most likely result in a finding you are acting in bad faith.
>>    
>>
>
>I did _not_ put that language in, which is the whole point.
>  
>

If you can provide this beyond all doubt, then I agree you have a solid 
basis to object.
However, it being there does make the whole arguments nebulous. I would 
suggest
removing any such language from kernel.org and state GPLv2 ONLY.

>That language is in almost all GPL-licensed projects _except_ for Linux. 
>It's in the FSF guidelines for what they _suggest_ people will do when 
>they license something under the GPL. It's in all the FSF projects, 
>obviously, and a lot of other GPL'd projects have also just mindlessly 
>copied the FSF-suggested boilerplate.
>
>Linux never did. Linux has _never_ had the "v2 or later" license wording 
>in general. Go take a look. The kernel on the whole tends to not mention 
>licenses in the individual files, preferring to instead rely on the 
>external COPYING file that it is distributed with. That's very much on 
>purpose: I personally _hate_ seeing a screenful of crapola that adds 
>nothing over and over again.
>
>In short, apart from the very early code in 1991 and early -92 (versions 
>0.01 through 0.12), Linux has been licensed with _only_ the GPLv2 license 
>file, and normally no mention of "v2 or later" in the actual sources.
>  
>

Again, get rid of this language completely about later versions.

>And the way copyrights work, you have only as many rights as explicitly 
>granted to you, so nobody has _ever_ had rights to re-license Linux under 
>any other license than the one it came with: namely the GPLv2. Alan is 
>trying to argue that the fact that it has been licensed under the GPLv2 
>would somehow "magically" mean that it has been licensed under any version 
>of GPL that you can pick, BUT THAT IS AN OBVIOUSLY LEGALLY FLAWED 
>ARGUMENT.
>  
>

It's not. I was also under the impression based on the language "any 
later license"
and I am a very bright chap. So if I got it wrong, then imagine how many 
other
folks are likely to be confused.

>It is so obviously flawed that I'm surprised he continues to argue it. 
>There has _never_ been anything that says "any version of the GPL", or 
>indeed just "the GPL" without any version. The version has _always_ been 
>explicit: the kernel comes with the GPLv2 and no other version. If you 
>don't accept the COPYING file as the license, then you had no license AT 
>ALL to distribute Linux under.
>
>So you have one choice, and once choice ONLY: accept the GPLv2 (as 
>reproduced in COPYING) or don't accept the license at all. The option 
>that Alan seems to want to do is "I'll take just the word 'GPL' from the 
>COPYING file, and then stick to that" has simply never been an option.
>
>Now, I can't stop Alan making stupid arguments. People can argue anything 
>they damn well please, whether it makes sense or not. As SCO has shows us, 
>people can argue crap for years, even in front of a judge, without any 
>actual fact or paper to stand on.
>  
>

Alan is trying to help you. I have never seen him do anything other than 
support you
to the hilt. Sure, disagreements happen, but he is there for you and 
Linux and has
been from day one.

>And that is what Alan does. He tries to argue that the kernel has somehow 
>magically been released under "the GPL" (without version specifier), even 
>though the only license that it was ever released under (apart from the 
>original non-GPL made-up-by-yours-truly license) very explicitly says 
>which version it is, in big letters at the very top.
>
>The fact that I made it even _more_ obvious five years ago by adding a 
>further explanatory notice doesn't change anything at all, except make it 
>more obvious.
>
>Alan - talk to a lawyer. Really. Show him this email thread and my 
>arguments, and ask him what he believes. I bet you can get a lawyer to 
>argue your case if you _pay_ him (lawyers are whores - they are paid to 
>argue for their client, not for the law), but ask him what he honestly 
>thinks a judge would rule. THEN come back to me.
>  
>

Linus, remove all nebulous language and post a notice on kernel.org 
clarifying your
position on this code, and I think the issue becomes closed. There's 
still the possiblity
that under the doctrine of esstopel, someone can claim or will try to 
claim conversion
to GPLv3. You will have to address this when and if it happens.

>Because let's face it, the burden on proof on changing the kernel license 
>is on _Alan_, not me. Alan is the one arguing for change. 
>  
>

A change to GPLv3 would be a good thing for you.

>Now, some individual files in the kernel are dual-licensed. Some of them 
>are dual-licensed with a BSD-license, others are "v2 or later version". 
>The latter is by no means uncommon, but it's definitely in the minority. 
>Just to give you an idea:
>
>    [torvalds@g5 linux]$ git-ls-files '*.c' | wc -l
>    7978
>    [torvalds@g5 linux]$ git grep -l "any later version" '*.c' | wc -l
>    2720
>    [torvalds@g5 linux]$ git grep -l "Redistributions in binary form must" '*.c' | wc -l
>    230
>
>ie of the C files, only about a third have the "any later version" 
>verbiage needed to be able to convert GPL v2 to v3 (and a small minority 
>look like they are dual-BSD licensed - I didn't know exactly what to grep 
>for, so I just picked a part of the normal BSD license, but they can 
>probably also be converted to GPLv3 thanks to the BSD license being a 
>strictly less restrictive license).
>
>(I picked just the '*.c' files because that seemed fairer. If you could 
>_all_ files, the "any later version" percentage drops even further).
>  
>

Given, the whole kernel cannot claim multiple licensing -- you have 
convinced me
on this point.

Jeff

>			Linus
>
>  
>

