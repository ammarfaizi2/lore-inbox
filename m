Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264839AbTF0Vyt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 17:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264829AbTF0Vyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 17:54:49 -0400
Received: from pizda.ninka.net ([216.101.162.242]:12473 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264833AbTF0Vyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 17:54:46 -0400
Date: Fri, 27 Jun 2003 15:02:48 -0700 (PDT)
Message-Id: <20030627.150248.08328103.davem@redhat.com>
To: davidel@xmailserver.org
Cc: mbligh@aracnet.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: networking bugs and bugme.osdl.org
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.55.0306271454490.4457@bigblue.dev.mcafeelabs.com>
References: <Pine.LNX.4.55.0306270749020.4137@bigblue.dev.mcafeelabs.com>
	<20030627.143738.41641928.davem@redhat.com>
	<Pine.LNX.4.55.0306271454490.4457@bigblue.dev.mcafeelabs.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Davide Libenzi <davidel@xmailserver.org>
   Date: Fri, 27 Jun 2003 15:02:00 -0700 (PDT)
   
   David, your method is the dream of every software developer.

It is not a dream, it works perfectly fine and has done so
for 5+ years of Linux maintainence.

To make these things scale you MUST push the work out to other people,
you absolutely cannot centralize.  And here we're pushing it out to
the bug reporters, just like we push the work of patch maintainence to
the patch submitters.

If they don't care about the bug and won't retransmit when their
stuff isn't being looked at, their bug isn't worth being looked
at.

I know that's a hard pill to swallow, but over years of work I can
tell you this is the only scalable mechanism.  Nobody likes this
because it's not tracked somewhere and they can't show some pretty
list of bugs to their management at the end of each week, TOO FUCKING
BAD.  Pay someone to work on your bugs if you want a pretty list and
people being REQUIRED to look at and fix bugs.  None of this crap is
my problem.
