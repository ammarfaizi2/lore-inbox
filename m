Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282178AbRLVTxJ>; Sat, 22 Dec 2001 14:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282187AbRLVTww>; Sat, 22 Dec 2001 14:52:52 -0500
Received: from cm61-15-169-117.hkcable.com.hk ([61.15.169.117]:11649 "EHLO
	cm61-15-169-117.hkcable.com.hk") by vger.kernel.org with ESMTP
	id <S282178AbRLVTwb>; Sat, 22 Dec 2001 14:52:31 -0500
Message-ID: <3C24E38E.3070809@rcn.com.hk>
Date: Sun, 23 Dec 2001 03:48:30 +0800
From: David Chow <davidchow@rcn.com.hk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Current NBD 'stuff'
In-Reply-To: <1007402546.3824.9.camel@akira.learningpatterns.com> <Pine.LNX.4.10.10112041644170.17617-400000@clements.sc.steeleye.com> <20011206130220.B49@toy.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am also looking for stuff NBD related, my first intention is studying 
on nfsswap, but I've heard NBD is more efficient, is there any port of 
nbd swap in the recent 2.4.1x kernels?  I may do an up port is the code 
is old, but hopefully something in 2.4 not 2.0 and 2.2 . Thanks.

regards,

David

Pavel Machek wrote:

>Hi
>
>>>Anyone know where I can find the latest NBD stuff? Esp. client/server
>>>code?
>>>
>>I have the same question. Maybe the user-level stuff is not being 
>>actively maintained?
>>
>>However, since we couldn't find current versions of this stuff, 
>>my colleagues and I patched nbd-server and the nbd kernel module 
>>to fix a few bugs and to make them a little more robust. I'll
>>attach my versions of those files (which I think are derived from
>>Pavel's .14.tar.gz versions).
>>
>
>Do not comment code by //. Kill if it you want to.
>
>You added clean way to stop nbd. Good.
>
>DO NOT USE ALL CAPITALS not even in printks().
>
>Fix those and patch looks ike good idea for 2.5.
>
>Look at nbd.sf.net. If you have patches against that, mail them to me. If 
>you are willing to co-develop stuff at nbd.sf.net, I guess we can arrange
>something.
>
>								Pavel
>


