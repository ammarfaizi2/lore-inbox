Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132133AbRAFFcM>; Sat, 6 Jan 2001 00:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132881AbRAFFcC>; Sat, 6 Jan 2001 00:32:02 -0500
Received: from adsl-216-102-91-127.dsl.snfc21.pacbell.net ([216.102.91.127]:57846
	"EHLO champ.drew.net") by vger.kernel.org with ESMTP
	id <S132133AbRAFFbs>; Sat, 6 Jan 2001 00:31:48 -0500
From: Drew Bertola <drew@drewb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14934.44472.612519.658729@champ.drew.net>
Date: Sat, 6 Jan 2001 05:31:36 +0000 ()
To: evaner@bigfoot.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: The advantage of modules?
In-Reply-To: <20010105225020.A1188@evaner.penguinpowered.com>
In-Reply-To: <20010105225020.A1188@evaner.penguinpowered.com>
X-Mailer: VM 6.75 under Emacs 19.34.1
Reply-To: drew@drewb.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My best reasons are...

Development: You don't have to recompile the kernel a billion times
while working on a driver, you just recompile the module.  Also, you
can debug, unload, fix, recompile, reload a module to add or fix
pieces of it all (hopefully) without rebooting.

Practical usage: When I take my laptop on the road I use ppp, so I
load it then.  Most of the time I don't need it, so I don't load it.

Evan Thompson writes:
> I'd like to know (I know, I'm being slightly off topic, while still
> staying on topic, so I'm on topic...er...yes) if there is any
> advantage, be it memory-wise or architectuarally wise, to use modules?
> 
> I already know the obvious points of if you are creating a distro that
> it is usually good to make a very modular kernel for those wishing not
> to recompile their kernel, but I was wondering if there were any other
> advantages to using modules vs. making a monolithic kernel for a
> kernel to be used only on one machine (with no other hardware support
> at all)?
> 
> Thanks, and sorry if I'm being slightly off topic...
> Kernels are fun!  I wish I could learn more!
> -- 
> +----------------------------------+-----------------------------------+
> | Evan Thompson                    |            POWERED BY:            |
> | evaner@bigfoot.com               | Linux cd168990-a 2.4.0-ac2 #1 Fri |
> | Freelance Computer Nerd          |  Jan 5 11:58:30 CST 2001 i686     |
> | http://evaner.penguinpowered.com |   unknown                         |
> +----------------------------------+-----------------------------------+
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
Drew Bertola  | Send a text message to my pager or cell ... 
              |   http://jpager.com/Drew

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
