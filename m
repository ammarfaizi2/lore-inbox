Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965097AbWI1PqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965097AbWI1PqS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 11:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbWI1PqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 11:46:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:23184 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965097AbWI1PqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 11:46:17 -0400
X-Authenticated: #5039886
Date: Thu, 28 Sep 2006 17:46:12 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Chase Venters <chase.venters@clientec.com>,
       Sergey Panov <sipan@sipan.org>, Patrick McFarland <diablod3@gmail.com>,
       Theodore Tso <tytso@mit.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
Message-ID: <20060928154612.GA2035@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	=?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	Linus Torvalds <torvalds@osdl.org>,
	Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
	Chase Venters <chase.venters@clientec.com>,
	Sergey Panov <sipan@sipan.org>,
	Patrick McFarland <diablod3@gmail.com>,
	Theodore Tso <tytso@mit.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	James Bottomley <James.Bottomley@steeleye.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com> <Pine.LNX.4.64.0609271945450.3952@g5.osdl.org> <1159415242.13562.12.camel@sipan.sipan.org> <200609272339.28337.chase.venters@clientec.com> <20060928135510.GR13641@csclub.uwaterloo.ca> <20060928141932.GA707@DervishD> <20060928144028.GA21814@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0609280748500.3952@g5.osdl.org> <20060928152020.GC21814@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060928152020.GC21814@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.09.28 17:20:20 +0200, Jörn Engel wrote:
> On Thu, 28 September 2006 08:04:13 -0700, Linus Torvalds wrote:
> > 
> > No. I _really_ want to clarify this, because so many people get it wrong. 
> > Really.
> > 
> > The "GPLv2 only" wording is really just a clarification. You don't need it 
> > for the project to be "GPLv2 only".
> > 
> > If a project says: "This code is licensed under this copyright license" 
> > and then goes on to quote the GPLv2, then IT IS NOT COMPATIBLE WITH THE 
> > GPLv3!
> > 
> > Or if you just say "I license my code under the GPLv2", IT IS NOT 
> > COMPATIBLE WITH THE GPLv3.
> 
> And this is an area where I slightly disagree with you.  While I would
> hope that you were right, I can easily imagine a judge ruling that "v2
> or later" in the preamble means that the project just signed a blank
> license of the FSF's discretion.

The preamble does not say "v2 or later", that's only in "How To" section
which is not part of the terms and conditions. But section 9 is even
worse than "v2 or later". Linus' second exmaple is fine, it mentions v2
and therefore it actually is v2 only. But the first one means _any_ GPL
version, even older versions, as it does not mention any version and
section 9 says "If the Program does not specify a version number of
this License, you may choose any version ever published by the Free
Software Foundation." ouch!

Björn

