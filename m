Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161324AbWI2GUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161324AbWI2GUq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 02:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161419AbWI2GUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 02:20:46 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:25500 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1161324AbWI2GUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 02:20:45 -0400
Date: Fri, 29 Sep 2006 08:08:58 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Chase Venters <chase.venters@clientec.com>,
       Sergey Panov <sipan@sipan.org>, Patrick McFarland <diablod3@gmail.com>,
       Theodore Tso <tytso@mit.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: <Pine.LNX.4.64.0609280748500.3952@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0609290757400.30682@yvahk01.tjqt.qr>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>
 <Pine.LNX.4.64.0609271945450.3952@g5.osdl.org> <1159415242.13562.12.camel@sipan.sipan.org>
 <200609272339.28337.chase.venters@clientec.com> <20060928135510.GR13641@csclub.uwaterloo.ca>
 <20060928141932.GA707@DervishD> <20060928144028.GA21814@wohnheim.fh-wedel.de>
 <Pine.LNX.4.64.0609280748500.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>And the GPLv2 and GPLv3 really _are_ mutually incompatible. There is 
>absolutely nothing in the GPLv2 that is inherently compatible with the 
>GPLv3, and the _only_ way you can mix code is if you explicitly 
>dual-license it.
>
>Ie, GPLv2 and GPLv3 are compatible only the same way GPLv2 is compatible 
>with a commercial proprietary license: they are compatible only if you 
>release the code under a dual license. 
>
>The whole "or later" phrase is legally _no_ different at all from a dual 
>licensing (it's just more open-ended, and you don't know what the "or 
>later" will be, so you're basically saying that you trust the FSF 
>implicitly).

So what would happen if I add an essential GPL2-only file to a "GPL2
or later" project? Let's recall, a proprietary program that
combines/derives with GPL code makes the final binary GPL (and hence
the source, etc. and whatnot, don't stretch it). Question: The Linux
kernel does have GPL2 and GPL2+later combined, what does this make
the final binary?

(Maybe you implicitly answered it by this already, please indicate): 
>Exactly. The GPLv3 can _only_ take over a GPLv2 project if the "or later" 
>exists.
>From that I'd say it remains GPL2 only.


Thanks for the clarification (though I know we're all IANALs.)

Jan Engelhardt
-- 
