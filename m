Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281464AbRKHFBr>; Thu, 8 Nov 2001 00:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281469AbRKHFB1>; Thu, 8 Nov 2001 00:01:27 -0500
Received: from mx10.port.ru ([194.67.57.20]:10423 "EHLO mx10.port.ru")
	by vger.kernel.org with ESMTP id <S281464AbRKHFBX>;
	Thu, 8 Nov 2001 00:01:23 -0500
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200111080502.fA852im17980@vegae.deep.net>
Subject: Re: Laptop harddisk spindown?
To: kubla@sciobyte.de (Dominik Kubla)
Date: Thu, 8 Nov 2001 08:02:38 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011108002154.D7288@duron.intern.kubla.de> from "Dominik Kubla" at Nov 08, 2001 12:21:54 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"  Dominik Kubla wrote:"
> 
> On Thu, Nov 08, 2001 at 01:51:05AM +0300, Samium Gromoff wrote:
> >      I`m sorry folks, i dont quite recall whether i poked lkml with that,
> >   but here it is:
> > 	2.4.13, reiserfs
> > 	i have a disk access _every_ 5 sec, unregarding the system load, 
> >     24x7x365, so i suppose while it doesnt hurts me, it hurts folks with power
> >     bound boxes...
> >         I must add that i `m experiencing this on -ac tree too, adn this is true
> >     as far as my memory goes... (in the kernel-version context i mean)
> > 
> > cheers, Samium Gromoff
> 
> That's a FAQ: you have cron running...
   hehe...
   i`ve actually compiled cron only a week ago, so its not an issue ;)
   (i havent had cron before on my homemmade linux)

   i mean i`m not this lame, and i told *no_system_load*... :-)
> 
> Dominik
> -- 
> ScioByte GmbH    Zum Schiersteiner Grund 2     55127 Mainz (Germany)
> Phone: +49 700 724 629 83                    Fax: +49 700 724 629 84
> 
> GnuPG: 717F16BB / A384 F5F1 F566 5716 5485  27EF 3B00 C007 717F 16BB
> 
cheers, Samium Gromoff
