Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751870AbWIRSJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbWIRSJM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 14:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbWIRSJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 14:09:12 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:36313 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750838AbWIRSJK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 14:09:10 -0400
Message-ID: <450EE085.5000704@in.ibm.com>
Date: Mon, 18 Sep 2006 23:38:05 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: rohitseth@google.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, devel@openvz.org,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [ckrm-tech] [patch 0/5]-Containers: Introduction
References: <1158284264.5408.144.camel@galaxy.corp.google.com>	<450E9ED9.2060306@in.ibm.com> <1158595571.18533.5.camel@galaxy.corp.google.com>
In-Reply-To: <1158595571.18533.5.camel@galaxy.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth wrote:
> On Mon, 2006-09-18 at 18:57 +0530, Balbir Singh wrote:
>> Rohit Seth wrote:
>>
>>> Below is a one line description for patches that will follow:
>>>
>>> [patch01]: Documentation on how to use containers
>>> (Documentation/container.txt)
>>>
>>> [patch02]: Changes in the generic part of kernel code
>>>
>>> [patch03]: Container's interface with configfs
>>>
>>> [patch04]: Core container support
>>>
>>> [patch05]: Over the limit memory handler.
>>>
>> Hi, Rohit,
>>
>> The patches are hard to follow - are they diff'ed with Naurp?
>> At certain places I cannot figure out which function has changed.
>>
> 
> They are without p option so the function name is not there. Though
> there is only one patch 02 of 05 that modifies existing code.  And that
> too almost all single line changes are starting with container API
> container_*  Please let me know if there is something specific that is
> not clear.
> 

Patch 02 is hard to read. I was trying to understand the changes made
in the patch. Patch 01 is trivial, I got stuck at 02.

> I will send the next version of patches and I will include -p option as
> well.
> 
> thanks,
> -rohit
> 

-- 
	Warm Regards,
	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
