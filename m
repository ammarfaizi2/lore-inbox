Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264802AbRFSVts>; Tue, 19 Jun 2001 17:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264804AbRFSVti>; Tue, 19 Jun 2001 17:49:38 -0400
Received: from odin.sinectis.com.ar ([216.244.192.158]:30995 "EHLO
	mail.sinectis.com.ar") by vger.kernel.org with ESMTP
	id <S264802AbRFSVtZ>; Tue, 19 Jun 2001 17:49:25 -0400
Date: Tue, 19 Jun 2001 18:50:33 -0300
From: John R Lenton <john@grulic.org.ar>
To: linux-kernel@vger.kernel.org
Subject: Re: How to compile on one machine and install on another?
Message-ID: <20010619185033.A2970@grulic.org.ar>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0106191646330.17727-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0106191646330.17727-100000@localhost.localdomain>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 19, 2001 at 04:55:10PM -0400, Tom Diehl wrote:
>=20
> What is the best way to install the modules? Is there a directory _all_ of
> the modules exist in b4 you do "make modules_install". I usually end up
> setting EXTRAVERSION to something unique and doing a make modules_install.
> That way it does not hose up the modules for the build machine.
> Is there a better way?

make-kpkg takes care of all that for you (it's part of kernel-package)

--=20
John Lenton (john@grulic.org.ar) -- Random fortune:
No doubt Jack the Ripper excused himself on the grounds that it was
human nature.

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7L8kpgPqu395ykGsRAm99AJ9N5X8U4GRW/wYHtfo4yoi6mwR+1wCgknTB
VM0mfvmNRtpw97OtzFySGac=
=/VZa
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
