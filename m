Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbTFNSMo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 14:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265698AbTFNSMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 14:12:44 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:40883 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S265697AbTFNSMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 14:12:42 -0400
Message-ID: <3EEB6A4B.7040106@mindspring.com>
Date: Sat, 14 Jun 2003 11:32:43 -0700
From: Joe <joeja@mindspring.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Xeon  processors &&Hyper-Threading
References: <3EE9FDFA.6020803@mindspring.com> <Pine.LNX.4.53.0306131241330.5894@chaos>
In-Reply-To: <Pine.LNX.4.53.0306131241330.5894@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I was asked this by one of our clients, and told them that they 
would probably have to recompile their kernel.

Joe
	

Richard B. Johnson wrote:
> On Fri, 13 Jun 2003, Joe wrote:
> 
> 
>>Does Linux support the Xeon (p4) processor and its capabilities?
>>
>>The company I work for recently ported its application to Linux and one
>>of our current HP clients asked this and I figure it would be just a
>>recompile the kernel as a P4, but not sure if this would do it.
>>
>>I'm not asking if Linux can RUN the Xeon processor.
>>
>>I'm asking if Linux processor takes any advantage of the Hyper-Threading
>>built into this processor?
>>
>>below is a link to more info on this.
>>
>>http://www.intel.com/design/xeon/prodbref/
>>
>>Joe
>>
> 
> 
> You recompile the kernel for SMP as well as P4. If the motherboard
> hasn't disabled HT capabilities, you will take full advantage of
> the processor under Linux. Whatever "full advantage" means, is
> not absolute, but whatever it is, will be used to its fullest.
> Basically, if the code is I/O bound, you'll not see any difference.
> If the code is compute-intensive, you will.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
> Why is the government concerned about the lunatic fringe? Think about it.
> 
> 

