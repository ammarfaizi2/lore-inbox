Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272773AbRIMEDa>; Thu, 13 Sep 2001 00:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272783AbRIMEDU>; Thu, 13 Sep 2001 00:03:20 -0400
Received: from static24-72-34-179.reverse.accesscomm.ca ([24.72.34.179]:57818
	"HELO zed.dlitz.net") by vger.kernel.org with SMTP
	id <S272773AbRIMEDE>; Thu, 13 Sep 2001 00:03:04 -0400
Date: Wed, 12 Sep 2001 22:03:26 -0600
From: "Dwayne C. Litzenberger" <dlitz@dlitz.net>
To: Eric Jourdan <Eric.Jourdan@JCS-ConSale.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Errormessage while compiling Kernel
Message-ID: <20010912220326.C2866@zed.dlitz.net>
In-Reply-To: <01091216455601.03859@majestix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
In-Reply-To: <01091216455601.03859@majestix>
User-Agent: Mutt/1.3.20i
X-Homepage: http://www.dlitz.net/
X-Spam-Policy-URL: http://www.dlitz.net/go/spamoff.shtml
X-PGP-Public-Key-URL: http://www.dlitz.net/gpgkey2.asc
X-PGP-ID: 0xE272C3C3
X-PGP-Fingerprint: 9413 0BD2 1030 070E 301E  594F F998 B6D8 E272 C3C3
X-Operating-System: Debian testing/unstable GNU/Linux zed 2.4.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 12, 2001 at 04:45:06PM +0200, Eric Jourdan wrote:
> Hy there,
> I got a error message while I tried to compile the kernel 2.4.8.
>=20
> Here are the last messages from the console:
[snip]
> mv /programme/src/linux-2.4.8/include/linux/modules/pppox.ver.tmp /progra=
mme/src/linux-2.4.8/include/linux/modules/pppox.ver
> make[4]: *** [/programme/src/linux-2.4.8/include/linux/modules/auto_irq.v=
er] Segmentation fault
[snip]
> Is this an error from the kernel or is this a failure from my system?

See:  http://www.bitwizard.nl/sig11/, or do a search for
"linux" "signal 11".

--=20
Dwayne C. Litzenberger - dlitz@dlitz.net

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjugMA4ACgkQ+Zi22OJyw8MMHwCffCbWOKE8rxIqw3ZOGT1ipw+X
3QYAn09mtCcVlQ1K/DfCURZVsOCzEPtj
=le3i
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
