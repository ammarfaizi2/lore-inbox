Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132657AbQLJCI7>; Sat, 9 Dec 2000 21:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132784AbQLJCIt>; Sat, 9 Dec 2000 21:08:49 -0500
Received: from web1106.mail.yahoo.com ([128.11.23.126]:5130 "HELO
	web1106.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S132657AbQLJCIf>; Sat, 9 Dec 2000 21:08:35 -0500
Message-ID: <20001210013803.24830.qmail@web1106.mail.yahoo.com>
Date: Sun, 10 Dec 2000 02:38:03 +0100 (CET)
From: willy tarreau <wtarreau@yahoo.fr>
Subject: Re: [Fwd: NTFS repair tools]
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        Willy Tarreau <wtarreau@free.fr>
Cc: Mark Sutton <mes@capelazo.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan has spoken.  If DANGEROUS doesn't get their
> attention, what will?

Jeff, I know that, but I was speaking about people who
use these features while they don't know they're
dangerous just because someone else has compiled the
kernel for them. There are people who claim to know
linux better than anyone and consider they are better
than anyone at making kernels or distros. these people
are dangerous for people who trust them blindly. In
this case, a warning at mount time may save ignorant
victims.

Perhaps we should more generally display a line at
boot
telling if there were EXPERIMENTAL or DANGEROUS code
compiled in the kernel.

I myself have built kernels with NTFS R/W enabled a
long time ago to try to recover a crashed NT (bad
dll).
as a chance, I've never gave those kernels to anyone,
but it may have been possible that I accidentely reuse
the boot disk for something else ...

Willy


___________________________________________________________
Do You Yahoo!? -- Pour dialoguer en direct avec vos amis, 
Yahoo! Messenger : http://fr.messenger.yahoo.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
