Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932762AbVHTSwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932762AbVHTSwq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 14:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932781AbVHTSwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 14:52:45 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:4510 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932762AbVHTSwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 14:52:45 -0400
Subject: Re: Schedulers benchmark - Was: [ANNOUNCE][RFC] PlugSched-5.2.4
	for 2.6.12 and 2.6.13-rc6
From: Lee Revell <rlrevell@joe-job.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200508201031.59981.kernel@kolivas.org>
References: <43001E18.8020707@bigpond.net.au>
	 <200508191436.42881.kernel@kolivas.org>
	 <1124482411.25424.49.camel@mindpipe>
	 <200508201031.59981.kernel@kolivas.org>
Content-Type: text/plain
Date: Sat, 20 Aug 2005 14:52:40 -0400
Message-Id: <1124563960.26949.33.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-20 at 10:31 +1000, Con Kolivas wrote:
> It's an X problem and it's being fixed. Get over it, we're not tuning
> the scheduler for a broken app.
> 

You're right, this problem seems much, much better in Xorg 6.8.2.  I
think the Damage extension might be responsible.  There's definitely
something different happening because when I switch windows quickly,
instead of a grey box that gets slowly re-packed with widgets, I see a
black box that packs very fast, and seems to be filled in large
rectangular chunks rather than one widget at a time.  X is also using a
lot less CPU.  Very nice work...

Lee

