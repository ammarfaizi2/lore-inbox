Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965058AbWFTF4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965058AbWFTF4M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 01:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965061AbWFTF4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 01:56:12 -0400
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:1692 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S965059AbWFTF4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 01:56:11 -0400
Message-ID: <44978DF8.702@bigpond.net.au>
Date: Tue, 20 Jun 2006 15:56:08 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Peter Williams <peterw@aurema.com>, Andrew Morton <akpm@osdl.org>,
       dev@openvz.org, vatsa@in.ibm.com, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, bsingharora@gmail.com, efault@gmx.de,
       kernel@kolivas.org, sam@vilain.net, kingsley@aurema.com, mingo@elte.hu,
       rene.herman@keyaccess.nl, Chandra Seetharaman <sekharan@us.ibm.com>
Subject: Re: [ckrm-tech] [PATCH 0/4] sched: Add CPU rate caps
References: <20060618082638.6061.20172.sendpatchset@heathwren.pw.nest>	<20060618025046.77b0cecf.akpm@osdl.org>	<449529FE.1040008@bigpond.net.au>	<4495EC40.70301@in.ibm.com> <4495F7FE.9030601@aurema.com> <449609E4.1030908@in.ibm.com> <44977971.9030703@bigpond.net.au> <44977C4A.8010007@in.ibm.com>
In-Reply-To: <44977C4A.8010007@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 20 Jun 2006 05:56:09 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> Peter Williams wrote:
>> Balbir Singh wrote:
>>
>>> Peter Williams wrote:
>>>
>>> If we can achieve something similar with low overhead in user space, 
>>> I would
>>> certainly love to see it.
>>
>>
>> The Windows and Solaris components of IBM's eWLM product provide much 
>> the same functionality as CKRM from user space.  Don't they?
>>
>> Peter
> 
> 
> I know absolutely nothing about eWLM's Windows and Solaris product.
> 

I'm sorry I've always assumed that (due to its design) CKRM was intended 
as the Linux component of eWLM.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
