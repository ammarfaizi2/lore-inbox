Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbTKNJsV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 04:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbTKNJsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 04:48:21 -0500
Received: from adsl-67-114-19-185.dsl.pltn13.pacbell.net ([67.114.19.185]:18314
	"EHLO bastard") by vger.kernel.org with ESMTP id S262324AbTKNJsT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 04:48:19 -0500
Message-ID: <3FB4A4DC.60004@tupshin.com>
Date: Fri, 14 Nov 2003 01:48:12 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
References: <Pine.LNX.4.44.0311130910310.1809-100000@bigblue.dev.mdolabs.com> <3FB3CB96.9080507@tupshin.com> <20031114071409.GF17497@lug-owl.de>
In-Reply-To: <20031114071409.GF17497@lug-owl.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw wrote:

>On Thu, 2003-11-13 10:21:10 -0800, Tupshin Harper <tupshin@tupshin.com>
>wrote in message <3FB3CB96.9080507@tupshin.com>:
>  
>
>>Davide Libenzi wrote:
>>    
>>
>>>Larry, if there are really six users (i'm one of them, rsync) among 
>>>pserver and rsync access, I am the first to tell you shut it down. It is 
>>>not worth. On the other hand IIRC it was you that, when Pavel showed up 
>>>with the bitbucket hack to extract metadata from BK, volunteered to do it 
>>>internally inside BM. Do I remember correctly?
>>>      
>>>
>>As one of the six, I would happily 2nd the shutting down of the 
>>pserver...rsync is fine with me. I would actually prefer no CVS archive 
>>at all as long as the raw changesets were rsyncable...then the community 
>>would be responsible for doing something useful with them instead of BM.
>>    
>>
>
>That would be fine with me, too, but there's one little drawback: The
>changeset format. You can't simply use a patch(1) file because there is
>a (really little) number of non-text files in the kernel source tree
>that won't diff...
>
>MfG, JBG
>
>  
>
An acceptable hurdle to overcome.

-Tupshin

