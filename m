Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263753AbTIHXof (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 19:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbTIHXof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 19:44:35 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:20489 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S263753AbTIHXoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 19:44:32 -0400
Message-ID: <3F5D196C.2040202@techsource.com>
Date: Mon, 08 Sep 2003 20:06:04 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Use of AI for process scheduling
References: <3F5CD863.4020605@techsource.com> <20030908225749.GJ4306@holomorphy.com> <20030908230621.GC17441@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Fedyk wrote:
> On Mon, Sep 08, 2003 at 03:57:49PM -0700, William Lee Irwin III wrote:
> 
>>On Mon, Sep 08, 2003 at 03:28:35PM -0400, Timothy Miller wrote:
>>
>>>Ok, I know I'm going too far.  Right now, the best application would be 
>>>the process scheduler, but we should start thinking about ways of making 
>>>the system "self aware" and "self correcting" so that when the model 
>>>observes the logic to misbehave, detailed information can be produced 
>>>for debugging purposes.
>>>Naturally, I am interested in contributing to this, but some of what I 
>>>will have to learn to participate will come out of ensuing discussions. 
>>> I have a lot to learn, but I think if these ideas are valuable, others 
>>>who already know enough will start to do something with them.
>>
>>Show me the code.
> 
> 
> I think he's working on a draft, not implementation.

Yeah, I didn't think his comment was very helpful since I thought it was 
clear that I was working on a draft of an IDEA.

> Any chance we'll see any code from you (or the group you seem to be trying
> to build) Tim?

Well...

Since I don't know enough about the actual kernel, I thought perhaps I 
could start with writing a generic neural net that could be added to the 
kernel.  The fact that I need an integer-only algorithm will require 
that I largely start from scratch.

I also need to refresh my memory on how to do back-propogation.

Oh, and most importantly, I need ideas from others so I don't go down 
the wrong path.

