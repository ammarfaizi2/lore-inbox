Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274152AbRIST7g>; Wed, 19 Sep 2001 15:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274154AbRIST7Z>; Wed, 19 Sep 2001 15:59:25 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:22282 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S274152AbRIST7M>; Wed, 19 Sep 2001 15:59:12 -0400
Date: Wed, 19 Sep 2001 15:59:34 -0400
From: Arjan van de Ven <arjanv@redhat.com>
To: Dan Hollis <goemon@anime.net>
Cc: Arjan van de Ven <arjanv@redhat.com>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
Message-ID: <20010919155934.C17174@devserv.devel.redhat.com>
In-Reply-To: <20010919152121.A9952@devserv.devel.redhat.com> <Pine.LNX.4.30.0109191249130.26700-100000@anime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0109191249130.26700-100000@anime.net>; from goemon@anime.net on Wed, Sep 19, 2001 at 12:51:07PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 12:51:07PM -0700, Dan Hollis wrote:
> On Wed, 19 Sep 2001, Arjan van de Ven wrote:
> > If it were only 5%, I would vote for disabling the optimisation given the
> > number of problems; however it's 2x _and_ you can trigger the bug as normal
> > user from userspace too... so we need to fix the hardware/bios.
> 
> But we really dont know what the hell that bit is doing. It might trigger
> some other obscure bugs and make things a real mess.
> 
> Until we get some answer from VIA its IMHO a bad idea to start twiddling
> this bit willy-nilly on all machines.

no argument from me there...
