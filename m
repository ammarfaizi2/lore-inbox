Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317898AbSFSOxb>; Wed, 19 Jun 2002 10:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317899AbSFSOxa>; Wed, 19 Jun 2002 10:53:30 -0400
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:4641 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S317898AbSFSOx3>; Wed, 19 Jun 2002 10:53:29 -0400
Message-ID: <61DB42B180EAB34E9D28346C11535A783A79A2@nocmail101.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'o.pitzeier@uptime.at'" <o.pitzeier@uptime.at>,
       linux-kernel@vger.kernel.org
Subject: RE: New Build problem in sched.c in 2.5.23 on an Alpha
Date: Wed, 19 Jun 2002 09:53:18 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> sched.c: In function `schedule':
> sched.c:822: warning: implicit declaration of function
> `prepare_arch_schedule'
> sched.c:879: warning: implicit declaration of function
> `prepare_arch_switch'
> sched.c:883: warning: implicit declaration of function
> `finish_arch_switch'
> sched.c:886: warning: implicit declaration of function
> `finish_arch_schedule'
> make[1]: *** [sched.o] Error 1
> make[1]: Leaving directory `/usr/src/linux-2.5.23/kernel'
> make: *** [kernel] Error 2

What Arch are you on?  Alpha?

Search the archive, you'll see that some of these are from Ingo's scheduler
changes.

B.
