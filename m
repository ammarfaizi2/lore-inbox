Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbUJZRh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUJZRh7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 13:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbUJZRh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 13:37:58 -0400
Received: from holomorphy.com ([207.189.100.168]:64997 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261347AbUJZRhj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 13:37:39 -0400
Date: Tue, 26 Oct 2004 10:37:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Massimo Cetra <mcetra@navynet.it>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Bill Davidsen <davidsen@tmr.com>
Subject: Re: My thoughts on the "new development model"
Message-ID: <20041026173706.GJ17038@holomorphy.com>
References: <200410261233_MC3-1-8D2A-5BA7@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410261233_MC3-1-8D2A-5BA7@compuserve.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004 at 08:03:13 -0700 William Lee Irwin III wrote:
>> I'm running 2.6 on a number of machines I rely upon
>> heavily as servers etc. on the open net as well as the usual dedicated
>> kernel hacking machines. The uptimes of the relied-upon systems are
>> measured in months, at times approaching a year.

On Tue, Oct 26, 2004 at 12:32:19PM -0400, Chuck Ebbert wrote:
>  "It works for me" doesn't cut it in the OS world.

It's an existence proof spanning a wide swath of architectures. If
you are not seeing similar results, send bugreports.


On Tue, 26 Oct 2004 at 08:03:13 -0700 William Lee Irwin III wrote:
>> More bugs are fixed than are introduced every release by a large margin.

On Tue, Oct 26, 2004 at 12:32:19PM -0400, Chuck Ebbert wrote:
>  Irrelevant.

Incorrect. Insert infinite descent argument here.


On Tue, 26 Oct 2004 at 08:03:13 -0700 William Lee Irwin III wrote:
>> And not even your beloved 2.4 is immune to regressions.

On Tue, Oct 26, 2004 at 12:32:19PM -0400, Chuck Ebbert wrote:
>  We're not talking about regression, i.e. reappearance of old bugs.

That's not an important distinction.


On Tue, 26 Oct 2004 at 08:03:13 -0700 William Lee Irwin III wrote:
>> What does the number of patchsets have to do with anything?

On Tue, Oct 26, 2004 at 12:32:19PM -0400, Chuck Ebbert wrote:
>  Large changes produce bugs -- that's a fact of life.

If the patchsets had anything to do with mainline, they would have
been merged anyway.


On Tue, Oct 26, 2004 at 12:32:19PM -0400, Chuck Ebbert wrote:
>  It's not that the changes aren't needed, it's just the the previous
> 2.6 release is kind of like a baby abandoned on a doorstep -- nobody
> has the time to fix those last few bugs.  Even if someone were to
> step up to the plate and try to create a stable 2.6 series, I'd bet
> the lead developers wouldn't even spend time working on it.

Then you don't understand Linux' releases. Point releases are in fact
updated and maintained. Those updates are given the name of the next
point release. The fact you are so timid or misguided that the scale of
the kernel terrifies you is not kernel developers' problem.


-- wli
