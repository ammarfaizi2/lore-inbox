Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272777AbRIMDxt>; Wed, 12 Sep 2001 23:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272789AbRIMDxj>; Wed, 12 Sep 2001 23:53:39 -0400
Received: from static24-72-34-179.reverse.accesscomm.ca ([24.72.34.179]:31701
	"HELO zed.dlitz.net") by vger.kernel.org with SMTP
	id <S272777AbRIMDx2>; Wed, 12 Sep 2001 23:53:28 -0400
Date: Wed, 12 Sep 2001 21:53:50 -0600
From: "Dwayne C. Litzenberger" <dlitz@dlitz.net>
To: Phil Thompson <Phil.Thompson@pace.co.uk>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: User Space Emulation of Devices
Message-ID: <20010912215350.B2866@zed.dlitz.net>
In-Reply-To: <54045BFDAD47D5118A850002A5095CC30AC57D@exchange1.cam.pace.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <54045BFDAD47D5118A850002A5095CC30AC57D@exchange1.cam.pace.co.uk>
User-Agent: Mutt/1.3.20i
X-Homepage: http://www.dlitz.net/
X-Spam-Policy-URL: http://www.dlitz.net/go/spamoff.shtml
X-PGP-Public-Key-URL: http://www.dlitz.net/gpgkey2.asc
X-PGP-ID: 0xE272C3C3
X-PGP-Fingerprint: 9413 0BD2 1030 070E 301E  594F F998 B6D8 E272 C3C3
X-Operating-System: Debian testing/unstable GNU/Linux zed 2.4.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2001 at 09:25:08AM +0100, Phil Thompson wrote:
> Without going into the gory details, I have a requirement for a device
> driver that does very little apart from pass on the open/close/read/write
> "requests" onto a user space application to implement and pass back to the
> driver.
>=20
> Does anything like this already exist?

I think the HURD does something like this.  I can't say any more than that,
since I haven't actually run it yet. :-)

--=20
Dwayne C. Litzenberger - dlitz@dlitz.net

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjugLc4ACgkQ+Zi22OJyw8M4igCgnLTS11DJDF0yeXDLY4bNLauD
0TQAnjEE9aFSyyw5BRPu73HrnWYHETDo
=p/X5
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
