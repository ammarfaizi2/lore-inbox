Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136594AbRAJVcB>; Wed, 10 Jan 2001 16:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136595AbRAJVbv>; Wed, 10 Jan 2001 16:31:51 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:3514 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S136594AbRAJVbo>; Wed, 10 Jan 2001 16:31:44 -0500
Date: Wed, 10 Jan 2001 22:33:35 +0100 (CET)
From: Matthias Juchem <matthias@gandalf.math.uni-mannheim.de>
Reply-To: Matthias Juchem <juchem@uni-mannheim.de>
To: Richard Torkar <ds98rito@thn.htu.se>
cc: Matthias Juchem <juchem@uni-mannheim.de>, <linux-kernel@vger.kernel.org>,
        Keith Owens <kaos@ocs.com.au>, Ulrich Drepper <drepper@redhat.com>
Subject: Re: bugreporting script - second try
In-Reply-To: <Pine.LNX.4.30.0101102205250.1391-100000@studpc91.thndorm.htu.se>
Message-ID: <Pine.LNX.4.30.0101102227500.12979-100000@gandalf.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2001, Richard Torkar wrote:

> I do not have any PPP, and no kdb installed on that machine, neither do I
> have procinfo. Shouldn't it say N/A or not found instead of the above? The
> ppp part is not true ;-).

Sure. I forgot to convert some function calls... But I'll have to rewrite
that part anyway, I don't like it.

> Other thing I thought about was the Ctrl-D thingy when entering text.
> What if ppl don't have any text to enter? Shouldn't is say on each line
> that if you don't have anything to write then just write N/A and press
> Ctrl-D? Because pressing Ctrl-D directly doesn't do any good.

You are right. I will change this...

> Sorry to just be a pain in the ass, and *very* sorry for not having the
> time to make a patch for you :)

That's fine, I *need* comments.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
