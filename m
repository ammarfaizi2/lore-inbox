Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbVAEBiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbVAEBiL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 20:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVAEBhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 20:37:47 -0500
Received: from hermes.domdv.de ([193.102.202.1]:21006 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S262201AbVAEBfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 20:35:52 -0500
Message-ID: <41DB4476.8080400@domdv.de>
Date: Wed, 05 Jan 2005 02:35:50 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, "Jack O'Quin" <joq@io.com>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <1104374603.9732.32.camel@krustophenia.net>	 <20050103140359.GA19976@infradead.org>	 <1104862614.8255.1.camel@krustophenia.net>	 <20050104182010.GA15254@infradead.org> <1104865034.8346.4.camel@krustophenia.net>
In-Reply-To: <1104865034.8346.4.camel@krustophenia.net>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Tue, 2005-01-04 at 18:20 +0000, Christoph Hellwig wrote:
> 
>>On Tue, Jan 04, 2005 at 01:16:54PM -0500, Lee Revell wrote:
>>
>>>Got a patch?  Code talks, BS walks.  This is working perfectly, right
>>>now, and is being used by thousands of Linux ausio users.
>>
>>Which still doesn't mean it's the right design.  And no, I don't need the
>>feature so I won't write it.  If you want a certain feature it's up to
>>you to implement it in a way that's considered mergeable.
>>
> 
> 
> Please specify what's wrong with it.  So far all your objection amounts
> to is "I don't like it".
> 
> If you do have anything other that your opinion to back up your
> assertion that it's a bad design, you should have raised it months ago
> when this was first posted.  Now that we have it to a mergeable state
> (as far as the people who worked on it are concerned), you want to pop
> up and say "Nope, bad design"?

Let me remind you all that according to lkml history hch has always been 
biased and objecting to anything related to lsm. Nobody can take hch's 
opinion here as objective. I would even go so far that when things are 
related to lsm(s) he's just tro...
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
