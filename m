Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbTFZPPh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 11:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbTFZPPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 11:15:37 -0400
Received: from 24-216-225-11.charter.com ([24.216.225.11]:40886 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S261876AbTFZPPf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 11:15:35 -0400
Date: Thu, 26 Jun 2003 11:29:46 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: inode problem?
Message-ID: <20030626152946.GN21580@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2xzXx3ruJf7hsAzo"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2xzXx3ruJf7hsAzo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



  I have a system at work that seems to have an ext3 filesystem made=20
with -T largefile when it really shouldn't have and is running low on=20
inodes.  A co-worker has mentioned that reiserfs doesn't have inode=20
problems.  I tried to look this up but am having problems=20
verifying/denying this:

{0}:Documentation>host www.reiserfs.org
www.reiserfs.org does not exist, try again

Whois also doesn't return anything.  Anyone have any proof either way
and news on the current stability of reiserfs in the 2.4.21 tree?

Robert


:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu=20
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Diagnosis: witzelsucht  =09

IPv6 =3D robert@ipv6.rdlg.net	http://ipv6.rdlg.net
IPv4 =3D robert@mail.rdlg.net	http://www.rdlg.net

--2xzXx3ruJf7hsAzo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE++xFq8+1vMONE2jsRAnbtAJ9MeA2SiG10GcBAxYmdDG47cRuZyACffzVu
Q5CnMFHMZgISeHguDdhaFuU=
=cjUe
-----END PGP SIGNATURE-----

--2xzXx3ruJf7hsAzo--
