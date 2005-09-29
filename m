Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbVI2Ta7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbVI2Ta7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbVI2Ta7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:30:59 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:22288 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932223AbVI2Ta6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:30:58 -0400
Message-ID: <433C4106.1020801@tmr.com>
Date: Thu, 29 Sep 2005 15:31:18 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nuno Silva <nuno.silva@vgertech.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux SATA S.M.A.R.T. and SLEEP?
References: <Pine.LNX.4.63.0509290916450.20827@p34> <433C31C8.1030901@vgertech.com>
In-Reply-To: <433C31C8.1030901@vgertech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nuno Silva wrote:
> Justin Piszcz wrote:
> 
>> Under 2.6.13.2,
>>
>> Is there any utility that I can use to put a SATA HDD to sleep?
>> Secondly, I notice I cannot access any of the HDD's S.M.A.R.T. 
>> functions on SATA drives?
> 
> 
> Search for Jeff's patch 2.6.12-git4-passthru1.patch
> I think this will be included RSN. This solves your two issues.

Thank you for mentioning this, it makes using SATA drives in production 
look more appealing. I like to be proactive on drive health and check it 
regularly.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
