Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266582AbRG1MXp>; Sat, 28 Jul 2001 08:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266583AbRG1MXZ>; Sat, 28 Jul 2001 08:23:25 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:53042 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S266582AbRG1MXR>; Sat, 28 Jul 2001 08:23:17 -0400
Date: Sat, 28 Jul 2001 14:21:57 +0200
From: Kurt Garloff <garloff@suse.de>
To: PEIFFER Pierre <ppeiffer@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA KT133A / athlon / MMX
Message-ID: <20010728142157.A6487@pckurt.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	PEIFFER Pierre <ppeiffer@free.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <E15QE4v-0006R5-00@the-village.bc.nu> <20010728083724.A1571@weta.f00f.org> <3B62F660.FAAB2071@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <3B62F660.FAAB2071@free.fr>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7-SMP i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 28, 2001 at 01:29:04PM -0400, PEIFFER Pierre wrote:
> FYI, according to the user's manual, enabling this option "set the north
> bridge chipset timing parameters more aggressively providing higher
> system performance" (Default value is 'disable'). I can't say more about
> what it does exactly.

A lspci -vxxx of your northbridge with adn without the BIOS option will
reveal more.

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations  <K.Garloff@Phys.TUE.NL>  [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>    [SuSE Nuernberg, DE]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7Yq5lxmLh6hyYd04RAieaAKDBwvGDXdlgtiVaSa/ecz1ZOX/O3gCfcB6g
4ECNbep5ai5EJj9RfIbP25w=
=L0mv
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
