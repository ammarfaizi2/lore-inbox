Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282242AbRK2BIz>; Wed, 28 Nov 2001 20:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282243AbRK2BIr>; Wed, 28 Nov 2001 20:08:47 -0500
Received: from smtp.Lynuxworks.COM ([207.21.185.24]:1801 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP
	id <S282242AbRK2BIg>; Wed, 28 Nov 2001 20:08:36 -0500
Message-ID: <3C058A62.6010504@lnxw.com>
Date: Wed, 28 Nov 2001 17:07:46 -0800
From: Petko Manolov <pmanolov@Lnxw.COM>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011127
X-Accept-Language: en, bg
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Peter Waltenberg <pwalten@au1.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue
In-Reply-To: <Pine.GSO.4.21.0111281901110.8609-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:

> 
>>Someone who cares, come up with an indentrc for the kernel code, and get it
>>into Documentation/CodingStyle

...

> indent does _not_ solve the problem of:
...


I quite liked it, applies perfectly for some people i know... :-)

Anyway, in Lindent you'll see "-psl" (--procname-start-lines) option
which contradict with what is written in CodingStyle i.e:

int my_proc(void)
{
...
}

which I personally prefer.


		Petko

