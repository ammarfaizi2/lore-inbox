Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280787AbRKLODH>; Mon, 12 Nov 2001 09:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280789AbRKLOC5>; Mon, 12 Nov 2001 09:02:57 -0500
Received: from adsl-40-3-basel1.tiscalinet.ch ([212.254.40.3]:53031 "EHLO
	avalon.ethgen.de") by vger.kernel.org with ESMTP id <S280787AbRKLOCs>;
	Mon, 12 Nov 2001 09:02:48 -0500
Message-ID: <XFMail.20011112150244.Klaus@Ethgen.de>
X-Mailer: XFMail 1.4.7p2 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
Date: Mon, 12 Nov 2001 15:02:44 +0100 (CET)
From: Klaus Ethgen <Klaus@Ethgen.de>
To: linux-kernel@vger.kernel.org
Subject: System hang in 2.4.13 and 2.4.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----

Hello,

I run kernel 2.4.12-ac6 as very stable kernel for long time. Now I tryed to
use 2.4.13-ac8 and 2.4.14 with ext3-Patch. 2.4.14 did some
filesystemcoruption with ext3 and 2.4.13 did hung after about 1-2 hours
runtime with the LED of scroll- and caps-lock on.

I don't know what reason the hang had. I tryed out ext3 with 2.4.13-ac8 and
2.4.14 first. Also I switched framebuffer from module to fix in kernel. But
the hung was happened when the disk was acceced.

At other configuration I use:
The system is debian-woody.
I use lvm with some partitions (I did this also in 2.4.12)
I might send the full configuration on request.

Yours
   Klaus Ethgen

- -- 
Klaus Ethgen                            http://www.ethgen.de/
pub  2048R/D1A4EDE5 2000-02-26 Klaus Ethgen <Klaus@Ethgen.de>
Fingerprint: D7 67 71 C4 99 A6 D4 FE  EA 40 30 57 3C 88 26 2B

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iQEVAwUBO+/Wg5+OKpjRpO3lAQGITAgAlnGkgP8+19gDB0dL5Rj93/Llb1pWo9AN
TDX0eq8/1BduAGKw7U06AnpVoPEvjUFjTk3CLXY6Hv4lMDVQcwJADGjo3/BNiplj
xMgehnO8ogXyy+qqCmZ93PnKeR4HtWDAVgf682g8AcvaPEZPQ06pwmjZEyj2moHy
OCoYYV8IV/SASnUF2fSi7HzM6ZXxHhtWAdtXW20p7uUQcTW+Z8dm+18fmmXDRxf5
yGzioc2IXZWG7144W2fiykPintHL6lvPGOrsT0Dikn0FvHrZBoql9Gk0RYTaT/86
SiRi8nTihXpJqn+9kS9Q+laah/5+/rkfYR4SwKlpH5BYMpFzR0R0ZA==
=jZSf
-----END PGP SIGNATURE-----
