Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278603AbRJXQ2R>; Wed, 24 Oct 2001 12:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278625AbRJXQ2H>; Wed, 24 Oct 2001 12:28:07 -0400
Received: from viper.haque.net ([66.88.179.82]:21121 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S278603AbRJXQ1q>;
	Wed, 24 Oct 2001 12:27:46 -0400
Date: Wed, 24 Oct 2001 12:28:05 -0400 (EDT)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Tim Tassonis <timtas@dplanet.ch>, <linux-kernel@vger.kernel.org>
Subject: Re: fdisk: "File size limit exceeded on fdisk" 2.4.10 to 2.4.13-pre6
In-Reply-To: <E15wQe6-0001wr-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0110241226020.5558-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2001, Alan Cox wrote:

> > The latter seems to be the case because Vita Samel (hope I got this right)
> > just reported that "Booting into 2.4.10-ac10" fixed the problem. Perhaps
> > it once was fixed and later defixed?
>
> Sounds like it. I'll have a look some point next week to see if I can see
> what is up

I'm able fdisk/mke2fs with 2.4.13-pre6 without the error so long as I
don't touch the device with hdparm.

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Developer/Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

