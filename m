Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311280AbSCLQks>; Tue, 12 Mar 2002 11:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311281AbSCLQkj>; Tue, 12 Mar 2002 11:40:39 -0500
Received: from sproxy.gmx.de ([213.165.64.20]:19447 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S311280AbSCLQkT>;
	Tue, 12 Mar 2002 11:40:19 -0500
Date: Tue, 12 Mar 2002 17:44:33 +0100
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] My AMD IDE driver, v2.7
Message-Id: <20020312174433.665239e6.sebastian.droege@gmx.de>
In-Reply-To: <20020312172134.A5026@ucw.cz>
In-Reply-To: <E16kYXz-0001z3-00@the-village.bc.nu>
	<Pine.LNX.4.33.0203111431340.15427-100000@penguin.transmeta.com>
	<20020311234553.A3490@ucw.cz>
	<3C8DDFC8.5080501@evision-ventures.com>
	<20020312165937.A4987@ucw.cz>
	<3C8E28A1.1070902@evision-ventures.com>
	<20020312172134.A5026@ucw.cz>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.w+EkXN9yadg:Js"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.w+EkXN9yadg:Js
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Tue, 12 Mar 2002 17:21:34 +0100
Vojtech Pavlik <vojtech@suse.cz> wrote:

> VIA is already OK, well, it has my name in it. :) AMD is now also (well,
> that one wasn't broken, just ugly), SiS is being revamped by Lionel
> Bouton (whom I'm trying to help as much as I can), so yes, PIIX would be
> next.
> 
> PIIX and ICH are pretty crazy hardware from the design perspective, very
> legacy-bound back to the first Intel PIIX chip. And the driver for these
> in the kernel has similarly evolved following the hardware. However, it
> doesn't seem to be wrong at the first glance. Nevertheless, I'll take a
> look at it. Unfortunately, I don't have any Intel hardware at hand to
> test it with.

I have one Intel Corp. 82371AB PIIX4 IDE (rev 01) here and I can test it for you.
This machine isn't very important so it doesn't matter if some data gets shredded ;)
Just send me the patch when you've finished it.

Bye
--=.w+EkXN9yadg:Js
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8jjB0e9FFpVVDScsRAq2/AKDyCo3u6LFW1jXoIs6SZxMhXJp49ACeJYEJ
qhdMVUxLPctDwRvI2R3yu8M=
=nu2D
-----END PGP SIGNATURE-----

--=.w+EkXN9yadg:Js--

