Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVCGJbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVCGJbT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 04:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVCGJbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 04:31:19 -0500
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:16053 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261721AbVCGJ2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 04:28:35 -0500
Message-ID: <422C1EC0.8050106@yahoo.com.au>
Date: Mon, 07 Mar 2005 20:28:32 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: Christian Schmid <webmaster@rapidforum.com>, linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
References: <4229E805.3050105@rapidforum.com> <422BAAC6.6040705@candelatech.com> <422BB548.1020906@rapidforum.com> <422BC303.9060907@candelatech.com> <422BE33D.5080904@yahoo.com.au> <422C1D57.9040708@candelatech.com>
In-Reply-To: <422C1D57.9040708@candelatech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> Nick Piggin wrote:
> 
>> Ben Greear wrote:
>>

>> In that case, writing the network only test would help to confirm the
>> problem is not a networking one - so not useless by any means.
> 
> 
> It's not trivial to write something like this :)
> 
> I'll be using something I already have.  If I can't reproduce the problem,
> then perhaps it is due to sendfile and someone can write a customized
> test.  The main reason I offered is because people are ignoring the
> bug report for the most part and asking for a test case.  I may be able
> to offer an independent verification of the problem which might convince
> someone to write up a dedicated test case...
> 

OK, no that sounds good, please do make the test case.

I have actually been following up with Christian regarding
the disk IO / memory management side of things but the thread
has gone offline for some reason :\

