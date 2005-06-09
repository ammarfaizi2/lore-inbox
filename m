Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbVFICmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbVFICmy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 22:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbVFICmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 22:42:54 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:20447 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S262242AbVFICmw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 22:42:52 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH 3/4] new timeofday x86-64 arch specific changes (v. B1)
Date: Wed, 8 Jun 2005 22:42:52 -0400
User-Agent: KMail/1.8
Cc: Lee Revell <rlrevell@joe-job.com>, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>
References: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net> <1118281635.6247.42.camel@mindpipe> <1118283133.5754.41.camel@cog.beaverton.ibm.com>
In-Reply-To: <1118283133.5754.41.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200506082242.52692.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>On Wednesday 08 June 2005 21:47, Lee Revell wrote:
> > Also try 2.6.11 with ALSA 1.0.9, maybe it's an interaction between ALSA
> > and the new gettimeofday patches.

I am using 2.6.11 and ALSA 1.0.8 - no problem there. Will try with -rc5 and 
ALSA 1.0.9 to see if that makes any difference.

>On Wednesday 08 June 2005 22:12, john stultz wrote:
>
> Wahzuntme! :):)  Well, I'd be very interested if my patches were to blame,
> but I believe Parag said it happened with or without my patches.

You are right - it happens regardless of whether TOD patches are applied or 
not - So you are free to work upon a super fast TOD while we work upon the 
super fast music! :)

Parag
