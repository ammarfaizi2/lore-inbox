Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135671AbRDSNgi>; Thu, 19 Apr 2001 09:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135672AbRDSNg2>; Thu, 19 Apr 2001 09:36:28 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:26127 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S135671AbRDSNgJ>; Thu, 19 Apr 2001 09:36:09 -0400
Date: Thu, 19 Apr 2001 15:33:58 +0200
From: Kurt Garloff <garloff@suse.de>
To: "Robert G. Brown" <rgb@phy.duke.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FPE's
Message-ID: <20010419153358.E22869@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	"Robert G. Brown" <rgb@phy.duke.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0104181920140.32745-100000@ganesh.phy.duke.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Dzs2zDY0zgkG72+7"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0104181920140.32745-100000@ganesh.phy.duke.edu>; from rgb@phy.duke.edu on Wed, Apr 18, 2001 at 07:23:52PM -0400
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dzs2zDY0zgkG72+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2001 at 07:23:52PM -0400, Robert G. Brown wrote:
> A question recently arose on the beowulf list about determining the
> largest possible float or double (or the smallest) that would not
> overflow (or underflow) on a general system, which on the beowulf list
> is not unreasonably a general linux/gnu system.

less /usr/lib/gcc-lib/i?86-*-linux/2.95.3/include/float.h
and look for FLT_MIN/MAX and DBL_MIN/MAX.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--Dzs2zDY0zgkG72+7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4g (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE63ulFxmLh6hyYd04RAvQoAJ9dhSY0CiOSltH+FhPPR1nNaGIaSgCg0zEX
Iir3NeiCh/W03dWX9x6eZ3Y=
=rD7U
-----END PGP SIGNATURE-----

--Dzs2zDY0zgkG72+7--
