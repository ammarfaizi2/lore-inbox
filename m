Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274248AbRJYQ0o>; Thu, 25 Oct 2001 12:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275709AbRJYQ0g>; Thu, 25 Oct 2001 12:26:36 -0400
Received: from viper.haque.net ([66.88.179.82]:16521 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S274248AbRJYQ0V>;
	Thu, 25 Oct 2001 12:26:21 -0400
Newsgroups: linux.dev.kernel
Date: Thu, 25 Oct 2001 12:25:30 -0400 (EDT)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: bill davidsen <davidsen@tmr.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: fdisk: "File size limit exceeded on fdisk" 2.4.10 to 2.4.13-pre6
In-Reply-To: <LCWB7.5048$ag6.923038958@newssvr17.news.prodigy.com>
Message-ID: <Pine.LNX.4.33.0110251222090.25423-100000@viper.haque.net>
In-Reply-To: <Pine.LNX.4.33.0110242100070.14064-100000@viper.haque.net>
 <LCWB7.5048$ag6.923038958@newssvr17.news.prodigy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2001, bill davidsen wrote:

> I haven't seen any problem, either. Certainly not with fdisk, this is
> what I see:
> ================================================================
> bilbo:root> hdparm -V
> hdparm v3.9
>
> bilbo:root> df
> ....
>
> Don't know if this sheds light on the topic, I certainly do run fdisk on
> "drives" my RAID controller creates which have 600GB or so broken into
> little 100GB files.

I guess it was unclear at first. You'll only get the error when you run
mke2fs.

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Developer/Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================


