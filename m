Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131052AbRCMOw0>; Tue, 13 Mar 2001 09:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131077AbRCMOwR>; Tue, 13 Mar 2001 09:52:17 -0500
Received: from jalon.able.es ([212.97.163.2]:13240 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131052AbRCMOwA>;
	Tue, 13 Mar 2001 09:52:00 -0500
Date: Tue, 13 Mar 2001 15:51:30 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Krzysztof Halasa <khc@intrepid.pm.waw.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make: *** [vmlinux] Error 1
Message-ID: <20010313155130.A7393@werewolf.able.es>
In-Reply-To: <20010311205408.A5102@wioggin.awwgeez> <20010312115302.A4210@werewolf.able.es> <m3hf0yn42w.fsf@intrepid.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <m3hf0yn42w.fsf@intrepid.pm.waw.pl>; from khc@intrepid.pm.waw.pl on Mon, Mar 12, 2001 at 21:07:51 +0100
X-Mailer: Balsa 1.1.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.12 Krzysztof Halasa wrote:
> "J . A . Magallon" <jamagallon@able.es> writes:
> 
> > If you are using pgcc, try getting a real less-buggy compiler, like
> egcs1.1.2
> > or gcc-2.95 (even 2.96 willl work).
> 
> ... not always. I've had problems with gcc "2.96" from RH-7.0
> - the compiler was generating obviously incorrect code in some cases
> (and it wasn't .c code fault but a compiler problem).

Yes, I should have said 'could', instead of 'will'. It works for me, but
perhaps I do not hit any of the code that is miscompiled.

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.2-ac19 #3 SMP Mon Mar 12 23:50:29 CET 2001 i686

