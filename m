Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264329AbRGELJn>; Thu, 5 Jul 2001 07:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264345AbRGELJd>; Thu, 5 Jul 2001 07:09:33 -0400
Received: from [203.126.57.231] ([203.126.57.231]:28424 "HELO
	mail.celestix.com") by vger.kernel.org with SMTP id <S264329AbRGELJS>;
	Thu, 5 Jul 2001 07:09:18 -0400
Date: Thu, 5 Jul 2001 18:52:43 +0800
From: Thibaut Laurent <thibaut@celestix.com>
To: Mircea Damian <dmircea@kappa.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
Message-Id: <20010705185243.2e3a942e.thibaut@celestix.com>
In-Reply-To: <20010705104650.A2820@linux.kappa.ro>
In-Reply-To: <20010704232816.B590@marvin.mahowi.de>
	<20010705104650.A2820@linux.kappa.ro>
Organization: Celestix Networks Pte Ltd
X-Mailer: Sylpheed version 0.4.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I posted a message 2 weeks ago regarding this bug, though I can't trigger the
kernel panic every time (see original post). My CPU is a MediaGX, and
Manfred's one is a 6x86MX. What about yours ?
After my first unsuccessful attempt with a 2.4.6-pre3, I tried several other
2.4.6-preX and 2.4.5-acX kernels. All 2.4.6 (since pre1) seem to be
affected, and so do the latest ac's. I don't have tested 2.4.7-pre[12] yet,
but looking at the changelog, I doubt the fix is in.

Original post for the behaviour on my box:
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0106.2/0778.html
Note: the kernel panic mentioned in the original post is the same "kernel BUG
at softirq.c:206!" thing.

Regards,

Thibaut

