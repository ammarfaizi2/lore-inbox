Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbVKVRd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbVKVRd5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 12:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbVKVRd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 12:33:56 -0500
Received: from [67.137.28.188] ([67.137.28.188]:58760 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S965030AbVKVRd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 12:33:56 -0500
Message-ID: <4383429F.6000202@wolfmountaingroup.com>
Date: Tue, 22 Nov 2005 09:09:03 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
References: <E1EeLp5-0002fZ-00@calista.inka.de> <43825168.6050404@wolfmountaingroup.com> <43834098.60400@tmr.com>
In-Reply-To: <43834098.60400@tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

> Jeff V. Merkey wrote:
>
>> Bernd Eckenfels wrote:
>>
>>> In article <200511211252.04217.rob@landley.net> you wrote:
>>>
>>>
>>>> I believe that on 64 bit platforms, Linux has a 64 bit clean VFS. 
>>>> Python says 2**64 is 18446744073709551616, and that's roughly:
>>>> 18,446,744,073,709,551,616 bytes
>>>> 18,446,744,073,709 megs
>>>> 18,446,744,073 gigs
>>>> 18,446,744 terabytes
>>>> 18,446 ... what are those, pedabytes (petabytes?)
>>>> 18 zetabytes
>>>>
>> There you go. I deal with this a lot so, those are the names.
>>
>> Linux is currently limited to 16 TB per VFS mount point, it's all 
>> mute, unless VFS gets fixed.
>> mmap won't go above this at present.
>>
> What does "it's all mute" mean?
>
Should be spelled "moot". It's a legal term that means "it doesn't matter".

Jeff
