Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274150AbRISTvP>; Wed, 19 Sep 2001 15:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274151AbRISTvG>; Wed, 19 Sep 2001 15:51:06 -0400
Received: from anime.net ([63.172.78.150]:46606 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S274150AbRISTu6>;
	Wed, 19 Sep 2001 15:50:58 -0400
Date: Wed, 19 Sep 2001 12:51:07 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <20010919152121.A9952@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.30.0109191249130.26700-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001, Arjan van de Ven wrote:
> If it were only 5%, I would vote for disabling the optimisation given the
> number of problems; however it's 2x _and_ you can trigger the bug as normal
> user from userspace too... so we need to fix the hardware/bios.

But we really dont know what the hell that bit is doing. It might trigger
some other obscure bugs and make things a real mess.

Until we get some answer from VIA its IMHO a bad idea to start twiddling
this bit willy-nilly on all machines.

-Dan

-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

