Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264825AbTF0Vq6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 17:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264833AbTF0Vq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 17:46:58 -0400
Received: from pizda.ninka.net ([216.101.162.242]:5817 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264825AbTF0Vq4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 17:46:56 -0400
Date: Fri, 27 Jun 2003 14:54:56 -0700 (PDT)
Message-Id: <20030627.145456.115915594.davem@redhat.com>
To: greearb@candelatech.com
Cc: davidel@xmailserver.org, mbligh@aracnet.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: networking bugs and bugme.osdl.org
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3EFCBD12.3070101@candelatech.com>
References: <Pine.LNX.4.55.0306270749020.4137@bigblue.dev.mcafeelabs.com>
	<20030627.143738.41641928.davem@redhat.com>
	<3EFCBD12.3070101@candelatech.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben Greear <greearb@candelatech.com>
   Date: Fri, 27 Jun 2003 14:54:26 -0700
   
   I think you are putting too much work on the bug reporter(s).

Don't even talk to me about too much work.

Someone wants me to spend hours groveling through some pieces of code
to track down some tricky bug, for free, and all I ask is that they
retransmit the bug every once in a while if they don't see any
response?

Give me a frigging break.

If they're not willing to do this, they DON'T care about the bug.
Just like if people aren't willing to retransmit patches they want
installed, they DON'T care about the patch.  And just like I don't
want to apply patches people don't care about, I don't want any of my
contributors looking at bugs that the bug reporter doesn't care about.

Just like with patches, I want to know that people are going to stick
around and be responsive if I need to get information from them when
a bug is reported.  If they're not willing to retransmit the report
every one in a while, why should I believe they will?

Ben, you absolutely don't understand how all of this development works
and what it relies upon to function properly.
