Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316541AbSFPTlN>; Sun, 16 Jun 2002 15:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316535AbSFPTlM>; Sun, 16 Jun 2002 15:41:12 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:55145 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S316533AbSFPTlL>; Sun, 16 Jun 2002 15:41:11 -0400
Date: Sun, 16 Jun 2002 21:41:12 +0200
From: Kurt Garloff <garloff@suse.de>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: /proc/scsi/map
Message-ID: <20020616194111.GA21461@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Richard Gooch <rgooch@ras.ucalgary.ca>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Linux SCSI list <linux-scsi@vger.kernel.org>
References: <20020615133606.GC11016@gum01m.etpnet.phys.tue.nl> <200206151552.g5FFqCT14714@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <200206151552.g5FFqCT14714@vindaloo.ras.ucalgary.ca>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Richard,

I was in no way intending to trigger a discussion about devfs.
Some of the things addressed by the scsi/map patch indeed are no issue if
you use devfs; that's why I mentioned devfs at all.
I don't want to bash devfs and I think it's nice that it's in the kernel,=
=20
so users have the choice to use it and the motivation to improve it.

But the problem that I wanted to address IMHO should also be solved
for those people that for one or another reason decided not to use
devfs.=20

And face it: I do not think that all major Linux distributions will
start to use devfs within short future. The example you mentioned
(Mandrake) is certainly not a good one: Look at their update kernel.

Best regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9DOnXxmLh6hyYd04RAmMWAJ9yIpyrrb1Mi9iB2ZVuITQ1gqOjiQCfQYY4
vdrXOtB3kDgr4FmRQU/SuUE=
=3uq0
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
