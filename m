Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132696AbRDCVEQ>; Tue, 3 Apr 2001 17:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132697AbRDCVDf>; Tue, 3 Apr 2001 17:03:35 -0400
Received: from james.kalifornia.com ([208.179.59.2]:42581 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S132696AbRDCVDa>; Tue, 3 Apr 2001 17:03:30 -0400
Message-ID: <3ACA3946.1030703@kalifornia.com>
Date: Tue, 03 Apr 2001 13:57:42 -0700
From: Ben Ford <ben@kalifornia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-14 i686; en-US; 0.8.1)
X-Accept-Language: en
MIME-Version: 1.0
To: "J . A . Magallon" <jamagallon@able.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: /proc/config idea
In-Reply-To: <3AC91800.22D66B24@mandrakesoft.com> <Pine.LNX.4.33.0104021734400.30128-100000@dlang.diginsite.com> <20010403161322.A8174@werewolf.able.es> <3ACA1A91.70401@kalifornia.com> <20010403211218.A2387@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J . A . Magallon wrote:

> On 04.03 Ben Ford wrote:
> 
>> J . A . Magallon wrote:
>> 
>>> If this has not been done for System.map, that is a much more important
>>> info for debug and oops, and the de facto standard is to put it aside
>>> kernel with some standadr naming, lets use the same method for config.
>>> 
>> That would be great and all, but can you tell me how to do it when I 
>> have 3 or 4 different compiles of the same kernel version?
>> 
> 
> Just like the Alan Cox for 2.4 or Andrea Arcangeli for 2.2. Lets say you
> have 2.4.2-ac27. For each of your compiles, set EXTRAVERSION to -ac27-bf1,
> -ac27-bf2, etc. Your files will be:
> vmlinuz-2.4.2-ac27-bfX
> System.map-2.4.2-ac27-bfX
> config-2.4.2-ac27-bfX
> 
Many thanks, I didn't know that.

