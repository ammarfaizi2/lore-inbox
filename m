Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265084AbTF3PhX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 11:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265075AbTF3PhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 11:37:23 -0400
Received: from dm5-224.slc.aros.net ([66.219.220.224]:52610 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S265085AbTF3PhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 11:37:19 -0400
Message-ID: <3F005C89.6050906@aros.net>
Date: Mon, 30 Jun 2003 09:51:37 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.73-mm1 nbd: boot hang in add_disk at first call from nbd_init
References: <200306271943.13297.mflt1@micrologica.com.hk> <20030627194154.01a06c5d.akpm@digeo.com> <200306281255.36048.mflt1@micrologica.com.hk>
In-Reply-To: <200306281255.36048.mflt1@micrologica.com.hk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Frank wrote:

>On Saturday 28 June 2003 10:41, Andrew Morton wrote:
>  
>
>>Michael Frank <mflt1@micrologica.com.hk> wrote:
>>    
>>
>>>Changes were recently made to the nbd.c in 2.5.73-mm1
>>>      
>>>
>>And tons more will be in -mm2, which I shall prepare right now.
>>Please retest on that and if it still hangs, capture the output
>>from pressing alt-sysrq-T.
>>    
>>
>
>Legacy free, no serial port. 
>Sorry, -mm2 hang at booting kernel on 2 machines. 
>
Just catching up on email after being away for a few days... so nbd 
isn't at fault then in mm2, correct? Your follow on emails at least 
seemed to indicate that there was a different problem that you in fact 
were encountering in mm2. If you find a problem though in mm2 w.r.t. nbd 
please let me know directly and I'll haul butt to get a fix out to you.

All the best ;-)

