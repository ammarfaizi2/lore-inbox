Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288975AbSAUAA6>; Sun, 20 Jan 2002 19:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288974AbSAUAAs>; Sun, 20 Jan 2002 19:00:48 -0500
Received: from smtpsrv0.isis.unc.edu ([152.2.1.139]:39863 "EHLO
	smtpsrv0.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S288973AbSAUAAd>; Sun, 20 Jan 2002 19:00:33 -0500
Date: Sun, 20 Jan 2002 19:00:23 -0500
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DEVFS broken?
Message-ID: <20020121000023.GA30614@opeth.ath.cx>
In-Reply-To: <20020117171229.GA1084@the-penguin.otak.com> <20020117190449.GA2860@opeth.ath.cx> <200201202004.g0KK4aN13185@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <200201202004.g0KK4aN13185@vindaloo.ras.ucalgary.ca>
User-Agent: Mutt/1.3.25i
From: Dan Chen <crimsun@email.unc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Grrr, I realized that I sent undecoded output instead of the ksymoops I
had here. I'll apply this patch and get back to you.

On Sun, Jan 20, 2002 at 01:04:36PM -0700, Richard Gooch wrote:
> In future, please just send dmesg output, rather than
> /var/log/kern.log output. The former doesn't have all the
> date+hostname+" kernel: " crap that syslog puts in.

--=20
Dan Chen                 crimsun@email.unc.edu
GPG key:   www.unc.edu/~crimsun/pubkey.gpg.asc

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8S1oXMwVVFhIHlU4RAoR2AJ4yNl7FIjBukVcIJP0qgMUXzgd9gwCdGGmu
yQDyGll1ioei4GkBANNGyC4=
=iBiI
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
