Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031269AbWI1AE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031269AbWI1AE1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 20:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031271AbWI1AE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 20:04:26 -0400
Received: from ns.suse.de ([195.135.220.2]:25217 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1031269AbWI1AEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 20:04:25 -0400
From: Neil Brown <neilb@suse.de>
To: Chase Venters <chase.venters@clientec.com>
Date: Thu, 28 Sep 2006 10:03:57 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17691.4461.70747.594419@cse.unsw.edu.au>
Cc: Theodore Tso <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Sergey Panov <sipan@sipan.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: message from Chase Venters on Wednesday September 27
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>
	<1159319508.16507.15.camel@sipan.sipan.org>
	<Pine.LNX.4.61.0609270753590.19275@yvahk01.tjqt.qr>
	<1159342569.2653.30.camel@sipan.sipan.org>
	<Pine.LNX.4.61.0609271051550.19438@yvahk01.tjqt.qr>
	<1159359540.11049.347.camel@localhost.localdomain>
	<Pine.LNX.4.64.0609271000510.3952@g5.osdl.org>
	<Pine.LNX.4.64.0609271300130.7316@turbotaz.ourhouse>
	<20060927225815.GB7469@thunk.org>
	<Pine.LNX.4.64.0609271808041.7316@turbotaz.ourhouse>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday September 27, chase.venters@clientec.com wrote:
> 
> What I was really addressing here is that the whole F/OSS community 
> exploded over the news that Linux was not adopting the GPLv3. I think it's 
> fair to say that the reason why Linux is not adopting GPLv3 (aside from 
> the very practical matter of gaining the consensus of copyright holders)
> is that Linus and other top copyright holders don't think what Tivo is 
> doing is wrong. But when that statement first came out, it was almost lost 
> in the noise of "The FSF is not going to listen to us, and what about 
> encryption keys?" The former probably has no place outside of LKML; the 
> latter is the sort of thing you'd bring up at gplv3.fsf.org if you wanted 
> to participate in the process.

I don't think that anyone is saying that what Tivo is doing isn't
wrong.  What is being said is that the license is the wrong place to
try to stop this sort of behaviour.  It is too broad a brush.
There are a number of different reasons for wanting to use
technological measures for stopping people from re-purposing a device
and they aren't necessarily all bad.  Do we want our code to be
prohibited from being used in all of these cases?  Some people think
not.

But I wonder if GPLv3 will really stop Tivo....
I just read it again and saw - at the end of section 1.

  The Corresponding Source need not include anything that users can
  regenerate automatically from other parts of the Corresponding
  Source. 

So if Tivo included the code they used to generate the key, then they
don't need to include the key itself :-)  Users can regenerate the key
form that program.  Not sure how long it will take though.

NeilBrown

