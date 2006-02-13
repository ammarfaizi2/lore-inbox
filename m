Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751626AbWBMFFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbWBMFFr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 00:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbWBMFFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 00:05:47 -0500
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:46506 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751625AbWBMFFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 00:05:47 -0500
From: Con Kolivas <kernel@kolivas.org>
To: MIke Galbraith <efault@gmx.de>
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
Date: Mon, 13 Feb 2006 16:05:16 +1100
User-Agent: KMail/1.9.1
Cc: Lee Revell <rlrevell@joe-job.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, gcoady@gmail.com,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com> <1139801975.2739.72.camel@mindpipe> <1139806761.25253.33.camel@homer>
In-Reply-To: <1139806761.25253.33.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602131605.17198.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 February 2006 15:59, MIke Galbraith wrote:
> Now, let's see if we can get your problem fixed with something that can
> possibly go into 2.6.16 as a bugfix.  Can you please try the below?

These sorts of changes definitely need to pass through -mm first... and don't 
forget -mm looks quite different to mainline.

Cheers,
Con

