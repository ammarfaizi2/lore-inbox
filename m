Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275128AbRIYRjT>; Tue, 25 Sep 2001 13:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275127AbRIYRjK>; Tue, 25 Sep 2001 13:39:10 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:16649 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S275128AbRIYRjA>; Tue, 25 Sep 2001 13:39:00 -0400
Date: Tue, 25 Sep 2001 13:39:22 -0400
Message-Id: <200109251739.f8PHdM406644@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
X-Newsgroups: linux.dev.kernel
In-Reply-To: <200109251404.f8PE4Oh06427@deathstar.prodigy.com>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200109251404.f8PE4Oh06427@deathstar.prodigy.com> I wrote:

>Write cache makes a big difference in normal use, where seeks and such
>can be optimized, but for a single process writing a single file (ie.
>dd) I don't see where it would or could help much.

  Sorry, ignore this, I got a phone call while replying to this and
glanced at the screen and transposed drive write cache with o/s write
cache. Ignore, I had a failure to restore context, and someone else has
made my intended point about ext2 being able to write stale blocks under
some failure modes.

	-bill

-- 
bill davidsen <davidsen@tmr.com>
 "If I were a diplomat, in the best case I'd go hungry.  In the worst
  case, people would die."
		-- Robert Lipe
