Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264982AbTF1Ah6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 20:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265013AbTF1Ah4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 20:37:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37818 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264982AbTF1Agl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 20:36:41 -0400
Date: Fri, 27 Jun 2003 17:44:40 -0700 (PDT)
Message-Id: <20030627.174440.59660428.davem@redhat.com>
To: lm@bitmover.com
Cc: mbligh@aracnet.com, greearb@candelatech.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: networking bugs and bugme.osdl.org
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030627225305.GA13785@work.bitmover.com>
References: <20030627.144426.71096593.davem@redhat.com>
	<1230000.1056754041@[10.10.2.4]>
	<20030627225305.GA13785@work.bitmover.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Larry McVoy <lm@bitmover.com>
   Date: Fri, 27 Jun 2003 15:53:05 -0700

       - one key observation: let bugs "expire" much like news expires.  If
         nobody has been whining enough that it gets into the high signal 
         bug db then it probably isn't real.  We really want a way where no
         activity means let it expire.

I want more than time based expiry, I want expiry for me that
is controlled by me.  When I delete the notification email in
my mailbox, I never want to see that bug again unless I want to.

This effectively degrades into list posting based bug reports and my
current email inbox, which is what I'm advocating to use :-)

When I see the "me too, heres some more info" response to the list
posting, then I'm interested and I'll reread the list thread to
digest all the information to see what I can make of it.  When this
happens bugs basically fix themselves, and this occurs only because
of the acts taken on by the reporters of the bug not me.
