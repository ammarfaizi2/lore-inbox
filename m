Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136210AbRDVQfi>; Sun, 22 Apr 2001 12:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136208AbRDVQf3>; Sun, 22 Apr 2001 12:35:29 -0400
Received: from viper.haque.net ([66.88.179.82]:39562 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S136207AbRDVQfW>;
	Sun, 22 Apr 2001 12:35:22 -0400
Message-ID: <3AE30708.6DF72C1D@haque.net>
Date: Sun, 22 Apr 2001 12:30:00 -0400
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jes Sorensen <jes@linuxcare.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Russell King <rmk@arm.linux.org.uk>,
        Philip Blundell <philb@gnu.org>, junio@siamese.dhis.twinsun.com,
        Manuel McLure <manuel@mclure.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac12
In-Reply-To: <E14rJw2-0005r5-00@the-village.bc.nu> <d366fw29sv.fsf@lxplus015.cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In case everyone missed my original patch =P

http://marc.theaimsgroup.com/?l=linux-kernel&m=98791931115515&w=2


Jes Sorensen wrote:
> 
> >>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> Alan> The recommended compilers for non x86 are different too - eg you
> Alan> need 2.96 gcc for IA64, you need 2.95 not egcs for mips and so
> Alan> on.
> 
> In principle you just need 2.7.2.3 for m68k, but someone decided to
> raise the bar for all architectures by putting a check in a common
> header file.
> 
> Maybe it's time to move that check to the arch include dir instead?
> 
> Jes
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
