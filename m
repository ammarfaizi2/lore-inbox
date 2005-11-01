Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbVKATrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbVKATrf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 14:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbVKATrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 14:47:35 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:31392 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751227AbVKATrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 14:47:35 -0500
Subject: Re: [BUG 2579] linux 2.6.* sound problems (SOLVED)
From: Lee Revell <rlrevell@joe-job.com>
To: patrizio.bassi@gmail.com
Cc: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>,
       "Kernel," <linux-kernel@vger.kernel.org>
In-Reply-To: <4367A369.5030003@gmail.com>
References: <53JVy-4yi-19@gated-at.bofh.it> <545a6-2GZ-17@gated-at.bofh.it>
	 <43679B8F.8000305@gmail.com> <43679FFB.6040504@mnsu.edu>
	 <4367A369.5030003@gmail.com>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 14:19:34 -0500
Message-Id: <1130872775.22089.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 18:18 +0100, Patrizio Bassi wrote:
> Jeffrey Hundstad ha scritto:
> 
> > Since you're going to 250 Hz.  Please, if you would, see if you can
> > tell any performance change and report that as well.  I'm more than a
> > little skeptical that you'll notice.  BTW: Your battery life should be
> > a little better at 100 Hz also.
> >
> sincerely i can notice that task and application switching is a bit slower.
> i have a 500mhz cpu so i think i can notice a bit the difference.
> i can't estimate it mmm...
> i'll say no more that 5-8%.
> but i don't know where i'm gaining speed..

Um, wasn't a consensus reached at OLS two years ago that the target for
desktop responsiveness would be 1ms which is impossible with HZ=100 or
250?

Lee

