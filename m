Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271701AbTGXPvy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 11:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271703AbTGXPvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 11:51:54 -0400
Received: from routeree.utt.ro ([193.226.8.102]:55218 "EHLO klesk.etc.utt.ro")
	by vger.kernel.org with ESMTP id S271701AbTGXPvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 11:51:49 -0400
Message-ID: <5783.194.138.39.55.1059063130.squirrel@webmail.etc.utt.ro>
Date: Thu, 24 Jul 2003 19:12:10 +0300 (EEST)
Subject: Re: [PATCH] O8int for interactivity
From: "Szonyi Calin" <sony@etc.utt.ro>
To: <felipe_alfaro@linuxmail.org>
In-Reply-To: <1058978784.740.4.camel@teapot.felipe-alfaro.com>
References: <200307232155.27107.kernel@kolivas.org>
        <1058978784.740.4.camel@teapot.felipe-alfaro.com>
X-Priority: 3
Importance: Normal
Cc: <kernel@kolivas.org>, <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Felipe Alfaro Solana said:
>
> I'm playing a bit with tunables to see if I can tune the scheduler a
> little bit for my system/workload. I've had good results reducing max
> timeslice to 100 (yeah, I know I shouldn't do this too).
>
> Will keep you informed :-)
>

same thing here. Reducing max timeslice to 100 is much better.
It's the only thing that allow me to watch a movie while compiling
the kernel with make -j 2 bzImage on my Duron 700Mhz with 256M RAM

I have to find some docs about those tunables.

Thanks
Bye
Calin



-----------------------------------------
This email was sent using SquirrelMail.
   "Webmail for nuts!"
http://squirrelmail.org/


