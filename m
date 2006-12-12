Return-Path: <linux-kernel-owner+w=401wt.eu-S1751289AbWLLM6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWLLM6I (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 07:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWLLM6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 07:58:07 -0500
Received: from il.qumranet.com ([62.219.232.206]:51875 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751289AbWLLM6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 07:58:05 -0500
Message-ID: <457EA759.7000405@qumranet.com>
Date: Tue, 12 Dec 2006 14:58:01 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/kvm/: possible cleanups
References: <20061211184051.GC28443@stusta.de> <457E7374.3000704@qumranet.com> <20061212125610.GK28443@stusta.de>
In-Reply-To: <20061212125610.GK28443@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Tue, Dec 12, 2006 at 11:16:36AM +0200, Avi Kivity wrote:
>   
>> Adrian Bunk wrote:
>>     
>>> This patch contains the following possible cleanups:
>>> - make needlessly global code static
>>> - proper prototype for kvm_main.c:find_msr_entry()
>>> - #if 0 the unused svm.c:inject_db()
>>>
>>>  
>>>       
>> Please copy kvm patches to kvm-devel@lists.sourceforge.net in the future.
>>     
>
> -ENOMAINTAINERSENTRY  ;-)
>   

That patch is in the same queue :)

-- 
error compiling committee.c: too many arguments to function

