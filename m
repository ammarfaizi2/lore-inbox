Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbTE2W5u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 18:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263103AbTE2W5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 18:57:50 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:36093 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263084AbTE2W5t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 18:57:49 -0400
Message-ID: <3ED692ED.8040804@austin.ibm.com>
Date: Thu, 29 May 2003 18:08:29 -0500
From: Mark Peloquin <peloquin@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nathan <smurf@osdl.org>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: Nightly regression runs against current bk tree
References: <3ED66C83.8070608@austin.ibm.com.suse.lists.linux.kernel> <p73smqx791m.fsf@oldwotan.suse.de> <20030529220343.GL25252@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nathan wrote:

>On Thu, May 29, 2003 at 11:11:17PM +0200, Andi Kleen wrote:
>  
>
>>It would be nice if we had a new linux-testresults list where such
>>updates could be posted regularly. I don't think it belong on l-k
>>because it would be too noisy. Perhaps such a list could be added to 
>>vger. David, what do you think?
>>    
>>
>
>The OSDL has a serious amount of automated testing we could point the
>results of to a separate list if it is created.
>
>Right now we avoid pointing that sort of thing to l-k because it would
>drive people nuts.  On average we complete 40+ tests a day.
>
>With all the testing efforts going on, a central list to post and
>analyze results would be good.  People interested in helping out could
>easily work with testers to look for trends and help with root cause
>analysis.
>
>When results are found to contain significant data, we can always notify l-k.
>

Easy of viewing should be considered. We have tried to show a high level 
summary that allows the users to quickly, looking in one place, 
determine if any significant data is found. When the users seems 
something of interest, they only need follow the links to see the 
details. Its shouldn't be necessary for users to sift through one email 
for each test. If finding signficant data was easier, and I think it can 
be made easier, users would look at it themselves and there wouldn't be 
the need to have to notify l-k.

I'm not trying to be competetive here. I just think results and 
comparisons can be made that covers a large amount of tests in a single 
page or note. One note per day does not IMHO seem like too much. That 
note can always be the "tip of the iceberg" pointing to many other 
things. Thus those not interested can simply skip that note.

Mark


