Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275501AbTHNUVb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 16:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275532AbTHNUVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 16:21:31 -0400
Received: from zeke.inet.com ([199.171.211.198]:3738 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id S275501AbTHNUVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 16:21:16 -0400
Message-ID: <3F3BEF30.5000201@inet.com>
Date: Thu, 14 Aug 2003 15:21:04 -0500
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030708
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: dri-devel@lists.sourceforge.net, Jeff Garzik <jgarzik@pobox.com>,
       davej@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Dri-devel] Re: [PATCH] CodingStyle fixes for drm_agpsupport
References: <E19mF4Y-0005Eg-00@tetrachloride> <20030811164012.GB858@work.bitmover.com> <3F37CB44.5000307@pobox.com> <20030811170425.GA4418@work.bitmover.com> <3F3B9AF8.4060904@inet.com> <20030814144711.GA5926@work.bitmover.com> <20030814114340.A48492@bolthole.com> <20030814201605.GA16291@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> On Thu, Aug 14, 2003 at 11:43:40AM -0700, Philip Brown wrote:
> 
>>On Thu, Aug 14, 2003 at 07:47:11AM -0700, Larry McVoy wrote:
>>
>>>...
>>>Indeed I have.  And there is a reason that we have a policy at BitMover
>>>where "formatting changes" are prohibited and we make people redo their
>>>changesets until they get them right.
>>>
>>>In other words, you are welcome to write a revision control system
>>>which can look through the formatting changes and give you the semantic
>>>knowledge that you want.  We'd love to see how it is done and then do
>>>it in BitKeeper :)
>>
>>You should allow for ...
> 
> 
> Didn't you mean "in the SCM system I'm writing, I allow for ..."?
> 
> Besides, your point is content specific.  People check things other than
> C code into BK.

I assume you can have content-specific validators run before a commit? 
(CVS can.) A validator could see that it was formatting only and mark it 
in someway perhaps?
But we've wandered _way_ OT at this point, and it's well past the point 
of diminishing returns...

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

