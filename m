Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272366AbTHNOV6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 10:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272372AbTHNOV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 10:21:58 -0400
Received: from zeke.inet.com ([199.171.211.198]:11501 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id S272366AbTHNOV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 10:21:57 -0400
Message-ID: <3F3B9AF8.4060904@inet.com>
Date: Thu, 14 Aug 2003 09:21:44 -0500
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030708
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Jeff Garzik <jgarzik@pobox.com>, davej@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: [PATCH] CodingStyle fixes for drm_agpsupport
References: <E19mF4Y-0005Eg-00@tetrachloride> <20030811164012.GB858@work.bitmover.com> <3F37CB44.5000307@pobox.com> <20030811170425.GA4418@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> On Mon, Aug 11, 2003 at 12:58:44PM -0400, Jeff Garzik wrote:
> 
>>Larry McVoy wrote:
>>
>>>A few comments on why I don't like this patch:
>>>   1) It's a formatting only patch.  That screws over people who are using
>>>      BK for debugging, now when I double click on these changes I'll get
>>>      to your cleanup patch, not the patch that was the last substantive
>>>      change.
>>
>>This is true, but at the same time, in Linux CodingStyle patches 
>>culturally acceptable.  I think the general logic is just "don't go 
>>overboard; reformat a tiny fragment at a time."
> 
> 
> That ought to be balanced with "don't screw up the revision history, people
> use it".  It's one thing to reformat code that is unreadable, for the most
> part this code didn't come close to unreadable.

Devil's advocate:
Then perhaps the (revision control) tool is getting in the way of doing 
the job and should be fixed?  :)
Perhaps being able to flag a changeset as a 'formatting change', and 
have the option to hide it or make it 'transparent' in some fashion? 
Hmm... "Annotate only the changes that relate to feature X."...
Oh, and a complete AI with that if you don't mind. ;)

But you've probably already thought about all this...

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

