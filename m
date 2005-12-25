Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbVLYPod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbVLYPod (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 10:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbVLYPod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 10:44:33 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:21482 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750838AbVLYPod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 10:44:33 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Ed Tomlinson <edt@aei.ca>, Mark Lord <lkml@rtr.ca>,
       Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc6 - Success with ICH5/SATA + S.M.A.R.T.
Date: Mon, 26 Dec 2005 02:44:07 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <sfftq1lhi7dvugooro7mjthksiqc6j8mg0@4ax.com>
References: <Pine.LNX.4.64.0512241830010.2700@p34> <43ADDD34.9020101@rtr.ca> <200512250937.55140.edt@aei.ca> <43AEB0CB.20403@pobox.com>
In-Reply-To: <43AEB0CB.20403@pobox.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Dec 2005 09:46:35 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:

>Ed Tomlinson wrote:
>> On Saturday 24 December 2005 18:43, Mark Lord wrote:
>> 
>>> >smartmontools is going to have to be updated
>>>
>>>What for?
>>>
>>>Use "smartctl -d ata /dev/sda"
>> 
>> 
>> Its not perfect:
>> 
>> grover:/poola/home/ed# smartctl -d ata /dev/sda
>> smartctl version 5.34 [x86_64-unknown-linux-gnu] Copyright (C) 2002-5 Bruce Allen
>> Home page is http://smartmontools.sourceforge.net/
>> 
>> smartctl has problems but hddtemp works
>
>What are the problems?  Your output gives us no clue...

That _is_ the clue, no output ;)  

Grant.
