Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262963AbUE1NZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbUE1NZA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 09:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263000AbUE1NY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 09:24:59 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:38074 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S262963AbUE1NYn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 09:24:43 -0400
Date: Fri, 28 May 2004 06:24:36 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Andrew Morton <akpm@osdl.org>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFD] Explicitly documenting patch submission
Message-ID: <20040528132436.GA11497@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Theodore Ts'o <tytso@mit.edu>,
	"La Monte H.P. Yarroll" <piggy@timesys.com>,
	Andrew Morton <akpm@osdl.org>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20040527062002.GA20872@work.bitmover.com> <20040527010409.66e76397.akpm@osdl.org> <40B6591C.80901@timesys.com> <20040527214638.GA18349@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040527214638.GA18349@thunk.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ChangeSet@1.1743.1.52, 2004-05-25 08:43:49-07:00, akpm@osdl.org
>   [PATCH] minor sched.c cleanup
> 
>   Signed-off-by: Christian Meder <chris@onestepahead.de>
>   Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
>   The following obviously correct patch from Christian Meder simplifies the
>   DELTA() define.
> 
> Which do show the original author.  

Not in any useful way.  If I go look at the file history, which is what
I'm going to do when tracking down a bug, all I see on the files included
in this changeset is akpm@osdl.org.

That means any annotated listing (BK or CVS blame) shows the wrong author.

ChangeSet@1.1743.2.52, 2004-05-25 08:43:49-07:00, akpm@osdl.org +1 -0
  [PATCH] minor sched.c cleanup
  
  Signed-off-by: Christian Meder <chris@onestepahead.de>
  Signed-off-by: Ingo Molnar <mingo@elte.hu>
  
  The following obviously correct patch from Christian Meder simplifies the
  DELTA() define.

vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  kernel/sched.c@1.302, 2004-05-25 02:58:45-07:00, akpm@osdl.org +1 -2
    minor sched.c cleanup
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
