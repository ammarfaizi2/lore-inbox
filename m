Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263861AbTCUV7Y>; Fri, 21 Mar 2003 16:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263860AbTCUV7G>; Fri, 21 Mar 2003 16:59:06 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:57841 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S263861AbTCUV5D>; Fri, 21 Mar 2003 16:57:03 -0500
Date: Fri, 21 Mar 2003 14:06:54 -0800
From: Chris Wright <chris@wirex.com>
To: Junfeng Yang <yjf@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu, perex@suse.cz
Subject: Re: [CHECKER] potential dereference of user pointer errors
Message-ID: <20030321140654.E641@figure1.int.wirex.com>
Mail-Followup-To: Junfeng Yang <yjf@stanford.edu>,
	linux-kernel@vger.kernel.org, mc@cs.stanford.edu, perex@suse.cz
References: <20030321134449.A646@figure1.int.wirex.com> <Pine.GSO.4.44.0303211355080.12835-100000@elaine24.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.44.0303211355080.12835-100000@elaine24.Stanford.EDU>; from yjf@stanford.edu on Fri, Mar 21, 2003 at 01:58:19PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Junfeng Yang (yjf@stanford.edu) wrote:
> 
> Thanks a lot for your confirmation! So actually the first copy_from_user
> is meant to copy in what "*data" points to, not "data".

That's how I read it, but I can't claim to know this code.  Sorry, I mistyped
Jaroslav's address on the original email (fixed now), I expect he's the one
to ask.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
