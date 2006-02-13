Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751643AbWBMF1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbWBMF1L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 00:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbWBMF1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 00:27:11 -0500
Received: from mail.gmx.de ([213.165.64.21]:60101 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751643AbWBMF1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 00:27:10 -0500
X-Authenticated: #14349625
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
From: MIke Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, gcoady@gmail.com,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <200602131605.17198.kernel@kolivas.org>
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com>
	 <1139801975.2739.72.camel@mindpipe> <1139806761.25253.33.camel@homer>
	 <200602131605.17198.kernel@kolivas.org>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 06:32:46 +0100
Message-Id: <1139808766.7642.12.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-13 at 16:05 +1100, Con Kolivas wrote:
> On Monday 13 February 2006 15:59, MIke Galbraith wrote:
> > Now, let's see if we can get your problem fixed with something that can
> > possibly go into 2.6.16 as a bugfix.  Can you please try the below?
> 
> These sorts of changes definitely need to pass through -mm first... and don't 
> forget -mm looks quite different to mainline.

I'll leave that up to Ingo of course, and certainly have no problem with
them burning in mm.  However, I must say that I personally classify
these two changes as being trivial and obviously correct enough to be
included in 2.6.16.  I realize that mm is different in this area (we
talked about it), but the problems addressed by this patch still remain.
Anyway, let's wait and see if it fixes Lee's problem.

	-Mike

