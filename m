Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267510AbTALUYj>; Sun, 12 Jan 2003 15:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267491AbTALUXh>; Sun, 12 Jan 2003 15:23:37 -0500
Received: from zork.zork.net ([66.92.188.166]:40672 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S267497AbTALUXN>;
	Sun, 12 Jan 2003 15:23:13 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: any chance of 2.6.0-test*?
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: SALACIOUS IMAGININGS, SLOTHFUL
 INDUCTION
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sun, 12 Jan 2003 20:32:01 +0000
In-Reply-To: <200301122018.h0CKIcWN004203@turing-police.cc.vt.edu> (Valdis.Kletnieks@vt.edu's
 message of "Sun, 12 Jan 2003 15:18:38 -0500")
Message-ID: <6uk7haxg72.fsf@zork.zork.net>
User-Agent: Gnus/5.090011 (Oort Gnus v0.11) Emacs/21.2
 (i386-debian-linux-gnu)
References: <Pine.LNX.4.44.0301121134340.14031-100000@home.transmeta.com>
	<1042401596.1209.51.camel@RobsPC.RobertWilkens.com>
	<200301122018.h0CKIcWN004203@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Valdis.Kletnieks@vt.edu quotation:

> The real problem is that C doesn't have a good multi-level "break"
> construct.  On the other hand, I don't know of any language that has
> a good one - some allow "break 3;" to break 3 levels- but that's
> still bad because you get screwed if somebody adds an 'if'
> clause....

Perl's facility for labelling blocks and jumping to the beginning or
end with 'next' and 'last' may be close to what you want, but I don't
know if it's ever been implemented in a language one could sensibly
use to write a kernel.

-- 
 /                          |
[|] Sean Neakums            |  Questions are a burden to others;
[|] <sneakums@zork.net>     |      answers a prison for oneself.
 \                          |
