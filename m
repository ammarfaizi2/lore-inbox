Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030326AbVKHWOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbVKHWOk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 17:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbVKHWOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 17:14:39 -0500
Received: from main.gmane.org ([80.91.229.2]:42889 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030326AbVKHWOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 17:14:38 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: An idea on devfs vs. udev
Date: Tue, 08 Nov 2005 17:13:24 -0500
Message-ID: <dkr7qb$n18$1@sea.gmane.org>
References: <200510301907.11860.daniele@orlandi.com> <17253.14484.653996.225212@cse.unsw.edu.au> <20051030222309.GA9423@kroah.com> <20051108184132.GC8126@waste.org> <20051108185101.GA16011@kroah.com> <20051108191735.GS9760@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: prgy-npn2.prodigy.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
In-Reply-To: <20051108191735.GS9760@waste.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Tue, Nov 08, 2005 at 10:51:01AM -0800, Greg KH wrote:
> 
>>On Tue, Nov 08, 2005 at 10:41:32AM -0800, Matt Mackall wrote:
>>
>>>On Sun, Oct 30, 2005 at 02:23:09PM -0800, Greg KH wrote:
>>>
>>>>On Mon, Oct 31, 2005 at 08:18:12AM +1100, Neil Brown wrote:
>>>>
>>>>>But then to make matters worse, there is this "sample.sh" file.  UGH!
>>>>>It's a bit of shell code exported by the kernel.
>>>>>   #!/bin/sh
>>>>>   mknod /dev/hda  b 3 0
>>>>
>>>>That's just a "joke" patch that is only in the -mm tree, as it gets
>>>>pulled in from my tree.  It's not in mainline, and will never go there.
>>>
>>>Perhaps you can drop this horror now that Halloween has passed.
>>
>>Heh.  But why?  Is it causing problems for anyone?
> 
> 
> Someone else might take your joke seriously. Or worse yet, imitate it.
> See C++.
> 
It probably should be rewritten in C for efficiency.

;-) if you didn't guess...

