Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264673AbSLaQXe>; Tue, 31 Dec 2002 11:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264681AbSLaQXe>; Tue, 31 Dec 2002 11:23:34 -0500
Received: from bitmover.com ([192.132.92.2]:62397 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S264673AbSLaQXd>;
	Tue, 31 Dec 2002 11:23:33 -0500
Date: Tue, 31 Dec 2002 08:31:54 -0800
From: Larry McVoy <lm@bitmover.com>
To: Herman Oosthuysen <Herman@WirelessNetworksInc.com>
Cc: linux <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: Re: Indention - why spaces?]
Message-ID: <20021231163154.GD9423@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Herman Oosthuysen <Herman@WirelessNetworksInc.com>,
	linux <linux-kernel@vger.kernel.org>
References: <3E11C4E2.2050306@WirelessNetworksInc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E11C4E2.2050306@WirelessNetworksInc.com>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Larry, you can save yourself a lot of trouble, time and money: Create an
> indent configuration file and tell your people to use it.  That is
> exactly why indent was written many years ago.

Indent is fine as a first pass, it doesn't handle everything properly.
If it did, I think I would have figured it out by now.  And no, I'm
not going to go fix indent, I looked at the problems and the fixes 
and decided to pass.  Some of them just aren't worth fixing in 
indent.

Besides, I really don't believe in giving people crutches, I believe
in teaching them what it is I want and why.  That tends to stick.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
