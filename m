Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264137AbTLOVo4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 16:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264142AbTLOVo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 16:44:56 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:48830 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S264137AbTLOVoy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 16:44:54 -0500
Date: Mon, 15 Dec 2003 13:44:52 -0800
From: Larry McVoy <lm@bitmover.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC - tarball/patch server in BitKeeper
Message-ID: <20031215214452.GB8130@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
References: <20031214172156.GA16554@work.bitmover.com> <2259130000.1071469863@[10.10.2.4]> <20031215151126.3fe6e97a.vsu@altlinux.ru> <20031215132720.GX7308@phunnypharm.org> <20031215192402.528ce066.vsu@altlinux.ru> <20031215183138.GJ6730@dualathlon.random> <20031215185839.GA8130@work.bitmover.com> <20031215194057.GL6730@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031215194057.GL6730@dualathlon.random>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies, I should have known better than trying to make you happy.
It's time I learned that some people will never be happy no matter what
you do.  Fair enough.

Tupshin asked about clarification about using the BK metadata so he can
go work on whatever SCM it is that he's working on this week.  It should
be clear from the license but in case it isn't, yes, it's a violation
to use BK to transfer the information about how BK manages the data
to some other SCM developer, directly or indirectly.  You have every
right to extract every patch you want, as patches.  The second you start
extracting BK metadata for the benefit of some SCM development effort,
that's a violation of the BKL.

It's your data and that data includes your checkin comments but that is
all.  It's our tool and the use of our tool to export information how the
data is managed is a violation of our license.  I can't imagine this comes
as any surprise, any vendor who has provided some innovation is going
to protect that innovation.  BTW - Tupshin knows this, I made it clear
on the phone when he was asking me for a job, so why he's grinding this
ax I don't know.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
