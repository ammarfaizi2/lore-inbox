Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129054AbQJaJfS>; Tue, 31 Oct 2000 04:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129856AbQJaJfI>; Tue, 31 Oct 2000 04:35:08 -0500
Received: from [195.63.194.11] ([195.63.194.11]:9747 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S129054AbQJaJer>;
	Tue, 31 Oct 2000 04:34:47 -0500
Message-ID: <39FE9E9F.4375C8D1@evision-ventures.com>
Date: Tue, 31 Oct 2000 11:27:43 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Peter Samuelson <peter@cadcamlab.org>,
        Linux Kernel Developer <linux_developer@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Recommended compiler? - Re: [patch] kernel/module.c (plus gratuitous 
 rant)
In-Reply-To: <200010302050.e9UKo7312002@pincoya.inf.utfsm.cl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> 
> Martin Dalecki <dalecki@evision-ventures.com> said:
> > Peter Samuelson wrote:
> 
> [...]
> 
> > > * Red Hat "2.96" or CVS 2.97 will probably break any known kernel.
> 
> > Works fine for me and 2.4.0-test10-pre5... however there are tons of
> > preprocessor warnings in some drivers.
> 
> CVS (from 20001028 or so) gave a 2.4.0.10.6/i686 that crashed on boot, no
> time to dig deeper yet.

I was just using the compiler shipped by RedHat with all the fixes
contained
therein.... self compiled under glibc-2.1.95 on a system which some long
time
ago was RedHat-5.1 ;-). And it worked.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
