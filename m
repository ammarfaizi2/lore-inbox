Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282836AbRLDB16>; Mon, 3 Dec 2001 20:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282301AbRLDB0y>; Mon, 3 Dec 2001 20:26:54 -0500
Received: from femail5.sdc1.sfba.home.com ([24.0.95.85]:64480 "EHLO
	femail5.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S282306AbRLDB00>; Mon, 3 Dec 2001 20:26:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: John Gluck <jgluck@rogers.com>
Reply-To: jgluck@rogers.com
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: OSS driver cleanups.
Date: Mon, 3 Dec 2001 20:18:45 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <Pine.LNX.4.33.0112031105230.28692-100000@netfinity.realnet.co.sz>
In-Reply-To: <Pine.LNX.4.33.0112031105230.28692-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011204012615.IBYG23527.femail5.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Out of curiosity, will ALSA also be available on the 24..xx kernels??
Will there be a choice of useing OSS or ALSA??
Will the ALSA drivers be the 0.9 series or the old 0.5 series??? AFAIK they 
are very very different in architecture.

I welcome the use of ALSA, as it appears to be a more flexibile solution and 
can be used with OSS compatibility from an application point of view. My only 
concern is that there is a potential for looseing support for some sound 
cards.

John

On December 3, 2001 04:11 am, Zwane Mwaikambo wrote:
> I know OSS will be replaced with ALSA soon, but i've got a couple of OSS
> cleanup patches lined up (module usage count, power management patches
> for two cards) for both 2.4.x and 2.5.x, should i continue with them or is
> it not worthwhile?
>
> Comments appreciated.
>
> Regards,
> 	Zwane Mwaikambo
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
