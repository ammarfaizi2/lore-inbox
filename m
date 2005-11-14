Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbVKNUMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbVKNUMb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 15:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbVKNUMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 15:12:31 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:61180 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932076AbVKNUMa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 15:12:30 -0500
Message-ID: <4378EFF8.5030202@tmr.com>
Date: Mon, 14 Nov 2005 15:13:44 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org, len.brown@intel.com,
       jgarzik@pobox.com, tony.luck@intel.com, bcollins@debian.org,
       scjody@modernduck.com, dwmw2@infradead.org, rolandd@cisco.com,
       davej@codemonkey.org.uk, axboe@suse.de, shaggy@austin.ibm.com,
       sfrench@us.ibm.com
Subject: Re: merge status
References: <20051109133558.513facef.akpm@osdl.org>	<1131573041.8541.4.camel@mulgrave>	<Pine.LNX.4.64.0511091358560.4627@g5.osdl.org>	<1131575124.8541.9.camel@mulgrave> <20051109150141.0bcbf9e3.akpm@osdl.org>
In-Reply-To: <20051109150141.0bcbf9e3.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> James Bottomley <James.Bottomley@SteelEye.com> wrote:
> 
>>it's my contributors who drop me in it
>>by leaving their patch sets until you declare a kernel, dumping the
>>integration testing on me in whatever time window is left.
> 
> 
> Yes, I think I'm noticing an uptick in patches as soon as a kernel is
> released.
> 
> It's a bit irritating, and is unexpected (here, at least).  I guess people
> like to hold onto their work for as long as possible so when they release
> it, it's in the best possible shape.
> 
> I guess all we can do is to encourage people to merge up when it's working,
> not when it's time to merge it into mainline.
> 
> One could just say "if I don't have it by the time 2.6.n is released, it
> goes into 2.6.n+2", but that's probably getting outside the realm of
> practicality.

Consider that people want to send you something which will work with the 
new kernel and are holding back until they can send you something which 
has a higher chance of working as delivered. If you want to avoid having 
a rediff be part of the integration testing I thought you were trying to 
avoid.

I interpreted that as people trying to make stuff easier for you.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
