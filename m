Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWBMHCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWBMHCu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 02:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWBMHCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 02:02:50 -0500
Received: from mail.gmx.net ([213.165.64.21]:1177 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751178AbWBMHCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 02:02:49 -0500
X-Authenticated: #14349625
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
From: MIke Galbraith <efault@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Con Kolivas <kernel@kolivas.org>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       gcoady@gmail.com, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1139812725.2739.94.camel@mindpipe>
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com>
	 <200602131637.43335.kernel@kolivas.org> <1139810224.7935.9.camel@homer>
	 <200602131708.52342.kernel@kolivas.org>  <1139812538.7744.8.camel@homer>
	 <1139812725.2739.94.camel@mindpipe>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 08:08:24 +0100
Message-Id: <1139814504.8124.6.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-13 at 01:38 -0500, Lee Revell wrote:
> Do you know which of those changes fixes the "ls" problem?

No, it could be either, both, or neither.  Heck, it _could_ be a
combination of all of the things in my experimental tree for that
matter.  I put this patch out there because I know they're both bugs,
and strongly suspect it'll cure the worst of the interactivity related
delays.

I'm hoping you'll test it and confirm that it fixes yours.

	-Mike

