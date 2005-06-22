Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbVFVTWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVFVTWY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 15:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVFVTWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 15:22:23 -0400
Received: from adsl-68-248-203-41.dsl.milwwi.ameritech.net ([68.248.203.41]:60867
	"EHLO eagle.netwrx1.com") by vger.kernel.org with ESMTP
	id S261542AbVFVTWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 15:22:15 -0400
Date: Wed, 22 Jun 2005 14:22:10 -0500 (CDT)
From: George Kasica <georgek@netwrx1.com>
To: Adrian Bunk <bunk@stusta.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem compiling 2.6.12
In-Reply-To: <20050622164204.GH3705@stusta.de>
Message-ID: <Pine.LNX.4.62.0506221415460.25918@eagle.netwrx1.com>
References: <Pine.LNX.4.62.0506221026130.4837@eagle.netwrx1.com>
 <20050622164204.GH3705@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have no idea what you are referring to there. If you can give me details 
on what information you need or what you need me to do here I'll try to 
provide it. I'm unfortunately not a kernel hacker or programmer here.

George

> On Wed, Jun 22, 2005 at 10:28:25AM -0500, George Kasica wrote:
>> Hello:
>>
>> Trying to compile 2.6.12 here and am getting the following error. I am
>> currently running 2.4.31 and have upgraded the needed bits per the Change
>> document before trying the build:
>>
>> [root@eagle src]# cd linux
>> [root@eagle linux]# make mrproper
>>   CLEAN   .config
>> [root@eagle linux]# cp ../config-2.4.31 .config
>> [root@eagle linux]# make oldconfig
>>   HOSTCC  scripts/basic/fixdep
>> In file included from /usr/local/include/netinet/in.h:212,
>> ...
>
> What are these kernel headers under /usr/local ?
> I don't see any reason why they should be there.
>
>> George
>
> cu
> Adrian
