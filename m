Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbUBDQXI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 11:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbUBDQXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 11:23:08 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:48052
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S263510AbUBDQXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 11:23:06 -0500
Message-ID: <40211CC8.7030204@tmr.com>
Date: Wed, 04 Feb 2004 11:24:40 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christian Borntraeger <kernel@borntraeger.net>
CC: =?ISO-8859-1?Q?Markus_H=E4stbacka?= <midian@ihme.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Uptime counter
References: <Pine.LNX.4.44.0402012239010.6206-100000@midi> <200402012202.07204.kernel@borntraeger.net>
In-Reply-To: <200402012202.07204.kernel@borntraeger.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Borntraeger wrote:
> Markus Hästbacka wrote:
> 
>>Hi list,
>>I wonder does any kernel branch have a uptime counter that doesn't stop
>>counting at 497 days? Or is a patch needed for the job to
>>2.{0,2,4,6} kernel?
> 
> 
> In 2.6 there is no 497 days limit, as jiffies are now 64 bit. 
> 
> By the way: Having a machine with more than 497 days of uptime normally 
> shows a serios lack of security awareness..

Think embedded systems...

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
