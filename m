Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281233AbRKLD6Q>; Sun, 11 Nov 2001 22:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281235AbRKLD6F>; Sun, 11 Nov 2001 22:58:05 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:10503 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281233AbRKLD6A>; Sun, 11 Nov 2001 22:58:00 -0500
Message-ID: <001b01c16b2e$164cbcc0$f5976dcf@nwfs>
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
To: "Keith Owens" <kaos@ocs.com.au>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <32224.1005531575@kao2.melbourne.sgi.com>
Subject: Re: [RFC-ONT (on topic)] Modprobe enhancement (was Re: "Dance of the Trolls") 
Date: Sun, 11 Nov 2001 20:57:02 -0700
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

Sounds like it's already there.

Jeff
----- Original Message -----
From: "Keith Owens" <kaos@ocs.com.au>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: <linux-kernel@vger.kernel.org>
Sent: Sunday, November 11, 2001 7:19 PM
Subject: Re: [RFC-ONT (on topic)] Modprobe enhancement (was Re: "Dance of
the Trolls")


> On Sun, 11 Nov 2001 16:49:46 -0700,
> "Jeff V. Merkey" <jmerkey@timpanogas.org> wrote:
> >Anton,
> >
> >This is a great suggestion.  You should ping Keith Owens (does he own
> >modutils, I think so) and make it happen.  A much desireable change.
> >----- Original Message -----
> >From: "Anton Altaparmakov" <aia21@cus.cam.ac.uk>
> >> I think we ought to do the same with closed source drivers. It's true
> >> after all... The whole point of tainting the kernel is so we can just
yell
> >> at users to go and bug the vendor. So the modprobe executable could
warn
> >> the user "hey, you are loading a binary only module, it can break the
> >> system, are you sure?". If the module is autoloaded we don't do jumping
> >> through hoops asking questions so the systen runs smoothly.
>
> Modutils 2.4.9 onwards gives a warning when loading tainted modules,
> including a reason why the tainting occurred.  I will not accept
> anything stronger than a warning, that is the Unix way(TM), give the
> user enough rope to hang themselves.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

