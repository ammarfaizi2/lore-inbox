Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292583AbSCFAyY>; Tue, 5 Mar 2002 19:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292593AbSCFAyP>; Tue, 5 Mar 2002 19:54:15 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30731 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292583AbSCFAyA>; Tue, 5 Mar 2002 19:54:00 -0500
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in the tree
To: davidsen@tmr.com (Bill Davidsen)
Date: Wed, 6 Mar 2002 01:05:55 +0000 (GMT)
Cc: dart@windeath.2y.net (dart), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1020305162547.28458B-100000@gatekeeper.tmr.com> from "Bill Davidsen" at Mar 05, 2002 04:49:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16iPsR-00052J-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   I won't bring it up again, I'd love to think Rik, Alan and Ingo will
> keep working on performance patches for 2.4, but I wouldn't bet on it.

I certainly will work on collating them - over time it will get less and
less of a win. A lot of the now very visible ones are really hard to fix in 2.4 
and will be 2.5 things (like block). And when you fix block you'll find the
next one and so on forever

> done in -pre2, might be worth a try. I'm going to build pre2-ac2 and mjc
> for some laptop benchmarks, I'll turn on ZIP support and try my old unit
> (the original protocol). I'll try to report back on that in the next day
> or so.

Im running both 2.4.18/19pre2 on laptops. PLIP still doesnt work but at
least I think I now understand why. If you want to hack on plip ping
Tim Waugh <twaugh@redhat.com> he's definitely as far from the Al Viro end
of polite computing as you can get and can probably tell you what bits you
need to tweak
