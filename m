Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266725AbUJLBCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266725AbUJLBCM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 21:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269414AbUJLBA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 21:00:28 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:36251 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269406AbUJLA70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 20:59:26 -0400
Subject: Re: [patch] VP-2.6.9-rc4-mm1-T5
From: Lee Revell <rlrevell@joe-job.com>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, Mark_H_Johnson@Raytheon.com,
       Andrew Morton <akpm@osdl.org>, Daniel Walker <dwalker@mvista.com>,
       "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20041012011447.3e7669f8@mango.fruits.de>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	 <20041011215909.GA20686@elte.hu> <20041012005754.1d49a074@mango.fruits.de>
	 <20041012011447.3e7669f8@mango.fruits.de>
Content-Type: text/plain
Message-Id: <1097542369.1453.113.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 11 Oct 2004 20:52:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-11 at 19:14, Florian Schmidt wrote:
> On Tue, 12 Oct 2004 00:57:54 +0200
> Florian Schmidt <mista.tapas@gmx.net> wrote:
> 
> > hi,
> > 
> > i still can't build it. Fist i reverse applied T4, then applied T5 and tried
> > a make bzImage. I'll try from scratch though to make sure, cause these
> > errors look identical to the T4 ones.
> > 
> 
> same errors.. Both with the preemptible real time thingy and without..
> 

Try building for SMP.  I suspect this is a UP build problem.

Lee

