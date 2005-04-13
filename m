Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262577AbVDMDpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbVDMDpU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 23:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262595AbVDMDoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 23:44:34 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:1709 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S262577AbVDMDbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 23:31:00 -0400
Date: Tue, 12 Apr 2005 23:27:44 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Christoph Hellwig <hch@infradead.org>
cc: "Kilau, Scott" <Scott_Kilau@digi.com>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>,
       Wen Xiong <wendyx@us.ibm.com>
Subject: Re: Digi Neo 8: linux-2.6.12_r2  jsm driver
In-Reply-To: <20050412153245.GA11521@infradead.org>
Message-ID: <Pine.GSO.4.33.0504122258510.1894-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Apr 2005, Christoph Hellwig wrote:
>On Tue, Apr 12, 2005 at 10:30:19AM -0500, Kilau, Scott wrote:
>> However, when the copyright holder says "No, please don't add that
>> code",
>> and gives *GOOD* reasons why, you should respect that decision.
>
>You didn't not give a single good reason.  Only political bullshit.

As an outside observer, I think he's given you plenty of reason to not
include this "hack".  You, however, appear to only want to make a mess.

>> So if I don't sign off on this change, does the matter?
>
>No.

Could you possibly be any more of an ass?  Don't bother answer that.

This is entirely the attitude the denouncers of open source live for.  It
shows the complete lake of respect for the wishes of the maintainer(s).  And
it's even worse because, as you and various others state, if it's not in
the kernel, it might as well not exist -- OSS, GPL, or not.  So, what's the
point of maintainers submitting code for inclusion in the kernel if they are
going to be ignored the instant it's excepted?  And the code's maintainer(s)
and/or authors are the only ones that *can* submit new code.  On one hand
you're honoring their wishes, but then basically ignoring them the instant
they "give" you their code. (If it's already GPL'd, there's nothing legally
stopping the code from being included in the first place, so why must they
ask for and/or ok inclusion?  Answer: good will within the community which
you are now pissing all over.)

Am I the only one with his eyes open here?  When I read the first reply from
Scott, I was thinking, "why not just make it a config option?  What's the
big f***ing deal?"  Make it a config option with help text pointing people
to the "better" driver with improved features and support for that board.
Or something as simple as "don't enable this if you're going to use this
other dirver."

The mere fact that you are unwilling to accept the desires of the maintainers
subtracts substantial credability from the entire kernel development process
and stands as a powerful deterent to getting manufacturers to submit drivers
to the kernel.  I'd be interested to hear Linus' take on this BS, but he's
busy digging out of the bullshit some other stuborn, self-absorbed nut has
buried him under.

--Ricky
"Kernel hacker for over 10 years" (but we know how much that's worth)


