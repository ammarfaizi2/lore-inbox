Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264137AbTEJNwS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 09:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264189AbTEJNwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 09:52:18 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:2718 "EHLO smtp.bitmover.com")
	by vger.kernel.org with ESMTP id S264137AbTEJNwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 09:52:16 -0400
Date: Sat, 10 May 2003 07:04:55 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: kernel.bkbits.net and BK->CVS gateway
Message-ID: <20030510140455.GA23475@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.5, required 4.5,
	DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try #2, first one didn't seem make it.

----- Forwarded message from Linux Kernel Mailing List <linux-kernel@vger.kernel.org> -----

Date: Fri, 9 May 2003 19:46:13 -0700
From: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: hpa@transmeta.com, davem@redhat.com
Subject: kernel.bkbits.net and BK->CVS gateway

We replaced the bad drive and are restoring home directories.
Once we have the restore done, we'll turn on people's accounts again.
We are shutting off nightly backups for a few days so that we have 
the backups to cherry pick any missing config files, etc.

This bad disk is the cause of the CVS gateway being screwed up, we should
have that back online tonight or tomorrow.  Sorry about the downtime.

Peter, once it's back can you do whatever you did to get the resync stuff
going (if you put a startup script in /etc/init.d, don't worry about it, 
I'll restore that and restart).

Dave, I put RH 7.3 on there but didn't install any security fixes, you get
to do that fun job if you care.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm

----- End forwarded message -----

-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
