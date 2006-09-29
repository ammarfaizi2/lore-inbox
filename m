Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030293AbWI2INs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbWI2INs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 04:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbWI2INs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 04:13:48 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:23221 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1030311AbWI2INq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 04:13:46 -0400
Date: Fri, 29 Sep 2006 10:04:24 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Linus Torvalds <torvalds@osdl.org>, Patrick McFarland <diablod3@gmail.com>,
       Chase Venters <chase.venters@clientec.com>,
       Theodore Tso <tytso@mit.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Sergey Panov <sipan@sipan.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: <Pine.LNX.4.61.0609281312350.31392@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0609291003230.20243@yvahk01.tjqt.qr>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com> 
 <Pine.LNX.4.61.0609270753590.19275@yvahk01.tjqt.qr>  <1159342569.2653.30.camel@sipan.sipan.org>
  <Pine.LNX.4.61.0609271051550.19438@yvahk01.tjqt.qr> 
 <1159359540.11049.347.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0609271000510.3952@g5.osdl.org>  <Pine.LNX.4.64.0609271300130.7316@turbotaz.ourhouse>
  <20060927225815.GB7469@thunk.org>  <Pine.LNX.4.64.0609271808041.7316@turbotaz.ourhouse>
  <Pine.LNX.4.64.0609271641370.3952@g5.osdl.org>
 <d577e5690609271754u395e56ffr1601fddd6d4639a3@mail.gmail.com>
 <Pine.LNX.4.64.0609271945450.3952@g5.osdl.org> <Pine.LNX.4.61.0609281312350.31392@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Every time I accidentally execute `uname` with an -a instead of
>a -r, I am reminded of the history rewrite as I am presented with:
>
>Linux chaos.analogic.com 2.6.16.24 #1 SMP PREEMPT
>  Wed Jul 12 11:32:34 EDT 2006 i686 i686 i386 GNU/Linux
>                                              ^^^^^^^^^

Do you even know what that field is supposed to be?
Right, it is `uname -o`, and not `uname -s`.



Jan Engelhardt
-- 
