Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129615AbQKCKDO>; Fri, 3 Nov 2000 05:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129549AbQKCKDF>; Fri, 3 Nov 2000 05:03:05 -0500
Received: from james.kalifornia.com ([208.179.0.2]:54900 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S129144AbQKCKC6>; Fri, 3 Nov 2000 05:02:58 -0500
Message-ID: <3A028D2E.8083B30D@kalifornia.com>
Date: Fri, 03 Nov 2000 02:02:22 -0800
From: Ben Ford <ben@kalifornia.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: warp@whitestar.soark.net
CC: Ragnar Hojland Espinosa <ragnar@jazzfree.com>,
        linux-kernel@vger.kernel.org, "M.H.VanLeeuwen" <vanl@megsinet.net>,
        "CRADOCK, Christopher" <cradockc@oup.co.uk>, torvalds@transmeta.com
Subject: Re: Linux-2.4.0-test10
In-Reply-To: <A528EB7F25A2D111838100A0C9A6E5EF068A1DBC@exc01.oup.co.uk> <3A00B8E9.D5FD12B0@megsinet.net> <20001102185706.A984@macula.net> <20001102193856.A1204@macula.net> <20001103012510.A22193@whitestar.soark.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have this problem also.  I am running vesafb and X4.01 w/ a voodoo3500.
Switching to a vc sometimes gives you black text (hiliting w/ mouse fixes it) and
alternating green and red pixels across the top of the screen.

-b


kernel@whitestar.soark.net wrote:

> On Thu, Nov 02, 2000 at 07:38:56PM +0100, Ragnar Hojland Espinosa wrote:
> > On Thu, Nov 02, 2000 at 06:57:06PM +0100, Ragnar Hojland Espinosa wrote:
> > > Well, here never did until today :)   With test9, I had left the box idle
> >
> > Just happened with test10, same circumstances .. font map got corrupted, and
> > noise on the screen.  Switching back and forth from X to a vc fixed it, tho.
> >
> > Sort of amusing that it (apparently) only happens with ppp + wget ..
>
> You have a voodoo3 or voodoo5 with X4, and the DRI X4 module loaded.
>
> Or am I wrong?
>
> Zephaniah E. Hull.
> >
> > --
> > ____/|  Ragnar Højland     Freedom - Linux - OpenGL      Fingerprint  94C4B
> > \ o.O|                                                   2F0D27DE025BE2302C
> >  =(_)=  "Thou shalt not follow the NULL pointer for      104B78C56 B72F0822
> >    U     chaos and madness await thee at its end."       hkp://keys.pgp.com
> >
> > Handle via comment channels only.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
