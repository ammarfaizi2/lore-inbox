Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbTENEaG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 00:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbTENEaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 00:30:06 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:17364 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S261196AbTENEaF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 00:30:05 -0400
Date: Wed, 14 May 2003 07:42:38 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: David Caplan <david@david.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ALi M5451/Trident sound module -> video corruption
Message-ID: <20030514044237.GP11374@actcom.co.il>
References: <20030514041227.GB2925@euphoria>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SavPGzlo48F1Gxyz"
Content-Disposition: inline
In-Reply-To: <20030514041227.GB2925@euphoria>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SavPGzlo48F1Gxyz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2003 at 12:12:27AM -0400, David Caplan wrote:
> Hello,
>=20
> I have a Sharp Actius MM10 "sub-notebook", on which I'm running kernel
> 2.4.21-rc1.
> When I load the trident.o sound module, the lcd begins flashing blue
> stripes continuously. I am not up to date on the current issues with
> this driver, am I doing something wrong? could there be some sort of
> hardware
> conflict? or is it a kernel problem?

There aren't any outstanding issues that I know of, the driver has
been stable for a long time. Could you send the output of lspci -vvv?
Also, could you try it with trident built into the kernel?=20

Thanks,=20
Muli.=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--SavPGzlo48F1Gxyz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+wck9KRs727/VN8sRAnpcAJ47csQspTGedfGZ3OpwzpiC3IXmHwCfUSbs
DkPJK9GG19uGxXvgoEFjkKU=
=3dSX
-----END PGP SIGNATURE-----

--SavPGzlo48F1Gxyz--
