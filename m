Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272670AbRILEct>; Wed, 12 Sep 2001 00:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272671AbRILEcj>; Wed, 12 Sep 2001 00:32:39 -0400
Received: from www.stolica.ru ([62.118.250.25]:15772 "HELO stolica.ru")
	by vger.kernel.org with SMTP id <S272670AbRILEcg>;
	Wed, 12 Sep 2001 00:32:36 -0400
Date: Wed, 12 Sep 2001 08:29:35 +0400
From: Dmitry Volkoff <vdb@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: [GOLDMINE!!!] Athlon optimisation bug (was Re: Duron kernel crash)
Message-ID: <20010912082935.A391@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I don't have any problems with the kernel, but if I'm compiling (say) the
>kernel or any large program, user-mode apps like gcc, make, etc all
>randomly segfault on me.
>
>I'm running a Duron 800 on a Asus A7V133 mobo - and no bios version I've
>tried has made a bit of difference yet :p

Same things here. I'm also experiencing random segfaults with kernels 
2.4.10pre[47]. My motherbord is Chaintech CT-7AIA2 (kt133A/686A), Duron 600.
I did'nt see such things with kernels 2.4.[78]. The problem persists even 
after recompiling kernel with K6-III optimisation. Note, this motherboard
was rock solid and I never had any problems with athlon-optimised kernels
prior to 2.4.9.

-- 

    DV
