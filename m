Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130770AbQLCRQR>; Sun, 3 Dec 2000 12:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130901AbQLCRQH>; Sun, 3 Dec 2000 12:16:07 -0500
Received: from smtpnotes.altec.com ([209.149.164.10]:9989 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S130770AbQLCRPy>; Sun, 3 Dec 2000 12:15:54 -0500
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: pavel@suse.cz, linux-kernel@vger.kernel.org
Message-ID: <862569AA.005C068D.00@smtpnotes.altec.com>
Date: Sun, 3 Dec 2000 10:41:20 -0600
Subject: Re: Fasttrak100 questions...
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Where can this Lucent driver be found?  The one I use with my Thinkpad is
version 5.68.  It comes as a loadable module (ltmodem.o) with no serial.c, and I
havent gotten it to work with any kernel later than 2.2.14.





Pavel Machek <pavel@suse.cz> on 12/02/2000 10:50:35 AM

To:   Alan Cox <alan@lxorguk.ukuu.org.uk>, "Dr. Kelsey Hudson"
      <kernel@blackhole.compendium-tech.com>
cc:   "Henning P. Schmiedehausen" <hps@tanstaafl.de>,
      linux-kernel@vger.kernel.org (bcc: Wayne Brown/Corporate/Altec)

Subject:  Re: Fasttrak100 questions...



Hi!

> > You are wrong: If you modify the kernel you have to make it available for
> > anyone who wishes to use it; that's also in the GPL. You can't add stuff
>
> No it isnt. Some people seem to think it is. You only have to provide a
> change if you give someone the binaries concerned. Some people also think
> that 'linking' clauses mean they can just direct the customer to do the link,
> that also would appear to be untrue in legal precedent - the law cares about
> the intent.

This is currently happening with lucent winmodem driver: there's
modified version of serial.c, and customers are asked to compile it
and (staticaly-)link it against proprietary code to get usable
driver. Is that okay or not?
                                         Pavel
--
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
