Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268846AbUIMPjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268846AbUIMPjj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 11:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268839AbUIMPie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 11:38:34 -0400
Received: from [209.88.178.130] ([209.88.178.130]:10230 "EHLO constg.qlusters")
	by vger.kernel.org with ESMTP id S268565AbUIMP3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 11:29:54 -0400
Message-ID: <4145BC8A.6070907@qlusters.com>
Date: Mon, 13 Sep 2004 18:28:10 +0300
From: Constantine Gavrilov <constg@qlusters.com>
Reply-To: Constantine Gavrilov <constg@qlusters.com>
Organization: Qlusters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Calling syscalls from x86-64 kernel results in a crash on Opteron
  machines
References: <2DZQy-7TB-7@gated-at.bofh.it> <m3r7p6gs07.fsf@averell.firstfloor.org>
In-Reply-To: <m3r7p6gs07.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>Constantine Gavrilov <constg@qlusters.com> writes:
>
>  
>
>>Can someone explain the reason for the crash? Can you think of a
>>    
>>
>
>syscall/sysret don't support recursive calls. That's the price for
>being fast.
>
I do not think recursive calls are used here. Do I miss something?

-- 
----------------------------------------
Constantine Gavrilov
Kernel Developer
Qlusters Software Ltd
1 Azrieli Center, Tel-Aviv
Phone: +972-3-6081977
Fax:   +972-3-6081841
----------------------------------------


