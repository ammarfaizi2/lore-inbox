Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbUDJUAj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 16:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbUDJUAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 16:00:39 -0400
Received: from ns.clanhk.org ([69.93.101.154]:17589 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S261752AbUDJUAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 16:00:37 -0400
Message-ID: <40785284.6050308@clanhk.org>
Date: Sat, 10 Apr 2004 15:01:08 -0500
From: "J. Ryan Earl" <heretic@clanhk.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: amd64 questions
References: <1Ijzw-4ff-5@gated-at.bofh.it> <1Ijzv-4ff-3@gated-at.bofh.it> <1IntE-7wn-39@gated-at.bofh.it> <m3isgb69xx.fsf@averell.firstfloor.org> <407826DF.9030506@clanhk.org> <20040410184904.GA12924@colin2.muc.de>
In-Reply-To: <20040410184904.GA12924@colin2.muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>>So let me get this straight, we can't use LVM with AMD64 under the 2.6 
>>    
>>
>
>No, you completely misunderstood.
>  
>
It was ambiguous, I saw more than one valid interpretation.

>>line either?  Or we can if we use AMD64 [DM] libraries with a AMD64 
>>kernel?  DM = Device Mapper right?
>>    
>>
>
>You can't use Device Mapper with 32bit user tools on a 64bit kernel
>right now.
>  
>
Which doesn't say we can use 64bit user tools with a 64bit kernel, but I 
assume this is what you mean.

-ryan
