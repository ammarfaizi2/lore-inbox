Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262652AbUJ0S7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbUJ0S7i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 14:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbUJ0S7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 14:59:05 -0400
Received: from web12202.mail.yahoo.com ([216.136.173.86]:21367 "HELO
	web12202.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262633AbUJ0S5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 14:57:18 -0400
Message-ID: <20041027185716.66965.qmail@web12202.mail.yahoo.com>
Date: Wed, 27 Oct 2004 20:57:16 +0200 (CEST)
From: karsten wiese <annabellesgarden@yahoo.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
To: Rui Nuno Capela <rncbc@rncbc.org>, Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>
In-Reply-To: <32865.192.168.1.5.1098898770.squirrel@192.168.1.5>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Rui Nuno Capela <rncbc@rncbc.org> schrieb: 
> Should I try the other way around? Lets see... 'chrt -p
> -f 90 `pidof
> ksoftirwd/0`',... yes, apparentely the xrun rate seems to
> decrease into
> half, but IMHO not conclusive enough, thought.
> 
'into half' makes me wonder:
did you also 'chrt -p -f 90 `pidof ksoftirwd/1`'?
I guess you meant that with '...'. Just in case :-)

Best,
Karsten


	

	
		
___________________________________________________________
Gesendet von Yahoo! Mail - Jetzt mit 100MB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
