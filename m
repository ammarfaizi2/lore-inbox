Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269005AbTBWWjp>; Sun, 23 Feb 2003 17:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269006AbTBWWjp>; Sun, 23 Feb 2003 17:39:45 -0500
Received: from warden3-p.diginsite.com ([208.147.64.186]:40906 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id <S269005AbTBWWjo>; Sun, 23 Feb 2003 17:39:44 -0500
From: David Lang <david.lang@digitalinsight.com>
To: davidm@hpl.hp.com
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Date: Sun, 23 Feb 2003 14:48:48 -0800 (PST)
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <15961.19948.882374.766245@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0302231444490.8609-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would call a 15% lead over the ia64 pretty substantial.

yes it's not the same clock speed, but if that's the clock speed they can
achieve on that process it's equivalent. the P4 covers a LOT of sins by
ratcheting up it's speed, what matters is the final capability, not the
capability/clock (if capability/clock was what mattered the AMD chips
would have put intel out of business and the P4 would be as common as
ia-64)

David Lang


 On Sun, 23 Feb 2003, David Mosberger wrote:

> Date: Sun, 23 Feb 2003 14:40:44 -0800
> From: David Mosberger <davidm@napali.hpl.hp.com>
> Reply-To: davidm@hpl.hp.com
> To: Linus Torvalds <torvalds@transmeta.com>
> Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
> Subject: Re: Minutes from Feb 21 LSE Call
>
> >>>>> On Sun, 23 Feb 2003 13:34:32 -0800 (PST), Linus Torvalds <torvalds@transmeta.com> said:
>
>  Linus> Last I saw P4 was kicking ia-64 butt on specint and friends.
>
> I don't think so.  According to Intel [1], the highest clockfrequency
> for a 0.18um part is 2GHz (both for Xeon and P4, for Xeon MP it's
> 1.5GHz).  The highest reported SPECint for a 2GHz Xeon seems to be 701
> [2].  In comparison, a 1GHz McKinley gets a SPECint of 810 [3].
>
> 	--david
>
> [1] http://www.intel.com/support/processors/xeon/corespeeds.htm
> [2] http://www.specbench.org/cpu2000/results/res2002q1/cpu2000-20020128-01232.html
> [3] http://www.specbench.org/cpu2000/results/res2002q3/cpu2000-20020711-01469.html
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
