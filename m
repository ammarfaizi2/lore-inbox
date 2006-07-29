Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWG2VQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWG2VQZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 17:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWG2VQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 17:16:25 -0400
Received: from mail.tmr.com ([64.65.253.246]:18141 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S932184AbWG2VQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 17:16:24 -0400
Message-ID: <44CBD387.601@tmr.com>
Date: Sat, 29 Jul 2006 17:30:47 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Building the kernel on an SMP box?
References: <14CFC56C96D8554AA0B8969DB825FEA0012B3898@chicken.machinevisionproducts.com> <p73wt9x4zay.fsf@verdi.suse.de> <44CBB7F5.1080704@tmr.com> <200607292129.17682.ak@suse.de>
In-Reply-To: <200607292129.17682.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>>That sounds really useful, although I bet it assumes that the build 
>>environment is the same on all machines. Or at least similar. 
>>    
>>
>
>No it doesn't.
>
>  
>
I will definitely have to look at that, then, I would have been very 
cautious about having the same version of the compiler and loader 
everywhere, but if the tasks are exported using the tool chain on the 
initiating computer or something, it should be all right.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

