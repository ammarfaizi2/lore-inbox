Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751905AbWI1Okq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbWI1Okq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 10:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbWI1Okq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 10:40:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12170 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751905AbWI1Okp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 10:40:45 -0400
Date: Thu, 28 Sep 2006 07:40:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
cc: Chase Venters <chase.venters@clientec.com>, Theodore Tso <tytso@mit.edu>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Sergey Panov <sipan@sipan.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: <20060928094135.GB17873@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.64.0609280733590.3952@g5.osdl.org>
References: <1159319508.16507.15.camel@sipan.sipan.org>
 <Pine.LNX.4.61.0609270753590.19275@yvahk01.tjqt.qr> <1159342569.2653.30.camel@sipan.sipan.org>
 <Pine.LNX.4.61.0609271051550.19438@yvahk01.tjqt.qr>
 <1159359540.11049.347.camel@localhost.localdomain> <Pine.LNX.4.64.0609271000510.3952@g5.osdl.org>
 <Pine.LNX.4.64.0609271300130.7316@turbotaz.ourhouse> <20060927225815.GB7469@thunk.org>
 <Pine.LNX.4.64.0609271808041.7316@turbotaz.ourhouse>
 <Pine.LNX.4.64.0609271641370.3952@g5.osdl.org> <20060928094135.GB17873@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-511585410-1159454418=:3952"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-511585410-1159454418=:3952
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Thu, 28 Sep 2006, Jörn Engel wrote:
> 
> My graph traversion code I did for my thesis should have been merged
> into gcc, but I didn't even bother sending a patch.  Copyright assign
> my ***, thank you very much.

Yeah, I don't see why the FSF does that. Or I kind of see why, but it has 
always struck me as
 (a) against the whole point of the license
and
 (b) who the F*CK do they think they are?

I refuse to just sign over any copyrights I have. I gave you a license to 
use them, if you can't live with that, then go fish in somebody elses 
pond.

I had some code I tried to give to glibc back when I was doing Linux/axp, 
since glibc was really in pretty sad shape in some areas. I think I had a 
integer divide routine that was something like five times faster than the 
one in glibc, and about a tenth of the size. Things like that. So I wanted 
to give things back, but ended up just throwing in the towel and said "ok, 
if they don't want the code, whatever..".

If somebody pays me real bucks, I'll work for them, and I'm perfectly ok 
with letting them own copyright in the end result (ie I've done commercial 
software too, and I think it's only reasonable that since I did it for 
pay, I don't own that software myself). But copyright assignments "just 
because we want to control the end result"? No thank you.

> And that is in fact the primary reason, hacking gcc has been fun and I
> would like to do more, from a purely technical point of view.  But
> having to sign a large amount of legalese is the kind of thing I may
> have to do for a job, and they pay me for it.  It is not the kind of
> thing I do for fun.  No fun, no money - hell, why should I do
> something like that?!?
> 
> Thank you for not requiring copyright assignments, Linus.

I _hate_ copyright assignments. Maybe it's a European thing.

Of course, I also hate paperwork, so maybe it's just a "lazy" thing.

			Linus
--21872808-511585410-1159454418=:3952--
