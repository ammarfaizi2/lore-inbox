Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284787AbRLMTEA>; Thu, 13 Dec 2001 14:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284813AbRLMTDu>; Thu, 13 Dec 2001 14:03:50 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:59397 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S284787AbRLMTDm>; Thu, 13 Dec 2001 14:03:42 -0500
Message-ID: <3C18FB3D.7060206@namesys.com>
Date: Thu, 13 Dec 2001 22:02:21 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ryan Cumming <bodnar42@phalynx.dhs.org>
CC: linux-kernel@vger.kernel.org, stewart@neuron.com,
        edward@thebsh.namesys.com
Subject: Re: passing params to boot readonly
In-Reply-To: <3C1841BB.8010003@neuron.com> <E16EPYW-0003nW-00@phalynx> <3C1874D5.5050205@namesys.com> <E16EYh6-0004At-00@phalynx>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Cumming wrote:

>On December 13, 2001 01:28, Hans Reiser wrote:
>
>>>It'd probably be pretty easy to make a boot disk using a hacked version of
>>>ReiserFS that refuses to replay the journal, by adding a "return 0;" near
>>>the top of journal_read(struct super_block *) in journal.c. However, you
>>>might feel more comfortable sending it off for data recovery than testing
>>>kernel hacks on it ;)
>>>
>
>>why not just edit the source code directly and recompile?
>>
>
>Just curious, but how would editing the source and recompiling be any 
>different from what I suggested?
>
>-Ryan
>
>
email delay time.  ;-)

Stewart, you can get Edward to create a new option for you by going to 
www.namesys.com/support.html

 $25 and you get a patch and all the additional support you need (sounds 
like you may need some for figuring out what version you have on the 
disk, etc.).

Or you might try what Ryan says, and save $25.

Hans


