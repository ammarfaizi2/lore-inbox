Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTDPWig (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 18:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbTDPWig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 18:38:36 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:27294 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S261823AbTDPWie
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 18:38:34 -0400
Date: Wed, 16 Apr 2003 15:50:24 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Cc: sparsell@penguincomputing.com, sockman@penguincomputing.com
Subject: kernel.bkbits.net outage
Message-ID: <20030416225024.GA32731@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org, sparsell@penguincomputing.com,
	sockman@penguincomputing.com
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

Some of you use kernel.bkbits.net (*) and have noticed that it is off
the air.  It's looking like it may have a blown power supply and Penguin
is on it; ETA for a fix is tomorrow some time (it's colocated and they
are going down there to grab the box and swap out parts).

(*) This is a fast machine which was provided by Penguin Computing
and BitMover as a place for people who do not have access to a high
end machine and could use one.  It's used for various BitKeeper tasks
(translation: it can run a bk -r check -ac in about 15 seconds on the
2.5 tree). It is also the host for the BK->CVS repositories, so those
are off the air as well (we have a mirror here so if you are dieing for
your bits in CVS let me know).

If you use BK and you need a login on fast x86 box, contact me or
davem@redhat.com and we'll set you up an account when it comes back
up.  If you appreciate this box, buying some hardware from Penguin
Computing (or getting someone else to do so) is a good way to show
that appreciation.  Penguin deserves a lot of thanks, it's a nice box
and they provide the power, bandwidth, and support which are all hidden
costs and thankless tasks.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
