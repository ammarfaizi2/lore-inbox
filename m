Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbWDNTAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWDNTAW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 15:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWDNTAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 15:00:22 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:18054 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1751414AbWDNTAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 15:00:21 -0400
Date: Fri, 14 Apr 2006 11:00:12 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Michael Madore <michael.madore@gmail.com>
cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: Lockup/reboots on multiple dual core Opteron systems
In-Reply-To: <d4b6d3ea0604141102i7e50cfbdna04485fe2ae5c1d8@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0604141058570.17345@qynat.qvtvafvgr.pbz>
References: <d4b6d3ea0604140948l36c8048ha819a6611c8fdad3@mail.gmail.com> 
 <Pine.LNX.4.62.0604140937440.17345@qynat.qvtvafvgr.pbz>
 <d4b6d3ea0604141102i7e50cfbdna04485fe2ae5c1d8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2006, Michael Madore wrote:

>>
>> I'm fighting similar problems on one machine at home (single dual core, 4G
>> ram nforce 939 motherboard, 1 ide, 10 3ware, 1 adaptec controlled drives).
        ^^^^^^^^^^^^^^^^^^^^^^

>> It's locked up under the ubuntu and gentoo install disk kernels. I did
>> have it running for a day and a half under 2.6.17-rc1, but I managed to
>> corrupt the install and haven't gotten back to that kernel yet to confirm
>> it's long-term stability.
>
> Who makes your motherboard?  Also, how do you trigger the lockup?

I've triggered the lockups by doing large compile sessions, but the lockup 
seems to happen much quicker if I'm running under X (more memory 
allocated)

David Lang

> Mike
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

