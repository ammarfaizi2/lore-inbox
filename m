Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287493AbSA0CNo>; Sat, 26 Jan 2002 21:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287500AbSA0CNe>; Sat, 26 Jan 2002 21:13:34 -0500
Received: from smtpsrv1.isis.unc.edu ([152.2.1.138]:43979 "EHLO
	smtpsrv1.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S287493AbSA0CNX>; Sat, 26 Jan 2002 21:13:23 -0500
Date: Sat, 26 Jan 2002 21:13:21 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [CFT] Bus mastering support for IDE CDROM audio
Message-ID: <20020127021321.GA6021@opeth.ath.cx>
In-Reply-To: <3C5119E0.6E5C45B6@zip.com.au> <000701c1a5d5$812ef580$6caaa8c0@kevin>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <000701c1a5d5$812ef580$6caaa8c0@kevin>
User-Agent: Mutt/1.3.27i
From: Dan Chen <crimsun@email.unc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I should note that I have only devices marked "master" on both IDE
channels (1 HD on ide0, 1 ATAPI cdrw on ide1).

On Fri, Jan 25, 2002 at 12:21:35PM -0700, Kevin P. Fleming wrote:
> There are two CD-ROM drives, master and slave on the secondary channel of
> the VIA controller. There are also four hard drives, spread across the re=
st
> of the channels (three of them on the Promise controller), configured as a
> software raid-5 array, with ext3 volumes on top of that. Kernel is
> 2.4.18-pre7, plus this patch, plus Ingo's O(1)-J6 scheduler patch.

--=20
Dan Chen                 crimsun@email.unc.edu
GPG key:   www.unc.edu/~crimsun/pubkey.gpg.asc

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8U2JBMwVVFhIHlU4RAhwbAJ9uDbMZRBP6PBHILg0RZKd+UGJnQgCePyNx
QucXeK9AtEceTx+aBwEG1kI=
=aYag
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
