Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030553AbWBAGxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030553AbWBAGxF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 01:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030554AbWBAGxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 01:53:04 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:57556 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1030553AbWBAGxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 01:53:03 -0500
Date: Wed, 01 Feb 2006 01:52:51 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
In-reply-to: <Pine.LNX.4.64.0601312125130.3920@sheen.jakma.org>
To: linux-kernel@vger.kernel.org
Cc: Paul Jakma <paul@clubi.ie>, Linus Torvalds <torvalds@osdl.org>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chase Venters <chase.venters@clientec.com>,
       "linux-os \\(Dick Johnson\\)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>
Reply-to: gene.heskett@verizon.net
Message-id: <200602010152.57732.gene.heskett@verizon.net>
Organization: Absolutely none - usually detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <43D114A8.4030900@wolfmountaingroup.com>
 <Pine.LNX.4.64.0601311152070.7301@g5.osdl.org>
 <Pine.LNX.4.64.0601312125130.3920@sheen.jakma.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 January 2006 16:45, Paul Jakma wrote:
>On Tue, 31 Jan 2006, Linus Torvalds wrote:
>> under the GPL", not "GPLv2 or later". The _only_ license rights
>> anybody ever had to those files come from the COPYING file, which
>> very clearly states that it's "version 2, 1991"
>
>No one has disputed that I think. My understanding of that text, as
>in:
>
>
>                     GNU GENERAL PUBLIC LICENSE
>                        Version 2, June 1991
>
>Is that it refers as the version of the license itself. The 'revision
>ID' of the published license. And that very version of the GPL has a
>clause to allow version 'conversion' in section 9 to other versions.
>
>> The COPYING file was edited (over _five_ years ago) to clarify the
>> issue,
>
>That wasn't clarifying the issue, that was to make sure section 9's
>"any version" could no longer apply. You even seem to have
>acknowledged that very text of section 9 in your announcement of
>2.4.0-test8's COPYING change:
>
>`There's been some discussions of a GPL v3 which would limit
>licensing to certain "well-behaved" parties, and I'm not sure I'd
>agree with such restrictions - and the GPL itself allows for "any
>version" so I wanted to make this part unambigious as far as my
>personal code is concerned."'
>
>From:
>
>http://www.uwsg.iu.edu/hypermail/linux/kernel/0009.1/0096.html
>
>Until you made that change, a reasonable person might have presumed
>that lack of version statement (no, the actual GPL license version at
>the top of the GPL itself does not count ;) ) would mean section 9
>would have applied.
>
>I'm not familiar enough with Linux kernel history to know whether the
>implicit "only version 2" view was widely known amongst kernel
>developers back then, prior to the edit.
>
>> and that has been the case for the last 5+ years.
>
>Right. The "version 2 only" only has been the status quo for 5+ years
>now, so most people must be content with it, grudgingly or not.
>
>> Exactly. That's why I added the clarification on top of the COPYING
>> file: people _have_ been confused.
>
>Read your own email again. :)
>
>> That confusion doesn't stem from Linux, btw, but from the FSF
>> distribution of the GPLv2 license itself. The license is distributed
>> as one single file, which actually contains three parts: (1) the
>> "preamble", (2) the actual license itself and (3) the "How to Apply
>> These Terms to Your New Programs" mini-FAQ.
>>
>> And that third part actually contains the wording "(at your option)
>> any later version.",
>
>Right.
>
>But the actual /license/, the second part, says none specified ->
>"any version ever published" in section 9. The "any later version"
>text is in the 3rd part, the suggested preamble.
>
>> files.  In other words, that was never actually part of the license
>> itself, but just a "btw, here's how you should use it" post-script.
>
>Right. But there are *two* (any.*version):
>
>1. "Any version", which is:
>
>  a) In the license itself, to cover case where programme
>     doesn't specify which version(s) apply, as section 9.
>     (ie in the "second part").
>
>  b) the text you refered to in the 2.4.0-test8 above (ie
>      you were looking at section 9 back then, not the preamble ;) )
>
>2. "Any later version", which is what is mentioned in the preamble
>    (the third part).
>
>Alan's reply to you was on the basis of 1. You're arguing based on 2,
>having apparently completely overlooked 1 (though you apparently had
>not back when you composed that 2.4.0-test8 email).
>
>regards,

Well, IANAL either, but section 9 isn't the least bit ambiguous in my 
opinion.  To quote what everyone with a functioning eye can read:

  9. The Free Software Foundation may publish revised and/or new 
versions of the General Public License from time to time.  Such new 
versions will be similar in spirit to the present version, but may 
differ in detail to address new problems or concerns.

Each version is given a distinguishing version number.  If the Program
specifies a version number of this License which applies to it and "any
later version", you have the option of following the terms and 
conditions either of that version or of any later version published by 
the Free Software Foundation.  If the Program does not specify a 
version number of this License, you may choose any version ever 
published by the Free Software Foundation.

End of snip.  The point is that version 2 is spelled out at the top of 
the COPYING file and the word "and" preceeds the "any later version" in 
the above paragraph, which it does not in the top of the COPYING file 
specifying the license, means that its version 2 and thats the end of 
it.  There is no "any later version" in the statement specifying the 
license version at the top of the COPYING file.

Why is that so hard to grasp?

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
