Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUJNNSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUJNNSA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 09:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbUJNNR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 09:17:59 -0400
Received: from pop.gmx.de ([213.165.64.20]:21452 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263818AbUJNNR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 09:17:58 -0400
X-Authenticated: #4399952
Date: Thu, 14 Oct 2004 15:33:26 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
Message-ID: <20041014153326.4f601eba@mango.fruits.de>
In-Reply-To: <20041014134250.3139153b@mango.fruits.de>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	<20041011215909.GA20686@elte.hu>
	<20041012091501.GA18562@elte.hu>
	<20041012123318.GA2102@elte.hu>
	<20041012195424.GA3961@elte.hu>
	<20041013061518.GA1083@elte.hu>
	<20041014002433.GA19399@elte.hu>
	<20041014105711.654efc56@mango.fruits.de>
	<20041014091953.GA21635@elte.hu>
	<20041014120007.01c26760@mango.fruits.de>
	<15261.195.245.190.94.1097749350.squirrel@195.245.190.94>
	<20041014124845.5daecec2@mango.fruits.de>
	<416E5AF6.8080802@cybsft.com>
	<20041014131604.106496fe@mango.fruits.de>
	<20041014134250.3139153b@mango.fruits.de>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004 13:42:50 +0200
Florian Schmidt <mista.tapas@gmx.net> wrote:

> > nah, this worked very well for all other versions of the VP patches. right
> > now i'm building U0 w/o PREEMPT_REALTIME, to see if i still get the
> > exception.
> > 
> 
> jackd seems to work fine w/o PREEMPT_REALTIME (otherwise identical config).

err, sorry, shouldn't have cc'ed to jackit-devel as it's subscribers only.
sorry for that.. Ah, there's nothing better than making a complete ass out
of oneself :)

flo
