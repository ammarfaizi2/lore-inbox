Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276261AbRI1Tm7>; Fri, 28 Sep 2001 15:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276263AbRI1Tmt>; Fri, 28 Sep 2001 15:42:49 -0400
Received: from relay-1v.club-internet.fr ([194.158.96.112]:17033 "HELO
	relay-1v.club-internet.fr") by vger.kernel.org with SMTP
	id <S276261AbRI1Tme>; Fri, 28 Sep 2001 15:42:34 -0400
Message-ID: <3BB4D327.61902593@club-internet.fr>
Date: Fri, 28 Sep 2001 21:44:39 +0200
From: Daniel Caujolle-Bert <segfault@club-internet.fr>
Reply-To: segfault@club-internet.fr
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Binary only module overview
In-Reply-To: <E15myqL-0007E8-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > That I would call an obvious GPL violation... no discussion
> > about vague "interfaces", if you directly link serial.c
> > (even modified) into a non-GPL .o file that's obvious....
> 
> I raised this one with Ted T'so (who wrote the serial.c they use) a long
> time ago. Ted seemed happy for this to occur - and its kind of his code,
> his business.

	I don't understand you here, sorry, complicated sentence are
hard for me :<. Anyway, i am one of the one who hacked and old version
of this driver for 2.4.7+, of course i can understand it's a GPL
violation,
but like another guy wrote (sorry, i haven't his name liying around),
binary only module is *almost* better than no support.
	
Cheers.
-- 
73's de Daniel, F1RMB.

              -=- Daniel Caujolle-Bert -=- segfault@club-internet.fr -=-
                        -=- f1rmb@f1rmb.ampr.org (AMPR NET) -=-
