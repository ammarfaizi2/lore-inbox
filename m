Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbVJKUVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVJKUVZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 16:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbVJKUVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 16:21:25 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:28421 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751199AbVJKUVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 16:21:24 -0400
Message-ID: <434C1EF7.4090504@tmr.com>
Date: Tue, 11 Oct 2005 16:22:15 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dual Xeon Time skips with 2.6
References: <4WbFk-3iC-33@gated-at.bofh.it> <434AC72F.8070701@shaw.ca>
In-Reply-To: <434AC72F.8070701@shaw.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:

> You can probably avoid this problem by using "notsc" on the kernel 
> command line. It would seem that somehow the TSC drift is too small for 
> the kernel to notice on boot, but causes problems anyway..
> 
This sounds familiar, although much larger than what I see, is it 
possible for an Intel dual core CPU to do this as well? I sometimes see 
very unintuitive timestamps on network stuff.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
