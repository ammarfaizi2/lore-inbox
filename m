Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbULYSfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbULYSfX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 13:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbULYSfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 13:35:23 -0500
Received: from mail.tmr.com ([216.238.38.203]:59075 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261533AbULYSfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 13:35:19 -0500
Message-ID: <41CDB551.1090608@tmr.com>
Date: Sat, 25 Dec 2004 13:45:37 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rajsekar <raj--cutme--sekar@cse.iDELTHISitm.ernet.in.tmr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Trying out SCHED_BATCH 
References: <m3mzw262cu.fsf@rajsekar.pc>
In-Reply-To: <m3mzw262cu.fsf@rajsekar.pc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajsekar wrote:
> I would like to try out the SCHED_BATCH.  Unfortunately, I am not able to
> find a patch for my kernel.  Could someone enlighten me on this?
> 
> I am running 2.6.10-rc1-mm2 with staircase scheduler patch.  My `uname -a'
> output is:
> 
> Linux rajsekar.pc 2.6.10-rc1-mm2staircase #2 Sat Dec 4 10:49:31 IST 2004 i686 AuthenticAMD unknown GNU/Linux
> 
See the announcement of 2.6.10-ck1, that has what you want. However, you 
want to read the whole thread, as there is one patch WRT swap_token 
which you may want to revert.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
