Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265974AbUHSNKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265974AbUHSNKb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 09:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266065AbUHSNKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 09:10:31 -0400
Received: from albireo.ucw.cz ([81.27.203.89]:8067 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S265974AbUHSNK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 09:10:27 -0400
Date: Thu, 19 Aug 2004 15:10:26 +0200
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: kernel@wildsau.enemy.org, diablod3@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040819131026.GA9813@ucw.cz>
References: <200408041233.i74CX93f009939@wildsau.enemy.org> <d577e5690408190004368536e9@mail.gmail.com> <4124A024.nail7X62HZNBB@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4124A024.nail7X62HZNBB@burner>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> It makes no sense to comment things if you don't know what's going on.
> So please avoid comments like this in the future.
> 
> Your statement "it may be now moved to non-free in Debian in the near future"
> is just complete nonsense. Of course, I am in discussions with Debian people 
> about the best method to force SuSE not to publish broken versions of cdrtools 
> in the future.

Hmmm, it seems that the matter is so complicated that even you don't know what's
going on ;-)  The latest issue of Debian Weekly News explicitly mentions that
cdrecord has to go to non-free unless the license additions get changed.

> Let me comment what SuSE is currently doing with cdrtools:

You accuse Linux distributors of being non-cooperative, but I think that the
major cause of not cooperating is that just everybody in the Linux world does
not share your set of dogmata, the recent discussion about addressing devices
being a prime example. Although I very much appreciate your experience with
CD recording, I feel that the ways of referring to devices should be best
left to Linux developers.

(BTW: I am not sure I haven't missed anything in the long cdrecord-related
threads on the LKML, but I still haven't seen what is exactly so broken on the
cdrecord shipped by SUSE.)

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
System going down at 5 pm to install scheduler bug.
