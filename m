Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266852AbSLPRTE>; Mon, 16 Dec 2002 12:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266859AbSLPRSI>; Mon, 16 Dec 2002 12:18:08 -0500
Received: from bitmover.com ([192.132.92.2]:27029 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S266852AbSLPRRn>;
	Mon, 16 Dec 2002 12:17:43 -0500
Date: Mon, 16 Dec 2002 09:25:34 -0800
From: Larry McVoy <lm@bitmover.com>
To: Ben Collins <bcollins@debian.org>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Larry McVoy <lm@bitmover.com>
Subject: Re: Notification hooks
Message-ID: <20021216092534.F432@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Ben Collins <bcollins@debian.org>,
	Dave Jones <davej@codemonkey.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, Larry McVoy <lm@bitmover.com>
References: <20021216171218.GV504@hopper.phunnypharm.org> <20021216171925.GC15256@suse.de> <20021216172330.GW504@hopper.phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021216172330.GW504@hopper.phunnypharm.org>; from bcollins@debian.org on Mon, Dec 16, 2002 at 12:23:30PM -0500
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> True. But if the load is too much for bkbits to handle, I'd like Linus
> to consider it just for maintainers.

bkbits can keep up, that's not the issue.  The main problem is coming up
with an interface that makes sense for people.  The mechanisms are all 
there already in the form of triggers.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
