Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263068AbSJGO4A>; Mon, 7 Oct 2002 10:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263069AbSJGO4A>; Mon, 7 Oct 2002 10:56:00 -0400
Received: from bitmover.com ([192.132.92.2]:16297 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S263068AbSJGOz7>;
	Mon, 7 Oct 2002 10:55:59 -0400
Date: Mon, 7 Oct 2002 08:01:32 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: best version for server?
Message-ID: <20021007080132.A13486@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're not sure if it is something we've done or just increased usage, but 
bkbits.net is getting hammered lately.  We see load averages in ~15-20 
range pretty regularly.  It's got some nasty characteristics from the
point of view of server/VM system, tons of data and not really any good
working sets.  I'm running 2.4.5 on it and that clearly has to go.  I am
going to try the rmap kernel but I'm open to other suggestions.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
