Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267176AbUHITsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267176AbUHITsB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 15:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266890AbUHITpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 15:45:06 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:33706 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S266894AbUHIToE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 15:44:04 -0400
Message-ID: <4117D48B.9000500@tmr.com>
Date: Mon, 09 Aug 2004 15:46:19 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rick Lindsley <ricklind@us.ibm.com>
CC: Adrian Bunk <bunk@fs.tum.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm1: SCHEDSTATS compile error 
References: <200408051817.i75IHD715692@owlet.beaverton.ibm.com>
In-Reply-To: <200408051817.i75IHD715692@owlet.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Lindsley wrote:
> This looks like it could happen if you compile without CONFIG_SMP ...
> which admittedly I have not tried since the sched-domain code was
> introduced.  Adrian, was this the situation in your case?

Solved it for me, although running SMP on a old slow PentiumII feels a 
tad odd. Other than that the system is running very well, I have to try 
a response test and see how it feels then.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
