Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270229AbRIAKED>; Sat, 1 Sep 2001 06:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270240AbRIAKDx>; Sat, 1 Sep 2001 06:03:53 -0400
Received: from ns.roland.net ([65.112.177.35]:6416 "EHLO earth.roland.net")
	by vger.kernel.org with ESMTP id <S270229AbRIAKDo>;
	Sat, 1 Sep 2001 06:03:44 -0400
Message-ID: <001101c132cd$cbbf7050$bb1cfa18@JimWS>
From: "Jim Roland" <jroland@roland.net>
To: "David Hollister" <david@digitalaudioresources.org>,
        "Jan Niehusmann" <jan@gondor.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20010831044247.B811@gondor.com> <3B8EFF67.9010409@digitalaudioresources.org>
Subject: Re: Athlon doesn't like Athlon optimisation?
Date: Sat, 1 Sep 2001 05:06:40 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Which kernel are you gentlemen using?  I have a Athlon 1.2GHz (not
overclocked), 512MB PC133, and also an EPoX 8KTA3+, and have had no problems
whatsoever (using kernel 2.4.2-2).

----- Original Message -----
From: "David Hollister" <david@digitalaudioresources.org>
To: "Jan Niehusmann" <jan@gondor.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, August 30, 2001 10:07 PM
Subject: Re: Athlon doesn't like Athlon optimisation?


> Jan Niehusmann wrote:
> > I have a computer with a duron 600 which doesn't like current athlon
> > optimised kernels: It runs fairly well with an old 2.4.0-test7 kernel
> > (but I had some unexplained crashes during the last months),
> > but crashes after a few minutes after booting 2.4.9-ac3 or 2.4.7.
> >
> > If I don't build the kernels for athlon, but for i386 only, the
> > system seems to be stable. (Not tested for more than 20 minutes,
> > but definitely longer than the athlon optimised kernel was able to run)
> >
> > Does anybody know these symptoms and has an idea what may be wrong?
> > Is it likely to be a broken CPU?
> > The board is an A7V with the infamous via chipset, but I don't think
> > this looks like the typical via problems, does it?
> >
> > Jan
>
> This has apparently been a source of frustration for many an Athlon user,
myself
> included.  I can't even get my system to finish the init process before it
> oopses and locks up on me.
>
> It seems to work somewhat better for some if you set your BIOS to the
> conservative settings, but that didn't help me.  I have an Epox 8KTA3+
(Via
> KT133A) w/ a 1.4GHz Athlon and 512MB memory.  If you can't get it to work
that
> way, just stick with the K6 setting.  The point is, your hardware is
likely fine
> (fine being relative, I suppose)
> If there are other tricks, I'm all ears.
>
> --
> David Hollister
> Driversoft Engineering:  http://devicedrivers.com
> Digital Audio Resources: http://digitalaudioresources.org
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

