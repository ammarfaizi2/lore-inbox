Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263741AbUE1RR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263741AbUE1RR2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 13:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUE1RR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 13:17:27 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:30909 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263711AbUE1RRQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 13:17:16 -0400
Date: Fri, 28 May 2004 10:16:59 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Dave Jones <davej@redhat.com>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Andrew Morton <akpm@osdl.org>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFD] Explicitly documenting patch submission
Message-ID: <20040528171659.GA19715@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Theodore Ts'o <tytso@mit.edu>, Dave Jones <davej@redhat.com>,
	"La Monte H.P. Yarroll" <piggy@timesys.com>,
	Andrew Morton <akpm@osdl.org>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20040527062002.GA20872@work.bitmover.com> <20040527010409.66e76397.akpm@osdl.org> <40B6591C.80901@timesys.com> <20040527214638.GA18349@thunk.org> <20040528132436.GA11497@work.bitmover.com> <20040528150740.GF18449@thunk.org> <20040528151919.GC11265@redhat.com> <20040528171110.GA21435@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040528171110.GA21435@thunk.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A compromise position might be to store multiple authorships (who
> committed it into BK, who was the original author, etc.) into the SCM
> metadata, but I'm not sure we could justify your putting that kind
> feature into BK, especially when it's likely that the only users of it
> would be the Linux kernel tree.

We're always open to adding new features but we're not going to code around
delibrate misuse of the system.  We wouldn't be doing you any favors by 
doing so.  If you ever migrate off of BK then you'll need the next system
to have those same workarounds.

Go educate Linus that he got this one wrong, he's a reasonable guy, he
listens if enough people scream.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
