Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129125AbQJ0SpO>; Fri, 27 Oct 2000 14:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129256AbQJ0Soy>; Fri, 27 Oct 2000 14:44:54 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:43787 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129125AbQJ0Sou>; Fri, 27 Oct 2000 14:44:50 -0400
Message-ID: <39F9CCCB.538FAEBA@transmeta.com>
Date: Fri, 27 Oct 2000 11:43:23 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10-pre3 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu detection fixes for test10-pre4
In-Reply-To: <E13pANf-0004Va-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > >   - make Pentium IV and other post-P6 processors use the "i686"
> > >     family name (same fix as the system_utsname.machine init fix
> > >     which went into include/asm-i386/bugs.h in test10-pre4)
> > >
> >
> > We should never have used anything but "i386" as the utsname... sigh.
> 
> Its questionable if we should include the 'i'
>

True enough, personally I prefer "x86".

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
