Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269417AbUI3S5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269417AbUI3S5n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 14:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269425AbUI3S5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 14:57:42 -0400
Received: from mail.tmr.com ([216.238.38.203]:13319 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S269417AbUI3S45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 14:56:57 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Linux 2.6.9-rc3
Date: Thu, 30 Sep 2004 14:58:11 -0400
Organization: TMR Associates, Inc
Message-ID: <cjhkfk$6bv$3@gatekeeper.tmr.com>
References: <pan.2004.09.30.04.53.05.120184@trippelsdorf.net><pan.2004.09.30.04.53.05.120184@trippelsdorf.net> <200409300102.07373.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1096570164 6527 192.168.12.100 (30 Sep 2004 18:49:24 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <200409300102.07373.gene.heskett@verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> On Thursday 30 September 2004 00:53, Markus T. wrote:
> 
>># bzcat patch-2.6.9-rc3.bz2 | patch -p1
>>...
>>patching file fs/nfs/file.c
>>Hunk #2 FAILED at 74.
>>Hunk #3 FAILED at 91.
>>2 out of 11 hunks FAILED -- saving rejects to file fs/nfs/file.c.rej
>>...
>>
>>___
>>Markus
>>
> 
> And thats one of the reasons I never dl the bz2 version.
> 
> You should have started with a fresh unpack of 2.6.8, not 2.6.8.1
> I just checked my scrollback and there is no such error here.

Are you saying that he patched against the wrong kernel source because 
he pulled the bz2 patch? How do you make that leap? The gz patch does 
the same thing against the wrong source.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
