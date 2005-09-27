Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbVI0WqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbVI0WqX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 18:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965220AbVI0WqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 18:46:22 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:45830 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751148AbVI0WqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 18:46:21 -0400
Message-ID: <4339CBCB.4070000@tmr.com>
Date: Tue, 27 Sep 2005 18:46:35 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] USB Storage & D state processes
References: <20050923131642.12688.qmail@web52614.mail.yahoo.com> <20050923142927.GA13433@kroah.com>
In-Reply-To: <20050923142927.GA13433@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Sep 23, 2005 at 11:16:42PM +1000, Srihari Vijayaraghavan wrote:
> 
>>Hardware:
>>Athlon 64
>>VIA K8T 800
>>
>>Software:
>>FC4
>>2.6.14-rc2 (vanilla)
> 
> 
> Try 2.6.14-rc2-git2, it should be fixed there.

I can confirm that the issues I had with all of my USB devices becoming 
unavailable has not been seen. Uptime now over four days, that is WAY 
longer than it took to fail before!

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
