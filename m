Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129847AbRAQX0c>; Wed, 17 Jan 2001 18:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131503AbRAQX0W>; Wed, 17 Jan 2001 18:26:22 -0500
Received: from jalon.able.es ([212.97.163.2]:8914 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129847AbRAQX0D>;
	Wed, 17 Jan 2001 18:26:03 -0500
Date: Thu, 18 Jan 2001 00:25:51 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Joel Franco Guzmán <joel@gds-corp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 128M memory OK, but with 192M sound card es1391 trouble
Message-ID: <20010118002551.C883@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.30.0101172037310.1309-100000@thor.gds-corp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.30.0101172037310.1309-100000@thor.gds-corp.com>; from joel@gds-corp.com on Thu, Jan 18, 2001 at 00:11:36 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.01.18 Joel Franco Guzmán wrote:
> 1. 128M memory OK, but with 192M the sound card generate a noise while
> use the DSP.
.. 
> the problem: The sound card generates a toc.. toc.. toc .. toc...while
> playing a sound using the DSP of the soundcard. Two "tocs"/sec
> aproxiumadetely.
> 
> 
> Linux thor.gds-corp.com 2.4.1-pre8 #2 Wed Jan 17 19:44:31 BRST 2001
> i686 unknownKernel modules         2.3.21

Don't know if it is related, but you should upgrade your modutils up to
2.4, even 2.4.1 is yet available.

I have noticed something similar. If I start gqmpeg from the command line in
a terminal (rxvt), sounds fine. If I start it from the icon in the gnome
panel, it makes that 'toc toc' noise you describe. ????
(I know it sounds strange, but real...)

How do you launch your sound test ? (btw, which do you use to play sound ?) 

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.0-ac9 #2 SMP Sun Jan 14 01:46:07 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
