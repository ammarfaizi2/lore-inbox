Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266404AbRGBITz>; Mon, 2 Jul 2001 04:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266405AbRGBITq>; Mon, 2 Jul 2001 04:19:46 -0400
Received: from mailhost.lineo.fr ([194.250.46.226]:30991 "EHLO
	mailhost.lineo.fr") by vger.kernel.org with ESMTP
	id <S266404AbRGBIT3>; Mon, 2 Jul 2001 04:19:29 -0400
Date: Mon, 2 Jul 2001 10:19:21 +0200
From: =?ISO-8859-1?Q?christophe_barb=E9?= <christophe.barbe@lineo.fr>
To: linux-kernel@vger.kernel.org
Cc: Dmitry Meshchaninov <dima@flash.datafoundation.com>
Subject: Re: qlogicfc driver
Message-ID: <20010702101921.E20709@pc8.lineo.fr>
In-Reply-To: <Pine.LNX.4.30.0106291714470.11344-100000@flash.datafoundation.com> <3B3CF618.DDE40F17@mandrakesoft.com> <15164.64070.934822.960708@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <15164.64070.934822.960708@pizda.ninka.net>; from davem@redhat.com on ven, jun 29, 2001 at 23:59:34 +0200
X-Mailer: Balsa 1.1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry,

Could you post your driver, please, to the lkml (It should not be so big)
or to me if you prefer. I would like to test it. Files (instead of patches)
are ok for me.

Christophe ...

Le ven, 29 jun 2001 23:59:34, David S. Miller a écrit :
> 
> Jeff Garzik writes:
>  > If you are working on qlogicfc, that's great!
>  > 
>  > But since others are currently using this driver without problems, you
>  > might consider sending in your patches separated out (per
>  > Documentation/SubmittingPatches) so that it is easier for others to
>  > review and apply them in turn.
> 
> One thing that is especially important is multi-platform testing
> since the current driver does use all of the proper APIs and is
> mindful of endianness and word size issues.
> 
> Later,
> David S. Miller
> davem@redhat.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
-- 
Christophe Barbé
Software Engineer - christophe.barbe@lineo.fr
Lineo France - Lineo High Availability Group
42-46, rue Médéric - 92110 Clichy - France
phone (33).1.41.40.02.12 - fax (33).1.41.40.02.01
http://www.lineo.com
