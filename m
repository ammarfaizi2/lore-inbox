Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269467AbRHGVqv>; Tue, 7 Aug 2001 17:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269468AbRHGVql>; Tue, 7 Aug 2001 17:46:41 -0400
Received: from ip240.cvd2.rb1.bel.nwlink.com ([207.202.151.240]:22652 "EHLO
	zot.localdomain") by vger.kernel.org with ESMTP id <S269467AbRHGVq2>;
	Tue, 7 Aug 2001 17:46:28 -0400
To: Riley Williams <rhw@MemAlpha.CX>
To: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How does "alias ethX drivername" in modules.conf work?
In-Reply-To: <Pine.LNX.4.33.0108071925040.27407-100000@infradead.org>
From: Mark Atwood <mra@pobox.com>
Date: 07 Aug 2001 14:46:33 -0700
In-Reply-To: Riley Williams's message of "Tue, 7 Aug 2001 20:04:09 +0100 (BST)"
Message-ID: <m3g0b3v8zq.fsf@flash.localdomain>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Riley Williams <rhw@MemAlpha.CX> writes:
> 
>  > Described above.
> 
> What KERNEL problems then? I don't see any yet.

I smell the stench of finger pointing. It's a pity that it stinks jsut
as bad in the open source world as it is I am "privileged" when closed
source shops, or (even worse) telco/network folks start playing
"blameball".

Userspace init scripts point the finger at kernel, saying "there is no
good and no well documented mapping method". Kernel points its finger
at userspace, saying "this is the way we do it" and "we cant guarantee
a perfect 100% mapping solution, so we're not even going to try for
90%" and "futz with your drivers and modules.conf and init scripts
till you get something that works".

Fingers back and forth, fingers pointing all around

and those of us with lots of different interfaces, and
those of us with several hot-plug interfaces

What happens to us?

We get the finger.

-- 
Mark Atwood   | I'm wearing black only until I find something darker.
mra@pobox.com | http://www.pobox.com/~mra
