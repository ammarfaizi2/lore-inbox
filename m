Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281863AbRK2THP>; Thu, 29 Nov 2001 14:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280883AbRK2THG>; Thu, 29 Nov 2001 14:07:06 -0500
Received: from zeus.kernel.org ([204.152.189.113]:20466 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S277380AbRK2TG4>;
	Thu, 29 Nov 2001 14:06:56 -0500
Date: Thu, 29 Nov 2001 11:05:41 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: randall@uph.com, Balbir Singh <balbir_soni@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Patch: Fix serial module use count (2.4.16 _and_ 2.5)
In-Reply-To: <20011129181227.I6214@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10111291103400.2693-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It's not only serial drivers, its everything that is a tty driver.
> I believe that auditing and fixing that lot in 2.4 just isn't going
> to happen - it's supposed to be a stable kernel after all.

Yeap. I'm working on a rewrite of the tty layer. Yesterday alone I found a
nasty flaw with the lpr console. So it will be reworked for 2.5.X.

Is their going to be a mailing for serial developement. I have lots of
ideas and a few issues to work out.


