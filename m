Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267298AbUIJItu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267298AbUIJItu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 04:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267303AbUIJItu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 04:49:50 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:22056 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S267298AbUIJIts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 04:49:48 -0400
Message-ID: <4140FC70.1070101@blueyonder.co.uk>
Date: Fri, 10 Sep 2004 01:59:28 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.6.9-rc1-bk16 Still cdrom/DVD oops
References: <4140F3A7.8040103@blueyonder.co.uk> <1094776333.1396.31.camel@krustophenia.net>
In-Reply-To: <1094776333.1396.31.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Sep 2004 08:50:11.0923 (UTC) FILETIME=[2ED6FA30:01C49713]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

>On Thu, 2004-09-09 at 20:21, Sid Boyce wrote:
>  
>
>>Sep 10 01:15:11 barrabas kernel: Modules linked in: nvidia parport_pc lp 
>>    
>>
>
>Your kernel is tainted.  Please reproduce with an untainted kernel and
>report.
>
>Lee
>
>
>
>  
>
The only tainted module is "nvidia", the results are the same without 
that module loaded in -bk15, i.e in runlevel 3. I've seen this problem 
on all kernels from 2.6.8.1 including -mm?. It's fine with 
2.6.8-rc4-mm1, the earliest kernel I currently have around.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====


