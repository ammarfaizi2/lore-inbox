Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129771AbRAFEuu>; Fri, 5 Jan 2001 23:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131117AbRAFEuk>; Fri, 5 Jan 2001 23:50:40 -0500
Received: from cd168990-a.ctjams1.mb.wave.home.com ([24.108.112.42]:3456 "EHLO
	cd168990-a.ctjams1.mb.wave.home.com") by vger.kernel.org with ESMTP
	id <S129771AbRAFEuV>; Fri, 5 Jan 2001 23:50:21 -0500
Date: Fri, 5 Jan 2001 22:50:20 -0600
From: Evan Thompson <evaner@bigfoot.com>
To: linux-kernel@vger.kernel.org
Subject: The advantage of modules?
Message-ID: <20010105225020.A1188@evaner.penguinpowered.com>
Reply-To: evaner@bigfoot.com
Mail-Followup-To: Evan Thompson <evaner@bigfoot.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to know (I know, I'm being slightly off topic, while still
staying on topic, so I'm on topic...er...yes) if there is any
advantage, be it memory-wise or architectuarally wise, to use modules?

I already know the obvious points of if you are creating a distro that
it is usually good to make a very modular kernel for those wishing not
to recompile their kernel, but I was wondering if there were any other
advantages to using modules vs. making a monolithic kernel for a
kernel to be used only on one machine (with no other hardware support
at all)?

Thanks, and sorry if I'm being slightly off topic...
Kernels are fun!  I wish I could learn more!
-- 
+----------------------------------+-----------------------------------+
| Evan Thompson                    |            POWERED BY:            |
| evaner@bigfoot.com               | Linux cd168990-a 2.4.0-ac2 #1 Fri |
| Freelance Computer Nerd          |  Jan 5 11:58:30 CST 2001 i686     |
| http://evaner.penguinpowered.com |   unknown                         |
+----------------------------------+-----------------------------------+
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
