Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284516AbRLEVx6>; Wed, 5 Dec 2001 16:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284451AbRLEVxp>; Wed, 5 Dec 2001 16:53:45 -0500
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:35846 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S284439AbRLEVwt>; Wed, 5 Dec 2001 16:52:49 -0500
Date: Tue, 4 Dec 2001 23:22:41 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@zip.com.au>, Davide Libenzi <davidel@xmailserver.org>,
        Larry McVoy <lm@bitmover.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
Message-ID: <20011204232240.A117@elf.ucw.cz>
In-Reply-To: <3C082FEB.98D8BE9B@zip.com.au> <E16A71v-0006h9-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16A71v-0006h9-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Another thing for 2.5 is going to be to weed out the unused and unmaintained
> drivers, and either someone fixes them or they go down the comsic toilet and
> we pull the flush handle before 2.6 comes out.

Hey, I still have 8-bit isa scsi card somewhere.... Last time I fixed
that was just before 2.4 because that was when I got it... Don't flush
drivers too fast, please... If you kill drivers during 2.5, people
will not notice, and even interesting drivers will get killed. Killing
them during 2.6.2 might be better.
								Pavel
-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
