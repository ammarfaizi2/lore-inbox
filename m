Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbTJNL7j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 07:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbTJNL7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 07:59:39 -0400
Received: from holomorphy.com ([66.224.33.161]:38538 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262260AbTJNL7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 07:59:35 -0400
Date: Tue, 14 Oct 2003 05:02:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Marco Fioretti <m.fioretti@inwind.it>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Unbloating the kernel, was: :mem=16MB laptop testing
Message-ID: <20031014120243.GO16158@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Marco Fioretti <m.fioretti@inwind.it>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <HMQWM7$61FA432C2B793029C11F4F77EEAABD1F@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HMQWM7$61FA432C2B793029C11F4F77EEAABD1F@libero.it>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> So I tried mem=16m on my laptop (stinkpad T21). I made the following
>> potentially useless observations:
[snip]
>> I guess the upshot is "unbloating" the kernel wouldn't do much good
>> anyway, since luserspace isn't in any kind of shape to run in this kind
>> of environment anymore either.

On Tue, Oct 14, 2003 at 01:44:31PM +0200, Marco Fioretti wrote:
> Wrong. (please read till the end, this is not academic, but a real
> call to arms!) Have a look at http://www.rule-project.org/en/,
> specifically the pages: http://www.rule-project.org/en/sw/kdrive.php
> (how we do without X, solving half of the problem)

Hearing this is about the happiest I can be to be proven wrong.


On Tue, Oct 14, 2003 at 01:44:31PM +0200, Marco Fioretti wrote:
> http://www.rule-project.org/en/test/ (the kind of machines we must
> work with) There are still a *lot* of lightweight applications giving
> real functionality without bloat. Of course, they can make little in
> these conditions if constantly swapped out from > the Kernel and/or X.
> With 16 or 24 MB or RAM even half a meg less is very important. We at
> RULE are doing what we can to select light GUI applications and test
> them with kdrive, but have no expertise to look after the kernel.
> Any help whatsoever in keeping 2.6 as light as possible, and to
> recompile stock 2.4 kernels to lighten them is really needed.
> The most important part of this is that it is not a programming
> contest, just for the sake of it.
> There are literally thousands of schools, all over the world, which simply
> cannot afford any money on computers. The "HW is cheap" slogan is
> very cruel when recited in places where 64 MB of RAM are one month's
> salary. I am not kidding. All these schools have is donated computers
> 5+ years old: even if they had the money they could not find spare parts
> from them. After food, medicines and shelter a good education is
> essential to make a decent living.
> It is extremely embarassing to tell these students "you can do
> without expensive MS SW, just find the money for a PC almost as
> expensive as those which will run Windows". A lightweight Linux is
> needed to many more people than the full featured one Thank you in
> advance for any support,
>              Marco Fioretti, RULE project coordinator
> PS: Oh, and while I'm at it, I'll even dare to ask for RULE network volunteers, see
> http://www.rule-project.org/en/rule_by_email.php

"$FOO is cheap" is a copout for sure; in the wrong country or for the
wrong people the limitation to "performant" hardware is a lethal blow
to usability. I'm not sure how to say how glad I am to hear of a direct
attack on this issue.

If you and/or your cohorts could inform us of kernel usability issues,
especially with 2.6, I would be much obliged (all the more so for a cc:).


-- wli
