Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284541AbRLESDQ>; Wed, 5 Dec 2001 13:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284537AbRLESDH>; Wed, 5 Dec 2001 13:03:07 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:31885 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S284533AbRLESC6>; Wed, 5 Dec 2001 13:02:58 -0500
Message-ID: <00ba01c17db6$e6963c90$f5976dcf@nwfs>
From: "Jeff Merkey" <jmerkey@timpanogas.org>
To: <erich@uruk.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Larry McVoy" <lm@bitmover.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <E16BY3e-0005S9-00@the-village.bc.nu>
Subject: Re: SMP/cc Cluster description [was Linux/Pro]
Date: Wed, 5 Dec 2001 11:01:44 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: <erich@uruk.org>
Cc: "Larry McVoy" <lm@bitmover.com>; <linux-kernel@vger.kernel.org>
Sent: Wednesday, December 05, 2001 2:09 AM
Subject: Re: SMP/cc Cluster description [was Linux/Pro]


> > For example, there should be no reason that most drivers or any other
> > random kernel module should know anything about SMP.  Under Linux, it
> > annoys me to no end that I have to ever know (and yes, I count compiling
> > against "SMP" configuration having to know)...  more and more sources of
> > error.
>
> Unfortunately the progression with processors seems to be going the
> wrong way. Spin locks are getting more not less expensive. That makes
> CONFIG_SMP=n a meaningful optimisation for the 99%+ of people not running
> SMP

Amen.

Jeff

>
>
> Alan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

