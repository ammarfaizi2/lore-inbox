Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262266AbVAJNuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbVAJNuM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 08:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbVAJNuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 08:50:11 -0500
Received: from ns.schottelius.org ([213.146.113.242]:34440 "HELO
	scice.schottelius.org") by vger.kernel.org with SMTP
	id S262266AbVAJNtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 08:49:02 -0500
Date: Mon, 10 Jan 2005 14:50:14 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Merging devfs to udev
Message-ID: <20050110135014.GE1957@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	linux-kernel@vger.kernel.org
References: <20041117113123.GE2282@schottelius.org> <Pine.LNX.4.53.0411171457500.31693@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eDB11BtaWSyaBkpc"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0411171457500.31693@yvahk01.tjqt.qr>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eDB11BtaWSyaBkpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jan Engelhardt [Wed, Nov 17, 2004 at 02:58:12PM +0100]:
> >Is there a howto available to merge devfs systems to udev?
> >
> >I just accomplished this task and wanted to ask whether there
> >is a need to for that.
>=20
> What do you mean by merge? Disable devfs-fs, devfsd and switching to udev=
? (So,
> mostly the userspace part?)

Yes, userspace part. Having a look at /etc/{inittab,fstab} and other
init related tools.

Nico

--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org

--eDB11BtaWSyaBkpc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQIVAwUBQeKIFLOTBMvCUbrlAQLmcg/7BcVWyg/in+ZLgsH0V+KJQqLoDBGYXz55
qFdMTSg9daCN5v6/zk31OnbUis+iAnsjMR9nmK6uF1CBB+M1Gd/dVvHVdGDdGyk+
BB5lKS82Icht6bm+RDG/dqSmEnJukXRh5rc2Pwa1aFPpxEVPTBFUI0JAeV8fYS7a
wVlpvHYJfiAcSTHLAbEtOAr1XQSkJm2y95CUVSTENeodP8EWYkzNqF24pZMIWxrW
7wxtQG74Pm7WMjBN0C7qxFe+elAMhGdjry0qIeB9QQD7WKRRaCVa2SARyya6QNAl
R8KafGBYLuwsKnfEUmM44ZWkJYqiTI59Tx/NDlSRfSJ1Oz5Gk0qdvHux39AbhyGE
rAi5KWPSVTYRj5VznGUArcSR9fbvrKRq5UjVQXDz6VXpiwOyprGge1Xol+/g2FS4
YnPCJsIV0K8oTIb4Lda+O8Mn9g/ctgYGRP2N4P9+PIYawT27HaNTidPLURc8jgcB
D3lFYp2nqdHbLtD+j8dL6/AFpHJ0eX3zlw8RkCo5qy03A4yd1v4+bHsyFMoIRqwM
B8yR8St9y8+sSucQ1tlsrpUa3MUY0ti1f+2ZkCimaVu+5yjk6AUAX3Ka94hJeoGN
r5cizLfKqBRC/MdLJJNn4aipVrCp75T1VYqytV2zdB35TsMH4qqJQlpDopt4tgjV
7GpQeNC0BFE=
=HQDS
-----END PGP SIGNATURE-----

--eDB11BtaWSyaBkpc--
