Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129412AbRAaWZt>; Wed, 31 Jan 2001 17:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129411AbRAaWZk>; Wed, 31 Jan 2001 17:25:40 -0500
Received: from jalon.able.es ([212.97.163.2]:5765 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129386AbRAaWZ1>;
	Wed, 31 Jan 2001 17:25:27 -0500
Date: Wed, 31 Jan 2001 23:25:16 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Igor Mozetic <igor.mozetic@uni-mb.si>
Cc: linux-kernel@vger.kernel.org
Subject: Re: possible bug with adaptec aic-7896 and 2.4.x
Message-ID: <20010131232516.A10959@werewolf.able.es>
In-Reply-To: <14968.33568.482353.888533@cmb1-3.dial-up.arnes.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <14968.33568.482353.888533@cmb1-3.dial-up.arnes.si>; from igor.mozetic@uni-mb.si on Wed, Jan 31, 2001 at 22:26:56 +0100
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.31 Igor Mozetic wrote:
> Andrew Prins writes:
> > in 2.4.0 and 2.4.1 on a pentium 3 with an onboard adaptec AIC-7896, i 
> > receive the following after it is detected:
> > 
> > scsi: aborting command due to timeout: pid 0, scsi0, channel 0, id 0
> > lun 0 Inquiry 00 00 00 ff 00
> 
> I my case machine doesn't even boot.
> You might try the aic7xxx driver at:
> http://people.FreeBSD.org/~gibbs/linux/
> 
> I tried the 6.0.9BETA version and machine at least booted,
> but crashed in a couple of days. So I'm back to 2.2.18 :(
> 

Do not know if it has been announced, but reading your mail I took a look
at freebsd and there is new version there: 6.1.0, from Jan28.
I have been using 6.0.9b on 2.4.1 and works fine.

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-zcn #1 SMP Tue Jan 30 11:38:19 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
