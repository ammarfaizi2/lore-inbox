Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVACXYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVACXYV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 18:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVACXXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 18:23:33 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:42137 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261932AbVACXVI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:21:08 -0500
Message-ID: <41D9D377.4060006@tmr.com>
Date: Mon, 03 Jan 2005 18:21:27 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe Alfaro Solana <lkml@mac.com>
CC: William Lee Irwin III <wli@holomorphy.com>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, Rik van Riel <riel@redhat.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@debian.org>
Subject: Re: starting with 2.7
References: <20050103153758.GY29332@holomorphy.com><20050103153758.GY29332@holomorphy.com> <6D2C0E07-5DAE-11D9-9FD3-000D9352858E@mac.com>
In-Reply-To: <6D2C0E07-5DAE-11D9-9FD3-000D9352858E@mac.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:
> On 3 Jan 2005, at 16:37, William Lee Irwin III wrote:
> 
>> On Mon, Jan 03, 2005 at 10:20:40AM -0500, Rik van Riel wrote:
>>
>>>> 2.2 before 2.2.20 also had this kind of problem, as did
>>>> the 2.4 kernel before 2.4.20 or thereabouts.
>>>> I'm pretty sure 2.6 is actually doing better than the
>>>> early 2.0, 2.2 and 2.4 kernels...
>>
>>
>> On Mon, Jan 03, 2005 at 04:29:53PM +0100, Adrian Bunk wrote:
>>
>>> My personal impression was that even the 2.6.0-test kernels were much
>>> better than the 2.4.0-test kernels.
>>> But 2.6.20 will most likely still have the stability of the early
>>> 2.6 kernels instead of a greatly increased stability as observed in
>>> 2.2.20 and 2.4.20 .
>>
>>
>> This is speculation; there is no reason not to expect the process to
>> converge to as great of stability or greater stability than the
>> 2.4-style process. I specuate that it will in fact do precisely that.
> 
> 
> I would like to comment in that the issue is not exclusively targeted to 
> stability, but the ability to keep up with kernel development. For 
> example, it was pretty common for older versions of VMWare and NVidia 
> driver to break up whenever a new kernel version was released.
> 
> I think it's a PITA for developers to rework some of the closed-source 
> code to adopt the new changes in the Linux kernel.

Different can, different worms... there are a number of developers who 
dislike closed source drivers and software and make no effort to avoid 
breaking them. I'm happy to see a vendor care enough about Linux to have 
the driver, there are legal reasons why some source isn't open. You 
can't always fund using politically correct hardware. To paraphrase, "we 
don't always compute with the hardware we'd LIKE to have, we have to 
compute with the hardware we DO have."

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
