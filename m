Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130740AbQJ1UCJ>; Sat, 28 Oct 2000 16:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131258AbQJ1UCA>; Sat, 28 Oct 2000 16:02:00 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:41224 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130740AbQJ1UBw>; Sat, 28 Oct 2000 16:01:52 -0400
Message-ID: <39FB2FC2.28572A70@timpanogas.org>
Date: Sat, 28 Oct 2000 13:57:54 -0600
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Gregory Maxwell <greg@linuxpower.cx>,
        Mark Spencer <markster@linux-support.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.0-test9 not Open Source
In-Reply-To: <E13pZq3-0005TZ-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:
> 
> > In this case, Debian (or any organization who isn't big enough not to fear
> > M-systems) may not ship the standard kernel because it has additional patent
> > restrictions.
> 
> Why. There are no distribution restrictions
> 
> > There is a clear ability here for the author of the driver and m-systems to
> > conspire to retroactively revoke anyones privilege to use, modify, or
> > distribute the stock kernel because of this code.
> 
> I fail to see how
> 


Alan is right.  The way it's worded, they could never show a case for
"irreparable harm" to any sitting judge in the US.   This means they
could say "we've changed our minds, and revoke this persons or that
person's license" but given it's been released with this language, no
case for harm or damages, or even a petition for injunctive relief would
have a snowball's change in hell of succeeding.  

If you release code under the GPL, you basically waive any rights to
seek enforcement because in the US, you must be able to show
"irreparable harm" from some parties use of the code.  It's tough to do
this if you've given the code away (which the GPL does) without a
contractural requirement for "consideration" ($$$).  The GPL in the
strictest legal sense is the ultimate IP legal virus because it not only
removes the basis for damages claims for use of present code released
under it's terms, but since it covers derivative works, it's effect
contaminates all future incarnations of the code.

It's true with how this is worded, the party could come back and attempt
to modify the scope, but they would be hard pressed to make a case for
an injunction to halt someone's use of the code.

:-)

Jeff



> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
