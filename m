Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965113AbWI1Pi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbWI1Pi7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 11:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965118AbWI1Pi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 11:38:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28833 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965113AbWI1Pi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 11:38:59 -0400
Date: Thu, 28 Sep 2006 08:38:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
cc: Chase Venters <chase.venters@clientec.com>, Sergey Panov <sipan@sipan.org>,
       Patrick McFarland <diablod3@gmail.com>, Theodore Tso <tytso@mit.edu>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: <20060928135510.GR13641@csclub.uwaterloo.ca>
Message-ID: <Pine.LNX.4.64.0609280831430.3952@g5.osdl.org>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>
 <Pine.LNX.4.64.0609271945450.3952@g5.osdl.org> <1159415242.13562.12.camel@sipan.sipan.org>
 <200609272339.28337.chase.venters@clientec.com> <20060928135510.GR13641@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Sep 2006, Lennart Sorensen wrote:
> 
> I wonder if perhaps the solution should be that the GPLv3 draft should
> be renamed to something else to allow RMS to create his new license that
> does exactly what he wants it to do, without hijacking existing GPLv2
> code using a license that in many people's opinion is NOT in the spirit
> of the GPLv2 (which it could be argued overrides the "or later" part of
> the license).

I've argued that in the past, and so have others. 

I think the GPLv3 could well try to stand on its own, without being 
propped up by a lot of code which was written by people who may or may not 
agree with the changes.

The whole "in the spirit of" thing is very much debatable - the FSF will 
claim that it's in _their_ spirit, but the whole point of the language is 
not to re-assure _them_, but others, so the argument (which I've heard 
over and over again) that _their_ spirit matters more is somewhat dubious.

I would personally think that a much less contentious thing would have 
been to make a future "GPL" only happens if some court of law actually 
struck down something, or some actual judge made it clear that something 
could be problematic. In other words, it shouldn't extend on the meaning 
of the license, it should be used to _fix_ actual problems. Not imagined 
ones.

Instead, so far, every single lawsuit about the GPLv2 has instead 
strengthened the thing. NONE of the worries that people have had 
(language, translation, whatever) have actually been problems. The GPLv2 
is stronger today than it was 15 years ago!

But there are certainly tons of non-legal reasons why the FSF doesn't want 
to go that way.

			Linus
