Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVCCDpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVCCDpY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 22:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVCCDmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 22:42:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61139 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261401AbVCCDlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 22:41:23 -0500
Message-ID: <42268749.4010504@pobox.com>
Date: Wed, 02 Mar 2005 22:40:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <42264F6C.8030508@pobox.com> <20050302162312.06e22e70.akpm@osdl.org> <42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net> <422674A4.9080209@pobox.com> <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 2 Mar 2005, Jeff Garzik wrote:
> 
>>If we want a calming period, we need to do development like 2.4.x is 
>>done today.  It's sane, understandable and it works.
> 
> 
> No. It's insane, and the only reason it works is that 2.4.x is a totally
> different animal. Namely it doesn't have the kind of active development AT
> ALL any more. It _only_ has the "even" number kind of things, and quite 
> frankly, even those are a lot less than 2.6.x has.
> 
> 
>>2.6.x-pre: bugfixes and features
>>2.6.x-rc: bugfixes only
> 
> 
> And the reason it does _not_ work is that all the people we want testing 
> sure as _hell_ won't be testing -rc versions.
> 
> That's the whole point here, at least to me. I want to have people test 
> things out, but it doesn't matter how many -rc kernels I'd do, it just 
> won't happen. It's not a "real release".

People don't test 2.6-rc releases because they know they are not 
"release candidate, with only bug fixes" releases, which is how the rest 
of the world interprets the phrase.

Making them official releases in the even/odd manner is what neilb 
implies.  You'll just be diminishing the value of releases.  A "real 
release" won't be a real release anymore.  You're just renaming the -rc 
that isn't really an -rc.

	Jeff


