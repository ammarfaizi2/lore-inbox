Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269161AbTB0E0d>; Wed, 26 Feb 2003 23:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269162AbTB0E0c>; Wed, 26 Feb 2003 23:26:32 -0500
Received: from dp.samba.org ([66.70.73.150]:43470 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S269161AbTB0E0c>;
	Wed, 26 Feb 2003 23:26:32 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [BUG] 2.5.63: ESR killed my box! 
In-reply-to: Your message of "Wed, 26 Feb 2003 18:14:42 +1100."
Date: Wed, 26 Feb 2003 19:43:27 +1100
Message-Id: <20030227043651.23A9F2C348@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In message <9530000.1046238665@[10.10.2.4]> I wrote:
> Yes.  Hmm.  Wonder if that helps my SMP wierness, too.

Didn't get that far.  Booted, then, froze later in UP with esr_disable
#defined to 1, too.

I'm stumped.  2.4 works fine, 2.5 has trouble lasting 10 minutes.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
