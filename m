Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266084AbRF1SNp>; Thu, 28 Jun 2001 14:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266082AbRF1SNg>; Thu, 28 Jun 2001 14:13:36 -0400
Received: from t2.redhat.com ([199.183.24.243]:22002 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S266079AbRF1SNX>; Thu, 28 Jun 2001 14:13:23 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.33.0106281055410.15199-100000@penguin.transmeta.com> 
In-Reply-To: <Pine.LNX.4.33.0106281055410.15199-100000@penguin.transmeta.com> 
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, chuckw@altaserv.net,
        Vipin Malik <vipin.malik@daniel.com>,
        Aaron Lehmann <aaronl@vitelus.com>, jffs-dev@axis.com,
        linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Jun 2001 19:13:08 +0100
Message-ID: <11977.993751988@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


torvalds@transmeta.com said:
>  I consider them harmful when I start getting annoying patches that
> start adding more and more of them.

> Which is how this whole thread started. 

Sort of. The point of the patch which started this thread was as a wake-up
call to a company who had taken the code, renamed it to appear as their own,
commented out the version and copyright printk, and shipped it to their
customers in an RPM which claimed it was proprietary code.

That wake-up call served its primary purpose quite effectively.

The new line was added simply to ensure that if such a thing happens again,
the newly-named copyright holder will be in a position to do something about
it.

Take them all out if you must. I stand by my prediction.

--
dwmw2


