Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263460AbUE1P1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbUE1P1m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 11:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263551AbUE1P1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 11:27:42 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:52667 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263460AbUE1P1j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 11:27:39 -0400
Date: Fri, 28 May 2004 08:27:30 -0700
From: Larry McVoy <lm@bitmover.com>
To: Dave Jones <davej@redhat.com>, "Theodore Ts'o" <tytso@mit.edu>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Andrew Morton <akpm@osdl.org>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFD] Explicitly documenting patch submission
Message-ID: <20040528152730.GB15718@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Dave Jones <davej@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
	"La Monte H.P. Yarroll" <piggy@timesys.com>,
	Andrew Morton <akpm@osdl.org>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20040527062002.GA20872@work.bitmover.com> <20040527010409.66e76397.akpm@osdl.org> <40B6591C.80901@timesys.com> <20040527214638.GA18349@thunk.org> <20040528132436.GA11497@work.bitmover.com> <20040528150740.GF18449@thunk.org> <20040528151919.GC11265@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040528151919.GC11265@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> bk revtool $filename
> ctrl-c in the gui that pops up

That's just "c", Ctrl-c just happens to work and is not supported.  And
"c" is a very funny listing, it's rare that that is what you want.
I suspect what you want is to click the last node and then hit "a".

> click line that looks interesting - jumps to the cset with
> commit comments.

double click.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
