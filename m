Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266186AbUJWGYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266186AbUJWGYH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 02:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267612AbUJWGUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 02:20:50 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:13231 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267633AbUJWGUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 02:20:14 -0400
Message-ID: <4179F81A.4010601@yahoo.com.au>
Date: Sat, 23 Oct 2004 16:20:10 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: William Lee Irwin III <wli@holomorphy.com>, Matt Mackall <mpm@selenic.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue...
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org> <20041022234631.GF28904@waste.org> <20041023011549.GK17038@holomorphy.com> <Pine.LNX.4.58.0410221821030.2101@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410221821030.2101@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> More importantly, maybe we could all realize that it isn't actually that 
> big of an issue ;)
> 
> 		Linus

Linus I agree it isn't a huge issue. The main thing for me is that
I could just give a _real_ release candidate more testing - run it
through some regression tests, make sure it functions OK on all my
computers, etc. I expect this would be helpful for people with large
sets of regression tests, and maybe those maintaining 'other'
architectures too.

I understand there's always "one more" patch to go in, but now that
we're doing this stable-development system, I think a week or two
weeks or even three weeks to stabalize the release with only
really-real-bugfixes can't be such a bad thing.

2.6.x-rc (rc for Ridiculous Count) can then be our development
releases, and 2.6.x-rc (rc for Release Candidate) are then closer
to stable releases (in terms of getting patches in).

Optionally, you could change Ridiculous Count to PRErelease to avoid
confusion :)

Other than that I don't have much to complain about... so keep up the
good work!

Nick
