Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279475AbRJ2Ujc>; Mon, 29 Oct 2001 15:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279481AbRJ2UjY>; Mon, 29 Oct 2001 15:39:24 -0500
Received: from freeside.toyota.com ([63.87.74.7]:46857 "EHLO toyota.com")
	by vger.kernel.org with ESMTP id <S279475AbRJ2UjI>;
	Mon, 29 Oct 2001 15:39:08 -0500
Message-ID: <3BDDBE89.397E42C0@lexus.com>
Date: Mon, 29 Oct 2001 12:39:37 -0800
From: J Sloan <jjs@lexus.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nasty suprise with uptime
In-Reply-To: <E15yJD1-0003uO-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > and received a nasty surprise. The uptime, which had been 496+ days
> > on Friday, was back down to a few hours. I was ready to lart somebody
> > with great vigor when I realized the uptime counter had simply wrapped
> > around.
> >
> > So, I thought to myself, at least the 2.4 kernels on our new boxes won't
>
> It wraps at 496 days. The drivers are aware of it and dont crash the box

Yes, and these boxes are still running fine - other
than showing some processes that were started
in the year 2003... but DAMN, what an eyesore -
uptime ruined as far as anybody can tell, times
and dates no longer making any sense.

So, is there an implicit Linux policy to upgrade
the distro, or at least the kernel, every 496 days
whether it needs it or not?

;-)

cu

jjs

