Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272416AbTHNPSu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 11:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272423AbTHNPSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 11:18:50 -0400
Received: from zeke.inet.com ([199.171.211.198]:39924 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id S272416AbTHNPS2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 11:18:28 -0400
Message-ID: <3F3BA839.8020207@inet.com>
Date: Thu, 14 Aug 2003 10:18:17 -0500
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030708
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Jeff Garzik <jgarzik@pobox.com>, davej@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: [PATCH] CodingStyle fixes for drm_agpsupport
References: <E19mF4Y-0005Eg-00@tetrachloride> <20030811164012.GB858@work.bitmover.com> <3F37CB44.5000307@pobox.com> <20030811170425.GA4418@work.bitmover.com> <3F3B9AF8.4060904@inet.com> <20030814144711.GA5926@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> On Thu, Aug 14, 2003 at 09:21:44AM -0500, Eli Carter wrote:
> 
>>>That ought to be balanced with "don't screw up the revision history, people
>>>use it".  It's one thing to reformat code that is unreadable, for the most
>>>part this code didn't come close to unreadable.
>>
>>Devil's advocate:
>>Then perhaps the (revision control) tool is getting in the way of doing 
>>the job and should be fixed?  :)
>>Perhaps being able to flag a changeset as a 'formatting change', and 
>>have the option to hide it or make it 'transparent' in some fashion? 
>>Hmm... "Annotate only the changes that relate to feature X."...
>>Oh, and a complete AI with that if you don't mind. ;)
>>
>>But you've probably already thought about all this...
> 
> 
> Indeed I have. 

Figured. :)

 > And there is a reason that we have a policy at BitMover
> where "formatting changes" are prohibited and we make people redo their
> changesets until they get them right.

Ah yes, I do see the value of enforcing a coding style from the get-go.

> In other words, you are welcome to write a revision control system
> which can look through the formatting changes and give you the semantic
> knowledge that you want.  We'd love to see how it is done and then do
> it in BitKeeper :)

<troll>What?!  And _copy_ someone else's hard work?!</troll> *cough* 
(Sorry, couldn't resist. ;) )

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

