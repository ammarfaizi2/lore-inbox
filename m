Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284300AbSBMOVz>; Wed, 13 Feb 2002 09:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284987AbSBMOVo>; Wed, 13 Feb 2002 09:21:44 -0500
Received: from frege-d-math-north-g-west.math.ethz.ch ([129.132.145.3]:47604
	"EHLO frege.math.ethz.ch") by vger.kernel.org with ESMTP
	id <S284300AbSBMOVf>; Wed, 13 Feb 2002 09:21:35 -0500
Message-ID: <3C6A7657.9060708@debian.org>
Date: Wed, 13 Feb 2002 15:21:11 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Benjamin Pharr <ben@benpharr.com>, linux-kernel@vger.kernel.org
Subject: Re: choice Help Sections 
In-Reply-To: <fa.ntt6kfv.191g73i@ifi.uio.no> <fa.d3an46v.7mca03@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:

> ben@benpharr.com said:
> 
>>Has anyone else noticed the availability of only one help section in
>>"choice" blocks when using make menuconfig (and others maybe?)? 
>>
> 
>>The best example of this is selection of "Processor family". No matter
>>which option is highlighted when Help is selected, it always gives the
>>help for CONFIG_M386.
>>
> 
> AFAIK the help text for choice entries has _always_ been implemented the 
> way you observed - a single entry with the name of the first choice, which 
> helps you decide what to choose - not individual entries for each possible 
> choice.
> 
> It looks like the current Configure.help is broken. I suggest you submit 
> patches to correct it.


The other items are ready for CML2. One of the Configure.help maintainers
is also the maintainer of CML2, so...


	giacomo

