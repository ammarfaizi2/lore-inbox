Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263105AbSKJCnB>; Sat, 9 Nov 2002 21:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263143AbSKJCnA>; Sat, 9 Nov 2002 21:43:00 -0500
Received: from dp.samba.org ([66.70.73.150]:8836 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263105AbSKJCnA>;
	Sat, 9 Nov 2002 21:43:00 -0500
Date: Sat, 9 Nov 2002 19:01:41 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Cc: linux-kernel@vger.kernel.org, m.kerrisk@gmx.net, mbp@samba.org
Subject: Re: [TRIVIAL] 2.4.19 Fix adjtimex when txc->modes == 0
Message-Id: <20021109190141.2e638080.rusty@rustcorp.com.au>
In-Reply-To: <3DCB9884.19253.AE2807@localhost>
References: <20021108081529.559392C3AF@lists.samba.org>
	<3DCB9884.19253.AE2807@localhost>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Nov 2002 10:57:08 +0100
"Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de> wrote:

> Rusty,
> 
> your EMail address (Rusty Trivial Russell <@rustcorp.com.au>) 
> is broken. I'm replying to linux-kernel instead.

Samba.org seems to bounce my mails intermittantly.  I don't suppose you
kept the bounce message?
 
> I had reported this problem a long time (over a year at least) 
> to the list. I found no 100% solution that is compatible with 
> the old kernel version.

OK, I'll drop this patch.  It'd be nice to have a solution for 2.6
though.

Cheers,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
