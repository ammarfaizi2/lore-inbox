Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264804AbRFSVxR>; Tue, 19 Jun 2001 17:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264807AbRFSVxH>; Tue, 19 Jun 2001 17:53:07 -0400
Received: from lorax.neutraldomain.org ([64.81.248.141]:53253 "HELO
	lorax.neutraldomain.org") by vger.kernel.org with SMTP
	id <S264804AbRFSVwx>; Tue, 19 Jun 2001 17:52:53 -0400
Date: Tue, 19 Jun 2001 14:53:20 -0700
From: Gabriel Rocha <grocha@onesecure.com>
To: Eli Carter <eli.carter@inet.com>
Cc: Gabriel Rocha <grocha@onesecure.com>,
        McHarry John <john.mcharry@gemplex.com>, linux-kernel@vger.kernel.org
Subject: Re: How to compile on one machine and install on another?
Message-ID: <20010619145320.G81548@onesecure.com>
Mail-Followup-To: Eli Carter <eli.carter@inet.com>,
	Gabriel Rocha <grocha@onesecure.com>,
	McHarry John <john.mcharry@gemplex.com>, linux-kernel@vger.kernel.org
In-Reply-To: <A5F553757C933442ADE9B31AF50A273B028DB4@corp-p1.gemplex.com> <20010619143253.F81548@onesecure.com> <3B2FC7F4.2AAA6A8D@inet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Z0mFw3+mXTC5ycVe"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B2FC7F4.2AAA6A8D@inet.com>; from eli.carter@inet.com on Tue, Jun 19, 2001 at 04:45:24PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Z0mFw3+mXTC5ycVe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hey, how and where you export the filesystem is an exercise left for the
reader, i have no problem exporting nfs filesystems in my internal
network, what you do or dont, is up to you. and there is always
cfs...

,----[ On Tue, Jun 19, at 04:45PM, Eli Carter wrote: ]--------------
| Gabriel Rocha wrote:
| >=20
| > you could always compile on one machine and nfs mount the /usr/src/linux
| > and do a make modules_install from the nfs mounted directory...
|=20
| Which would require exporting that filesystem with root permissions
| enabled...any security bells going off?
|=20
| C-ya,
|=20
| Eli=20
| -----------------------.   No wonder we didn't get this right first time
| Eli Carter             |      through. It's not really all that horribly=
=20
| eli.carter(at)inet.com `- complicated, but the _details_ kill you. Linus
`----[ End Quote ]---------------------------

--=20
Gabriel Rocha (grocha@onesecure.com) - 1-877-4-1SECURE
OneSecure, Inc. Sunnyvale Security Operations Center (GMT -0700)

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: 2.6.3ia

mQCNAzrYQA8AAAEEAL/fjYD12U8QNO0PJX30zYd+0Wg1aZq+jPp34hTiMXrGg2bv
VE2hwrcz4iILCaQ5KlncteycMx6VL7u0tnIkxnT0M8fAPuS4VpqB/tS/mr3RcHLa
52+TRZ45KnZt/6pp+pc9zJM8STJvGatfF+YPYKtzEM3mFL4OEnMJdtsEFkx1AAUT
tCRHYWJyaWVsIFJvY2hhIDxncm9jaGFAb25lc2VjdXJlLmNvbT6JAJUDBRA62EAP
cwl22wQWTHUBATrVA/9Z+/pUsd0nV6ZtOn014Q9hJ1TUzhzVcNVF1zUufTHTwLO1
gnKaomNj1Fb+pwGK3ZxNqomUTAnCXCU3HxQ0DkG8OIjzuOIr08Lv57pA9u/yjlTR
IOV5REUNFWD0ogKLAlVG9wp3IsSgntjToB/rj75siVrBapqzbgR+Dcs3nb8Ijg=3D=3D
=3DHwqX
-----END PGP PUBLIC KEY BLOCK-----

--Z0mFw3+mXTC5ycVe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: 2.6.3in

iQCVAwUBOy/J0HMJdtsEFkx1AQFAXAP9Hqj+eEF53lmmD3VYJdTYOgrJBG5Qqcf7
i958RqAm8oXvgFPhNXh06K5NTTfPCO+FczLtvDc7FRwY7oJeTtQSIdW8Ly/C76eu
Ls51yvbYCVqfz9r06QTcZ/bqzqR6IumBoiBaX2YEuEAwxIg6KmA0dFT9HhihtBmq
iOAtNAwLnhQ=
=zFsD
-----END PGP SIGNATURE-----

--Z0mFw3+mXTC5ycVe--
