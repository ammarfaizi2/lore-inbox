Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262037AbTCLVHx>; Wed, 12 Mar 2003 16:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262042AbTCLVHw>; Wed, 12 Mar 2003 16:07:52 -0500
Received: from bitmover.com ([192.132.92.2]:55983 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262037AbTCLVHt>;
	Wed, 12 Mar 2003 16:07:49 -0500
Date: Wed, 12 Mar 2003 13:18:32 -0800
From: Larry McVoy <lm@bitmover.com>
To: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030312211832.GA6587@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
References: <20030312174244.GC13792@work.bitmover.com> <Pine.LNX.4.44.0303121324510.14172-100000@xanadu.home> <20030312195120.GB7275@work.bitmover.com> <20030312210513.GA6948@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030312210513.GA6948@nevyn.them.org>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Larry, this brings up something I was meaning to ask you before this
> thread exploded.  What happens to those "logical change" numbers over
> time?

They are stable in the CVS tree because the CVS tree isn't distributed.
So "Logical change 1.900" in the context of the exported CVS tree is 
always the same thing.  That's one advantage centralized has, things
don't shift around on you.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
