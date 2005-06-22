Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262509AbVFVB6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbVFVB6N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 21:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbVFVB6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 21:58:13 -0400
Received: from mail.dvmed.net ([216.237.124.58]:37802 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262509AbVFVB5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 21:57:34 -0400
Message-ID: <42B8C578.2090705@pobox.com>
Date: Tue, 21 Jun 2005 21:57:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Andi Kleen <ak@suse.de>, Alexander Lyamin aka FLX <flx@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>, vs <vs@thebsh.namesys.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: -mm -> 2.6.13 merge status
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel> <p73d5qgc67h.fsf@verdi.suse.de> <42B86027.3090001@namesys.com> <20050621195642.GD14251@wotan.suse.de> <42B8C0FF.2010800@namesys.com>
In-Reply-To: <42B8C0FF.2010800@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> V4 has a mailing list, and a large number of testers who read the code
> and comment on it.   V4 has been reviewed and tested much more than V3
> was before merging.   Given that we sent it in quite some time ago, your
> suggestion that an additional review by unspecified additional others be
> a requirement for merging seems untimely.  Do you see my point of view
> on this?
> 
> I would however enjoy receiving coding suggestions at ANY time.  We
> don't get as much of that as I would like.   I would in particular love
> to have you Andi Kleen do a full review of V4 if you could be that
> generous with your time, as I liked much of the advice you gave us on V3. 
> 
> Unspecified others doing a review, well, who knows, I will surely take
> the time to consider what is said by them though..... 
> 
> I would prefer to not get reviews from authors of other filesystems who
> prefer their own code, skim through our code without taking the time to
> grok our philosophy and approach in depth, and then complain that our
> code is different from what they chose to write, and think that our
> changing to be like them should be mandated.  I will not name names here....


The Linux system isn't the greatest in the world, but here's reality: 
when a merge is imminent, a lot more attention is paid.

Andrew regularly uses this knowledge of human psychology to his (and 
Linux's) benefit :)

The MAJOR downside is that merge-stopping issues are sometimes ignored 
until an upstream merge is imminent.

If you want to get your code merged, you gotta work with the system, and 
LISTEN to the feedback.

	Jeff, who doesn't have a filesystem axe to grind


