Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267385AbUIJM1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267385AbUIJM1p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 08:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267387AbUIJM1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 08:27:44 -0400
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:33333 "EHLO
	smtp-out2.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S267385AbUIJM1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 08:27:41 -0400
Message-ID: <41419DB9.4010201@blueyonder.co.uk>
Date: Fri, 10 Sep 2004 13:27:37 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.6.9-rc1-bk16 Still cdrom/DVD oops
References: <4140F3A7.8040103@blueyonder.co.uk>	 <1094776333.1396.31.camel@krustophenia.net>	 <4140FC70.1070101@blueyonder.co.uk> <1094810774.15407.9.camel@krustophenia.net>
In-Reply-To: <1094810774.15407.9.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Sep 2004 12:28:05.0684 (UTC) FILETIME=[9F689740:01C49731]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

>On Thu, 2004-09-09 at 20:59, Sid Boyce wrote:
>  
>
>>Lee Revell wrote:
>>    
>>
>>>Your kernel is tainted.  Please reproduce with an untainted kernel and
>>>report.
>>>
>>>      
>>>
>>The only tainted module is "nvidia", the results are the same without 
>>that module loaded in -bk15, i.e in runlevel 3. I've seen this problem 
>>on all kernels from 2.6.8.1 including -mm?. It's fine with 
>>2.6.8-rc4-mm1, the earliest kernel I currently have around.
>>    
>>
>
>Understood.  No one is suggesting the nvidia module caused the Oops,
>it's just that as long as there's a binary module loaded, the Oops can't
>be interpreted fully.
>
>If you can reproduce without nvidia loaded, then post one of these.
>
>Lee
>
>
>
>  
>
My second posting today has it appended.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====

