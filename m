Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbQL1In6>; Thu, 28 Dec 2000 03:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129552AbQL1Inh>; Thu, 28 Dec 2000 03:43:37 -0500
Received: from c290168-a.stcla1.sfba.home.com ([65.0.213.53]:7154 "HELO
	top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S129525AbQL1Inf>; Thu, 28 Dec 2000 03:43:35 -0500
From: brian@worldcontrol.com
Date: Thu, 28 Dec 2000 00:19:49 -0800
To: linux-kernel@vger.kernel.org
Subject: Which resource is temporarily unavailable
Message-ID: <20001228001949.A7365@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting

zsh: fork failed: resource temporarily unavailable

on a machine.  It has 510 processes which are mostly
asleep, running under various user ids.

Multiple user accounts get the error when it occurs, though
root seems to continue to work fine.

How do I determine which resource is the problem so I can
fix the shortage?

System is Linux 2.2.18 with 384MB RAM.

Thanks,

-- 
Brian Litzinger <brian@worldcontrol.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
