Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270384AbTGMUog (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 16:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270385AbTGMUof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 16:44:35 -0400
Received: from maild.telia.com ([194.22.190.101]:35326 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id S270384AbTGMUoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 16:44:34 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
Subject: Re: NTFS RW enabled
From: Christian Axelsson <smiler@lanil.mine.nu>
Reply-To: smiler@lanil.mine.nu
To: Niklaus <niklaus@gamebox.net>
Cc: aia21@cantab.net, ntfs@flatcap.org, linux-ntfs-dev@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030714014702.4725a50c.niklaus@gamebox.net>
References: <20030714014702.4725a50c.niklaus@gamebox.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9d2kwrSMbNM2RhGC08sP"
Organization: LANIL
Message-Id: <1058129917.12249.53.camel@sm-wks1.lan.irkk.nu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 13 Jul 2003 22:58:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9d2kwrSMbNM2RhGC08sP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-07-13 at 22:17, Niklaus wrote:,
> 	I have enabled NTFS RW
You  are aware of the risks with rw ntfs right? It can (read will)
eventually corrupt you filesystem (read
http://linux-ntfs.sourceforge.net/info/ntfs.html#3.2 if you havent).

About the error I aint sure, are you sure you added rw as mount option?
Also check permissions.

--=20
Christian Axelsson
smiler@lanil.mine.nu

--=-9d2kwrSMbNM2RhGC08sP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/Ecf9yqbmAWw8VdkRAtRmAJ0fC58Ooik/AVo1txS7cRSb6T9FkACg3bRd
ygWlqB8sV29lcoPhhgMAZ80=
=SUmA
-----END PGP SIGNATURE-----

--=-9d2kwrSMbNM2RhGC08sP--

