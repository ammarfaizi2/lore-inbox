Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286218AbRLTMLs>; Thu, 20 Dec 2001 07:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286219AbRLTMLm>; Thu, 20 Dec 2001 07:11:42 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:9366 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S286217AbRLTMLV>;
	Thu, 20 Dec 2001 07:11:21 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: bug/problem  on 2.4.16 ???
In-Reply-To: <F187Z1i6bdVJWrGW6Ex00007bcf@hotmail.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 19 Dec 2001 22:42:57 +0100
In-Reply-To: <F187Z1i6bdVJWrGW6Ex00007bcf@hotmail.com>
Message-ID: <m3heqmzy1q.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Andre Couture" <nomade1999@hotmail.com> writes:

> kernel 2.4.16 SMP PIII Katmai
> 
> the system is installed from mandrake 8.1 CD's.
> 
> then I've installed and recompile a new kernel.
> 
> i've attached the .config (just in case)
> 
> see below for more info
> 
> Any help would be appreciated, in the mean while i will recompile the
> kswapd and ipopd3

No point in recompiling ipop3d, and kswapd is a part of the kernel.
It's clearly kernel bug, and should be fixed just there.
I'd try 2.4.17-rc2 or later.
-- 
Krzysztof Halasa
Network Administrator
