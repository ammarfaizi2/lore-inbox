Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265903AbUAKPcR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 10:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265920AbUAKPcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 10:32:17 -0500
Received: from ce.fis.unam.mx ([132.248.33.1]:1156 "EHLO ce.fis.unam.mx")
	by vger.kernel.org with ESMTP id S265903AbUAKPcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 10:32:15 -0500
Subject: Re: 2.6.1-mm1: A couple of problems
From: Max Valdez <maxvalde@fis.unam.mx>
To: Ricardo Galli <gallir@uib.es>
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200401111239.15445.gallir@uib.es>
References: <200401111239.15445.gallir@uib.es>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ms/zpOWt/FaOm09RxP8z"
Message-Id: <1073835119.15915.33.camel@garaged.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 11 Jan 2004 09:31:59 -0600
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ms/zpOWt/FaOm09RxP8z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-01-11 at 05:39, Ricardo Galli wrote:
> Hi Andrew, just a copule of problems with kernel 2.6.1-mm1
>=20
> - artsd running with ALSA gives the error: "CPU overloading, stopping"=20
> just few seconds after it began to play a song. It's a P4 HT with SMP=20
> enabled.

Same problem here with a dual PIII, 1GB RAM, BTW, I'm uncompressing
kernel to build the 2.6.1-mm2 kernel, and preemption is not doing a very
good job, xmms (using xmms-alsa) skips for about 1 second every 5 secs
or so.

>=20
> - Xfree hang: in a Dell Latitude laptop (P3-M 933), xfree (4.3, last=20
> version in Debian experimental) hangs and shows a white screen. The=20
> keyboard is also blocked, but login from the network is still OK. There=20
> is no any error message. I also see the same effect when I tryed to run=20
> Xine in full screen mode.

I dont have that problem, using nvidia propietary module, or the xfree
nv one.

Are you sure you didnt change the keyboard recently ?? maybe xfree is
misconfigured, because that happened to me because of a miscofiguration
of a new keyboard.

Max
--=20
Linux garaged 2.6.1-mm1 #3 SMP Sat Jan 10 13:18:40 CST 2004 i686 Pentium II=
I (Coppermine) GenuineIntel GNU/Linux
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GS/ d-s:a-28C++ILHA+++P+L++>+++E---W++N*o--K-w++++O-M--V--PS+PEY--PGP++t5XR=
tv++b++DI--D-G++e++h-r+y**
------END GEEK CODE BLOCK------
gpg-key: http://garaged.homeip.net/gpg-key.txt

--=-ms/zpOWt/FaOm09RxP8z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAAWxvNNkpVEFxW78RAhX2AJ9tJ0ac/nNd40gI0EBTieEikh40VwCdENz6
RcugJyFZzxMghkpc3Nkr9Yo=
=z2tV
-----END PGP SIGNATURE-----

--=-ms/zpOWt/FaOm09RxP8z--

