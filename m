Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbVACXpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbVACXpS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 18:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbVACXo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 18:44:26 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:31237 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261983AbVACXhY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:37:24 -0500
Message-ID: <41D9D69C.1070002@tmr.com>
Date: Mon, 03 Jan 2005 18:34:52 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: mail.linux-kernel
To: Arjan van de Ven <arjan@infradead.org>
CC: Adrian Bunk <bunk@stusta.de>, Rik van Riel <riel@redhat.com>,
       Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
References: <20050103153438.GF2980@stusta.de><1697129508.20050102210332@dns.toxicfilms.tv> <1104767943.4192.17.camel@laptopd505.fenrus.org>
In-Reply-To: <1104767943.4192.17.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Mon, 2005-01-03 at 16:34 +0100, Adrian Bunk wrote:
> 
>>On Mon, Jan 03, 2005 at 10:18:47AM -0500, Rik van Riel wrote:
>>
>>>On Sun, 2 Jan 2005, Andries Brouwer wrote:
>>>
>>>
>>>>You change some stuff. The bad mistakes are discovered very soon.
>>>>Some subtler things or some things that occur only in special
>>>>configurations or under special conditions or just with
>>>>very low probability may not be noticed until much later.
>>>
>>>Some of these subtle bugs are only discovered a year
>>>after the distribution with some particular kernel has
>>>been deployed - at which point the kernel has moved on
>>>so far that the fix the distro does might no longer
>>>apply (even in concept) to the upstream kernel...
>>>
>>>This is especially true when you are talking about really
>>>big database servers and bugs that take weeks or months
>>>to trigger.
>>
>>If at this time 2.8 was already released, the 2.8 kernel available at 
>>this time will be roughly what 2.6 would have been under the current 
>>development model, and 2.6 will be a rock stable kernel.
> 
> 
> 
> as long as more things get fixed than new bugs introduced (and that
> still seems to be the case) things only improve in 2.6. 
> 
> The joint approach also has major advantages, even for quality:
> All testing happens on the same codebase. 
> Previously, the testing focus was split between the stable and unstable
> branch, to the detriment of *both*.

You think so? I think the number of people testing the 2.4.xx-rc 
versions AND the 2.6.xx-bkN versions is a small (nonzero) percentage of 
total people trying any new release. I think people test what they plan 
to use, so there's less competition for testers than you suggest. People 
staying with 2.4 test that, people wanting or needing to move forward 
test 2.6.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
