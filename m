Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbUJYVda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbUJYVda (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 17:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbUJYV3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 17:29:42 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:61073 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261981AbUJYV2Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 17:28:25 -0400
Message-ID: <417D7089.3070208@tmr.com>
Date: Mon, 25 Oct 2004 17:30:49 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Linus Torvalds <torvalds@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue...
References: <Pine.LNX.4.58.0410221821030.2101@ppc970.osdl.org><Pine.LNX.4.58.0410221821030.2101@ppc970.osdl.org> <4179F81A.4010601@yahoo.com.au>
In-Reply-To: <4179F81A.4010601@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Linus I agree it isn't a huge issue. The main thing for me is that
> I could just give a _real_ release candidate more testing - run it
> through some regression tests, make sure it functions OK on all my
> computers, etc. I expect this would be helpful for people with large
> sets of regression tests, and maybe those maintaining 'other'
> architectures too.
> 
> I understand there's always "one more" patch to go in, but now that
> we're doing this stable-development system, I think a week or two
> weeks or even three weeks to stabalize the release with only
> really-real-bugfixes can't be such a bad thing.
> 
> 2.6.x-rc (rc for Ridiculous Count) can then be our development
> releases, and 2.6.x-rc (rc for Release Candidate) are then closer
> to stable releases (in terms of getting patches in).
> 
> Optionally, you could change Ridiculous Count to PRErelease to avoid
> confusion :)
> 
> Other than that I don't have much to complain about... so keep up the
> good work!

I do agree that the pre and rc names gave a strong hint that (-pre) new 
features would be considered or (-rc) it's worth doing more serious 
testing. If Linux doesn't like this any more, perhaps some other way to 
indicate the same thing would be desirable. I admit that the kernel has 
gotten so good that I only try -rc (by whatever name) kernel, I'm not 
waiting for the next big thing. I think that's really good, actually.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
