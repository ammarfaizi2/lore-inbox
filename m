Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262680AbUJ0UlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbUJ0UlK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 16:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbUJ0Ujh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 16:39:37 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:26266 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262703AbUJ0UgJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:36:09 -0400
Message-ID: <41800750.1050601@tmr.com>
Date: Wed, 27 Oct 2004 16:38:40 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Dave Jones <davej@redhat.com>
Subject: Re: Let's make a small change to the process
References: <200410262220_MC3-1-8D36-77F@compuserve.com><200410262220_MC3-1-8D36-77F@compuserve.com> <1098889516.4302.3.camel@localhost.localdomain>
In-Reply-To: <1098889516.4302.3.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2004-10-27 at 03:17, Chuck Ebbert wrote:
> 
>>>If the goal of -ac is to only include those fixes, why can't we rename
>>>it in something more "intuitive" for the final users ?
>>>Do you see what I mean ?
>>
>>  AFAICT -ac is not supposed to be a complete collection of bugfixes.
>>  2.6.9-ac3 was certainly missing a lot of them (haven't seen -ac4 yet.)
> 
> 
> The goal of -ac is to contain the stuff I personally consider important.
> A lot of the smaller bugfixes individually are fine but a 'complete set
> of bugfixes' turns into a large change set and then needs an entire
> validation and release cycle of its own.
> 
> Each 2.6.10rc change I merged is on the basis of reward >> risk.

Not to give you a swelled head, but at the moment -ac looks more stable 
than anything else widely available.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
