Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbTI0UMy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 16:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbTI0UMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 16:12:54 -0400
Received: from holomorphy.com ([66.224.33.161]:20892 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261871AbTI0UMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 16:12:53 -0400
Date: Sat, 27 Sep 2003 13:13:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: Roger Luethi <rl@hellgate.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] No Swap. Re: [BUG 2.6.90-test5] kernel shits itself with 48mb ram under moderate load
Message-ID: <20030927201347.GM4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ihar 'Philips' Filipau <filia@softhome.net>,
	Roger Luethi <rl@hellgate.ch>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <ArQ0.821.23@gated-at.bofh.it> <ArQ0.821.25@gated-at.bofh.it> <ArQ0.821.21@gated-at.bofh.it> <ArZC.8f1.9@gated-at.bofh.it> <3F75EC3B.4030305@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F75EC3B.4030305@softhome.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 27, 2003 at 09:59:55PM +0200, Ihar 'Philips' Filipau wrote:
>    Sorry, I even marked $subject as [OT].
>    I'm answering the question '2.4 without swap' - Yes. It is. Works. 
> No  problems.
>    <rant>'Paging like crazy' became for me a synonym of Linux. It 
> doesn't matter how much memory you have. Less == worse. Developers 
> stopped testing VMM regression on low-memory computers long time ago. 
> <sarcasm>We have now fashion for clusters and numas. And a lot of swap 
> on very fast raids. <sarcasm size=+100%>After all it is cheap. Just 
> couple of thousands greenbacks. </sarcasm> </sarcasm> It was really 
> funny when developers on LKML were sugesting to buy another hdd for 
> swap. Very funny.</rant>
>    Unfortunately I'm not a specialist in VMM...
>    As I see there is not that much edge case testing going around.

It's known what has to be done for it. AFAICT upstream doesn't like
the answers and just says "throw hardware at it". I've written it off
as a lost cause, though I was at one time interested.


-- wli
