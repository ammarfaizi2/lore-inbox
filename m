Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVABRZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVABRZi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 12:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVABRZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 12:25:34 -0500
Received: from mail.tmr.com ([216.238.38.203]:20425 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261294AbVABRZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 12:25:28 -0500
Message-ID: <41D8313F.1000003@tmr.com>
Date: Sun, 02 Jan 2005 12:37:03 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux lover <linux_lover2004@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: why there is different kernel versions from RedHat?
References: <20041231133525.47475.qmail@web52205.mail.yahoo.com>	 <41D5FDCE.2090905@tmr.com> <1104676568.14712.61.camel@localhost.localdomain>
In-Reply-To: <1104676568.14712.61.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sad, 2005-01-01 at 01:33, Bill Davidsen wrote:
> 
>>linux lover wrote:
>>
>>>Hi all,
>>>Where can i get special pathces used by RedHat to
>>>original kernels from www.kernel.org?
>>
>>Three step process
>>1 - get the RH source RPM and unpack
>>2 - get the kernel.org source of the same number
>>3 - use diff to generate the patch.
>>
>>Optional step 4 - look at the size of it, shake your head and swear.
> 
> 
> If you do it such a dumb way then sure. Most of the patches in the 2.6.8
> and 2.6.9 ones are post 2.6.9 fixes already in the base tree because of
> the lack of a stable base kernel tree in Linus new model.
> 
> In order that we don't go collectively insane maintaining it those are
> broken out from the feature patches we needed. Generating a single giant
> diff loses all the useful info.

I didn't feel the need of editorial comment on the original question, 
clearly if you had a better way to get WHAT HE ASKED FOR you might have 
included it instead of commenting on the answer.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
