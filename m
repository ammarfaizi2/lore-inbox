Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132419AbRDCSzb>; Tue, 3 Apr 2001 14:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132429AbRDCSzW>; Tue, 3 Apr 2001 14:55:22 -0400
Received: from james.kalifornia.com ([208.179.59.2]:59987 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S132419AbRDCSzH>; Tue, 3 Apr 2001 14:55:07 -0400
Message-ID: <3ACA1A91.70401@kalifornia.com>
Date: Tue, 03 Apr 2001 11:46:41 -0700
From: Ben Ford <ben@kalifornia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-14 i686; en-US; 0.8.1)
X-Accept-Language: en
MIME-Version: 1.0
To: "J . A . Magallon" <jamagallon@able.es>
CC: David Lang <dlang@diginsite.com>, linux-kernel@vger.kernel.org
Subject: Re: /proc/config idea
In-Reply-To: <3AC91800.22D66B24@mandrakesoft.com> <Pine.LNX.4.33.0104021734400.30128-100000@dlang.diginsite.com> <20010403161322.A8174@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J . A . Magallon wrote:

> On 04.03 David Lang wrote:
> 
>> if the distro/sysadmin _always_ installs the kernel the 'right way' then
>> the difference isn't nessasarily that large, but if you want reliability
>> on any system it may be worth loosing a page or so of memory (hasn't
>> someone said that the data can be compressed to <1K?) make it so that you
>> need a common external tool to use the data and deliver it from the kernel
>> in compressed form and you don't even need to put the decompression
>> routine in the kernel (cat /proc/sys/kernel/config |gunzip >config)
>> 
> 
> Just my 2 cents...
> 
> If this has not been done for System.map, that is a much more important
> info for debug and oops, and the de facto standard is to put it aside
> kernel with some standadr naming, lets use the same method for config.
> 
That would be great and all, but can you tell me how to do it when I 
have 3 or 4 different compiles of the same kernel version?

-b


