Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965032AbWI1PVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbWI1PVO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 11:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbWI1PVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 11:21:14 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:42166 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S965032AbWI1PVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 11:21:13 -0400
Date: Thu, 28 Sep 2006 17:20:20 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Chase Venters <chase.venters@clientec.com>,
       Sergey Panov <sipan@sipan.org>, Patrick McFarland <diablod3@gmail.com>,
       Theodore Tso <tytso@mit.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
Message-ID: <20060928152020.GC21814@wohnheim.fh-wedel.de>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com> <Pine.LNX.4.64.0609271945450.3952@g5.osdl.org> <1159415242.13562.12.camel@sipan.sipan.org> <200609272339.28337.chase.venters@clientec.com> <20060928135510.GR13641@csclub.uwaterloo.ca> <20060928141932.GA707@DervishD> <20060928144028.GA21814@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0609280748500.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0609280748500.3952@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 September 2006 08:04:13 -0700, Linus Torvalds wrote:
> 
> No. I _really_ want to clarify this, because so many people get it wrong. 
> Really.
> 
> The "GPLv2 only" wording is really just a clarification. You don't need it 
> for the project to be "GPLv2 only".
> 
> If a project says: "This code is licensed under this copyright license" 
> and then goes on to quote the GPLv2, then IT IS NOT COMPATIBLE WITH THE 
> GPLv3!
> 
> Or if you just say "I license my code under the GPLv2", IT IS NOT 
> COMPATIBLE WITH THE GPLv3.

And this is an area where I slightly disagree with you.  While I would
hope that you were right, I can easily imagine a judge ruling that "v2
or later" in the preamble means that the project just signed a blank
license of the FSF's discretion.

I can just as easily imagine a judge ruling that "simply copying the
GPL license verbatim and not removing the 'or later'" clause is does
not sufficiently demonstrate the authors intent to dual-license the
code.

And the likelihood of either ruling will depend on many things, but
will never reach 0 or 1.  It is a gray area where your legal advice is
just as bad as mine and your "GPLv2 only" clarification may in fact be
a fork I was talking about.  We just don't know until this has been
tested in court, which hopefully never happens.

Jörn

-- 
Joern's library part 11:
http://www.unicom.com/pw/reply-to-harmful.html
