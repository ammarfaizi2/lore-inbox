Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAJUeG>; Wed, 10 Jan 2001 15:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbRAJUd5>; Wed, 10 Jan 2001 15:33:57 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:51721 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S129431AbRAJUdm>;
	Wed, 10 Jan 2001 15:33:42 -0500
Date: Wed, 10 Jan 2001 21:34:09 +0100 (CET)
From: <kernel@ddx.a2000.nu>
To: <linux-kernel@vger.kernel.org>
Subject: unexplained high load
Message-ID: <Pine.LNX.4.30.0101102131520.4304-100000@ddx.a2000.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could someone maybe explain this ?
(top output, but same load is given with 'uptime')
there is no cpu or disk activity
kernel is 2.2.18pre9 on sun ultra10-300 (ultrasparc IIi)

   9:25pm  up 112 days,  1:52,  1 user,  load average: 1.24, 1.05, 1.02
 91 processes: 90 sleeping, 1 running, 0 zombie, 0 stopped
 CPU states:  2.5% user,  2.3% system,  0.0% nice, 95.1% idle
 Mem:  515144K av, 506752K used,   8392K free,  73464K shrd,  58472K buff
 Swap: 131528K av,  15968K used, 115560K free                358904K cached



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
