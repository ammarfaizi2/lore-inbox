Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264092AbRFSVcn>; Tue, 19 Jun 2001 17:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264799AbRFSVcd>; Tue, 19 Jun 2001 17:32:33 -0400
Received: from lorax.neutraldomain.org ([64.81.248.141]:41733 "HELO
	lorax.neutraldomain.org") by vger.kernel.org with SMTP
	id <S264092AbRFSVc0>; Tue, 19 Jun 2001 17:32:26 -0400
Date: Tue, 19 Jun 2001 14:32:53 -0700
From: Gabriel Rocha <grocha@onesecure.com>
To: "McHarry, John" <john.mcharry@gemplex.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to compile on one machine and install on another?
Message-ID: <20010619143253.F81548@onesecure.com>
Mail-Followup-To: "McHarry, John" <john.mcharry@gemplex.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <A5F553757C933442ADE9B31AF50A273B028DB4@corp-p1.gemplex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="5Mfx4RzfBqgnTE/w"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <A5F553757C933442ADE9B31AF50A273B028DB4@corp-p1.gemplex.com>; from john.mcharry@gemplex.com on Tue, Jun 19, 2001 at 04:32:03PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5Mfx4RzfBqgnTE/w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

you could always compile on one machine and nfs mount the /usr/src/linux
and do a make modules_install from the nfs mounted directory...

,----[ On Tue, Jun 19, at 04:32PM, McHarry, John wrote: ]--------------
| I am trying to compile the 2.2.19 kernel one one machine for  installation
| on another.  I believe I need to do more than just copy over  bzImage and
| modify lilo.conf, but I don't know what.  Is there documentation somewhere
| on how to do this?  Thanks.
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
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

--5Mfx4RzfBqgnTE/w
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: 2.6.3in

iQCVAwUBOy/FBXMJdtsEFkx1AQHoCwP+P7/VemLwf32wqUn5sm0n8wJMUhNnMB8F
EDFFKd86J+Wez18JRN8PopJRlq924JVtn1JuPLgMDrIgGI43Xb24+w5CC/iYHFEL
T4yvg6ZMyM55itMbV2XwD30DfuyKZY70BK2+2xWlje8OuGZuXl7yGGFk95f6VGtl
Un4MiaMYu4w=
=XXtl
-----END PGP SIGNATURE-----

--5Mfx4RzfBqgnTE/w--
