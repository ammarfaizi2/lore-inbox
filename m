Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265144AbUIDSHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUIDSHx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 14:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265230AbUIDSGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 14:06:22 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:10426 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265144AbUIDSFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 14:05:02 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q9
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark_H_Johnson@raytheon.com, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>
In-Reply-To: <1094316731.10586.35.camel@localhost.localdomain>
References: <OFACA329EE.63AC9924-ON86256F04.00556E19-86256F04.00556E29@raytheon.com>
	 <1094256256.6575.109.camel@krustophenia.net>
	 <1094316731.10586.35.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1094321108.6575.180.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 04 Sep 2004 14:05:08 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-04 at 12:52, Alan Cox wrote:
> On Sad, 2004-09-04 at 01:04, Lee Revell wrote:
> > This is looking more and more like a video driver problem:
> 
> Not really. The delay is too small and X is smarter than this. (except a
> VIA case that only recently got squished).
> 

True, the VIA problem did not cause long latency traces to appear on my
machine.  This is a weird one.

Lee




