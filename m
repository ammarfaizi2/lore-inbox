Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292657AbSBZSbc>; Tue, 26 Feb 2002 13:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292420AbSBZS34>; Tue, 26 Feb 2002 13:29:56 -0500
Received: from duba05h05-0.dplanet.ch ([212.35.36.52]:51461 "EHLO
	duba05h05-0.dplanet.ch") by vger.kernel.org with ESMTP
	id <S292663AbSBZS2a>; Tue, 26 Feb 2002 13:28:30 -0500
Date: Tue, 26 Feb 2002 19:28:15 +0100
From: Andreas Tscharner <starfire@dplanet.ch>
To: Guido Volpi <lugburz@tiscalinet.it>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: oproblem with nvidia driver
Message-Id: <20020226192815.4061fb76.starfire@dplanet.ch>
In-Reply-To: <200202261447.g1QElLO02468@localhost.localdomain>
In-Reply-To: <200202261447.g1QElLO02468@localhost.localdomain>
Organization: No Such Penguin
X-Mailer: Sylpheed version 0.7.1claws12 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.u3w1wCYVvKm:OR"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.u3w1wCYVvKm:OR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Feb 2002 14:47:21 +0000
Guido Volpi <lugburz@tiscalinet.it> wrote:

> it's all right: nvidia modules depend only by nvidia, but i don't understand 
> why a module that is perfect (or so) with 2.4.17 in 2.4.18-rc4 is no more 
> usabily.

I think you're mixing up two different things.

The NVidia drivers from NVidia will work with the 2.4.x kernel series

But
in the 2.5.x kernel series internal stuff has been changed, and therefore, the modules won't work any longer...

Regards
	Andreas
-- 
Andreas Tscharner                                     starfire@dplanet.ch
-------------------------------------------------------------------------
"Programming today is a race between software engineers striving to build 
bigger and better idiot-proof programs, and the Universe trying to produce
bigger and better idiots. So far, the Universe is winning." -- Rich Cook 

--=.u3w1wCYVvKm:OR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8e9PJd6icl+PTsS8RArUjAJ9TsiiInM8o5IDmIOwiI99N+TwQjwCfbz1c
we+QLnM204nRAp4nxqWJdZ0=
=N1Mw
-----END PGP SIGNATURE-----

--=.u3w1wCYVvKm:OR--

