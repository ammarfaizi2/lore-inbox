Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbUCVUV6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 15:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUCVUV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 15:21:58 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:14806 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S262509AbUCVUV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 15:21:56 -0500
Date: Mon, 22 Mar 2004 21:21:55 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Disassemble vmlinuz (i386)
Message-ID: <20040322202155.GJ17857@lug-owl.de>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040322175807.GA22404@us.ibm.com> <200403221821.i2MILCox004241@eeyore.valparaiso.cl> <20040322191810.GB22607@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xbxyguyUcy/oJisi"
Content-Disposition: inline
In-Reply-To: <20040322191810.GB22607@us.ibm.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xbxyguyUcy/oJisi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-03-22 11:18:10 -0800, Russ Weight <rweight@us.ibm.com>
wrote in message <20040322191810.GB22607@us.ibm.com>:
> The decompressed file did not contain an elf header, and could not be
> opened with objdump.

--target=3Dbinary and possibly --adjust-vma=3D0xXXXXXXXX

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--xbxyguyUcy/oJisi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAX0rjHb1edYOZ4bsRApPFAJ96peduhV+4Rpqw9NJdfsNWUltYlwCfeBEM
MAtT03XYmyisvzMJgYQyc68=
=ltWR
-----END PGP SIGNATURE-----

--xbxyguyUcy/oJisi--
