Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVGIVk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVGIVk0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 17:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVGIVk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 17:40:26 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:5067 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S261743AbVGIVkY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 17:40:24 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Ed Cogburn <edcogburn@hotpop.com>
Cc: linux-kernel@vger.kernel.org
X-X-Sender: dlang@dlang.diginsite.com
Date: Sat, 9 Jul 2005 14:40:16 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: reiser4 vs politics: linux misses out again
In-Reply-To: <danen6$h3p$1@sea.gmane.org>
Message-ID: <Pine.LNX.4.62.0507091437090.5992@qynat.qvtvafvgr.pbz>
References: <200507040211.j642BL6f005488@laptop11.inf.utfsm.cl>
 <028601c581a0$cb1f3e20$2800000a@pc365dualp2> <dan077$n4t$1@sea.gmane.org>
 <200507082026.49404.tomlins@cam.org> <Pine.LNX.4.62.0507081737120.4458@qynat.qvtvafvgr.pbz>
 <danen6$h3p$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jul 2005, Ed Cogburn wrote:

> Maybe its because Hans and Co., having only a finite amount of dev time,
> would much prefer to spend that time on R4 rather than R3?  Maybe if we
> were to let R4 into the kernel, it wouldn't be long after that R3 could be
> retired because everyone has moved to R4?  Maybe if R4 had been allowed
> into the mainstream kernel a year ago, this ENTIRE ARGUMENT would be moot?
>
> Since when has there been a requirement for all new code to have a signed
> support contract before it enters the kernel?  Don't tell me this is
> normal, because I damn well know its not.  Early on and for the most part
> even today, good stuff gets into the kernel without any explicit or at
> least meaningful promises of long term support.  That stuff stays in the
> kernel as long as there is someone willing to maintain it, and it
> disappears from the kernel when there is no one left willing to keep it
> up-to-date.  That has always been the basic rule, without it Linux would
> never have gone beyond the stage of being Linus's toy, because if Linus had
> demanded such a support commitment up front, people would have lost
> interest in hacking on his toy.
>
> Devs should be free to work on whatever they want, because most of them are
> doing this on their own time anyway, otherwise they might just decide to
> hack on some other OS, or a fork of Linux instead.  Demanding long term
> support commitment from volunteers is just bizarre, since pretty soon, you
> won't have many volunteers left, with the ones still remaining consistently
> lying to you as everyone will know that the promises they are making can't
> be enforced.....  As for code from companies, has Linus gotten a signed
> support contract from IBM for JFS?  If he asked, do you really think they
> would agree to one?
>
> So this business of demanding a perpetual support contract from Hans for R3
> before you even let R4 into the kernel is patently absurd.  Such a contract
> won't be needed once R4 gets into widespread use and stabilizes, allowing
> R3 users to switch over to it, never mind that this has not been required
> to my knowledge of anyone else.  Either you're putting the cart before the
> horse on this one without realizing it, or you're just another member of
> the 'say-no-to-change' group (or worse, the say-no-to-Hans group) using any
> excuse that pops into your head for why you keep saying 'no'.
>

it's not that they are being asked to commit to a perpetual support 
contract, it's the fact that they AREN'T being asked to commit to a 
perpetual support contract that makes it more important that the code that 
they are asking to be merged must fit in well with the code and the 
philosphy of the rest of the kernel so that it can be supported well by 
others

if the kernel folks don't agree with the underlying design they may end up 
accepting it for a while, but will rip it out as soon as they get an 
excuse (see devfs for a perfect example)

David Lang

--
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
