Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130255AbQLXVam>; Sun, 24 Dec 2000 16:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130331AbQLXVac>; Sun, 24 Dec 2000 16:30:32 -0500
Received: from air.lug-owl.de ([62.52.24.190]:14601 "HELO air.lug-owl.de")
	by vger.kernel.org with SMTP id <S130255AbQLXVaV>;
	Sun, 24 Dec 2000 16:30:21 -0500
Date: Sun, 24 Dec 2000 21:59:48 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: sparc 10 w/512 megs hangs during boot
Message-ID: <20001224215947.A29720@lug-owl.de>
Reply-To: jbglaw@lug-owl.de
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20001224204844.3587.qmail@web1002.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001224204844.3587.qmail@web1002.mail.yahoo.com>; from ronnnyc@yahoo.com on Sun, Dec 24, 2000 at 12:48:44PM -0800
X-Operating-System: Linux air 2.4.0-test8-pre1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 24, 2000 at 12:48:44PM -0800, Ron Calderon wrote:
> I just finished compiling 2.4.0-test5 and that worked
> fine with 512M ram. I'll start going thru the other
> kernels. It'll take me sometime since compileing takes
> a long time.

I've not yet started active searching. However:
	- test5		is fine
	- test13-pre3	is not

I don't know how fast your machine is, but we should coordinate out
search... I'll try to build -test10final (with minimal config to
only test boot) so that shouldn't take so very long... You should
test sth around -test8...

MfG, JBG

--=20
Fehler eingestehen, Gr=F6=DFe zeigen: Nehmt die Rechtschreibreform zur=FCck=
!!!
/* Jan-Benedict Glaw <jbglaw@lug-owl.de> -- +49-177-5601720 */
keyID=3D0x8399E1BB fingerprint=3D250D 3BCF 7127 0D8C A444 A961 1DBD 5E75 83=
99 E1BB
     "insmod vi.o and there we go..." (Alexander Viro on linux-kernel)

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjpGY8MACgkQHb1edYOZ4buWVQCfceD6hPJNOGS1FfXiH+lMMWVy
zFIAoIbZGYObIJVfa3hvpulC+qLhAaAa
=nh3I
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
