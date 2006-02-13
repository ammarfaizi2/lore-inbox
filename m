Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751698AbWBMKAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbWBMKAj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 05:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbWBMKAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 05:00:39 -0500
Received: from mail.gmx.net ([213.165.64.21]:30405 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751697AbWBMKAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 05:00:38 -0500
X-Authenticated: #14349625
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
From: MIke Galbraith <efault@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Con Kolivas <kernel@kolivas.org>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       gcoady@gmail.com, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1139820181.3202.2.camel@mindpipe>
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com>
	 <200602131637.43335.kernel@kolivas.org> <1139810224.7935.9.camel@homer>
	 <200602131708.52342.kernel@kolivas.org>  <1139812538.7744.8.camel@homer>
	 <1139812725.2739.94.camel@mindpipe>  <1139814504.8124.6.camel@homer>
	 <1139820181.3202.2.camel@mindpipe>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 11:06:16 +0100
Message-Id: <1139825176.7499.11.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-13 at 03:43 -0500, Lee Revell wrote:
> On Mon, 2006-02-13 at 08:08 +0100, MIke Galbraith wrote:
> > On Mon, 2006-02-13 at 01:38 -0500, Lee Revell wrote:
> > > Do you know which of those changes fixes the "ls" problem?
> > 
> > No, it could be either, both, or neither.  Heck, it _could_ be a
> > combination of all of the things in my experimental tree for that
> > matter.  I put this patch out there because I know they're both bugs,
> > and strongly suspect it'll cure the worst of the interactivity related
> > delays.
> > 
> > I'm hoping you'll test it and confirm that it fixes yours.
> 
> Nope, this does not fix it.  "time ls" ping-pongs back and forth between
> ~0.1s and ~0.9s.  Must have been something else in the first patch.

Oh well. Thanks for testing Lee.  I was hoping this would be a case of
instant gratification, 2.6.16 being near, but it's not to be.

	-Mike

