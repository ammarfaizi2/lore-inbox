Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVBWWJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVBWWJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 17:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVBWWJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 17:09:25 -0500
Received: from mail.linicks.net ([217.204.244.146]:41347 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261616AbVBWWFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 17:05:31 -0500
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at mm/rmap.c:483!
Date: Wed, 23 Feb 2005 22:05:18 +0000
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502232205.18610.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But not all cases could be accounted in that way.  If you
> report back that memtest86 ran cleanly...

Hugh,

Nothing to do with the 'problem' in this thread, but an aside that is perhaps 
relevant.

On my main gateway, I couldn't get any kernel greater than 2.6.4 to run 
without an 'oops' after x amount of time.  It was always swapd or memory oops 
that caused it.

I ran memtest86 a few times with no errors - reaseated everything, new fans 
etc. etc.  No go.

I upgraded memory - all 4 sticks - over Christmas, and after a few weeks 
uptime, tried 2.4.10 again.

I have had no problems since - so perhaps I did have bad memory (it was old).  
But all tests never showed anything untoward.

I was always suspicious why my 2.6.4 build ran OK, but newer builds always 
failed.  Could it be a subtle fault in memory whilst building kernels that 
does it?

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
