Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbWBLTDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWBLTDl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 14:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWBLTDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 14:03:41 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:23777 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751409AbWBLTDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 14:03:41 -0500
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
From: Lee Revell <rlrevell@joe-job.com>
To: MIke Galbraith <efault@gmx.de>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Con Kolivas <kernel@kolivas.org>,
       gcoady@gmail.com, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1139752033.27408.20.camel@homer>
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com>
	 <200602081335.18256.kernel@kolivas.org>
	 <Pine.LNX.4.61.0602091806100.30108@yvahk01.tjqt.qr>
	 <1139515605.30058.94.camel@mindpipe>  <1139553319.8850.79.camel@homer>
	 <1139752033.27408.20.camel@homer>
Content-Type: text/plain
Date: Sun, 12 Feb 2006 14:03:35 -0500
Message-Id: <1139771016.19342.253.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-12 at 14:47 +0100, MIke Galbraith wrote:
> If you think it's the scheduler, how about try the patch below.  It's
> against 2.6.16-rc2-mm1, and should tell you if it is the interactivity
> logic in the scheduler or not.  I don't see other candidates in there,
> not that that means there aren't any of course. 

I'll try, but it's a serious pain for me to build an -mm kernel.  A
patch against 2.6.16-rc1 would be much easier.

Lee

