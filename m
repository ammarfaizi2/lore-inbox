Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261452AbTCTRkt>; Thu, 20 Mar 2003 12:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261476AbTCTRkt>; Thu, 20 Mar 2003 12:40:49 -0500
Received: from zeke.inet.com ([199.171.211.198]:41155 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S261452AbTCTRkq>;
	Thu, 20 Mar 2003 12:40:46 -0500
Message-ID: <3E79FFAD.3040904@inet.com>
Date: Thu, 20 Mar 2003 11:51:41 -0600
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Dresser <mdresser_l@windsormachine.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Deprecating .gz format on kernel.org
References: <Pine.LNX.4.33.0303201138000.29061-100000@router.windsormachine.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Dresser wrote:
> On Thu, 20 Mar 2003, Jan-Benedict Glaw wrote:
> 
> 
>>jbglaw@schnarchnase:/tmp$ cat /proc/cpuinfo
> 
> 
>>bogomips        : 15.10
> 
> 
> out of curiosity, how long does the machine take to compile a kernel?
> 
> Do you use a stopwatch or a calendar?

Well, going back to his original email,

jbglaw@schnarchnase:/tmp$ uname -a
Linux schnarchnase 2.5.65 #1 Thu Mar 20 07:39:11 CET 2003 i486 unknown 
unknown GNU/Linux

And looking on kernel.org,
Mar 17 22:29 linux-2.5.65.tar.gz

It takes him less than a week anyway*... ;)  (Timezone conversions left 
as an exercise to the reader.)

So, who can beat his 15.10 bogomips?  Anyone run <1 bogomips?

*grin*

Eli

* Yes, I know he could be doing patches and incremental builds.
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

