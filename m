Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315593AbSEVPKq>; Wed, 22 May 2002 11:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315835AbSEVPKp>; Wed, 22 May 2002 11:10:45 -0400
Received: from [195.63.194.11] ([195.63.194.11]:1553 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S315593AbSEVPKo>;
	Wed, 22 May 2002 11:10:44 -0400
Message-ID: <3CEBA61D.1000709@evision-ventures.com>
Date: Wed, 22 May 2002 16:07:25 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Padraig Brady <padraig@antefacto.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <E17AXfM-0001xc-00@the-village.bc.nu> <3CEBA2D4.4080804@evision-ventures.com> <3CEBB42D.3070807@antefacto.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Padraig Brady napisa?:
> Martin Dalecki wrote:
> 
>> /proc/cpuinfo for one could be replaced by dropping syslog
>> messages at a fixed file in /etc/ during boot - it's static after
>> all!.
> 
> 
> The new cpufreq dynamic frequency scaling
> stuff changes "cpu MHz" and "bogomips" at least.

Both are sysctl stuff -> /proc/sys/kernel/cpu/
But it's a point the data can change indeed.

