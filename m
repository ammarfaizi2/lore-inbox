Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262169AbUK3QSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbUK3QSj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 11:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbUK3QSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 11:18:35 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:21177 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S262153AbUK3QRq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 11:17:46 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-7
Date: Tue, 30 Nov 2004 11:20:08 -0500
User-Agent: KMail/1.7
References: <41AA2A43.4000507@mrv.com> <20041130085827.GB19516@elte.hu>
In-Reply-To: <20041130085827.GB19516@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411301120.08130.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.57.34] at Tue, 30 Nov 2004 10:17:45 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 November 2004 03:58, Ingo Molnar wrote:
>* Eran Mann <emann@mrv.com> wrote:
>> I'm guessing here, but with the following patch it at least
>> compiles:
>
>yeah, this is the correct patch, included in the -31-14 and later
>patches.
>
> Ingo

I hadn't hit this one yet, up since about midnight with -13, and just 
now found -15 so I'll build it.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.29% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
