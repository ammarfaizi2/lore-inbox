Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVEIPWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVEIPWW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 11:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVEIPWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 11:22:22 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:21186 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261426AbVEIPVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 11:21:53 -0400
Date: Mon, 9 May 2005 17:21:39 +0200
From: lkml@think-future.de
To: Linux Kernel-Liste <linux-kernel@vger.kernel.org>
Subject: bind racoon/ipsec config to specific interfaces?
Reply-To: Nils Radtke <Nils.Radtke@Think-Future.de>
Mail-Followup-To: Nils Radtke <Nils.Radtke@Think-Future.de>,
	Linux Kernel-Liste <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
X-Url: http://www.Think-Future.de
X-Editor: Vi it! http://www.vim.org
X-Bkp: p2mi
X-GnuPG-Key: gpg --keyserver gpg-keyserver.de --recv-keys 06232116
User-Agent: Mutt/1.5.6+20040907i
Message-Id: <20050509152140.0D45C144050@service.i-think-future.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:35131867b06e6a502cee335cb348919d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  Hi,

  is there a viable way to bind the racoon config to a specific
  interface?

  We need this in order to get transparent ipsec to work.=20
  So far, the racoon config is global that is, all interfaces are
  affected. This results from the configurability based on network
  addresses only.
  What we have here is a bridge that needs to do an ipsec job.

  Thanks for ideas and hints!


    Nils


--=20
A+
* N.Radtke@                 * University of Stuttgart *    icq / lc   *
*      www.Think-Future.de  *    dep.comp.science     * 9336272/92045 *
:x                            UTM 32 0515651 5394088                 :)
   The executioner is, I hear, very expert, and my neck is very
   slender.   -- Anne Boleyn=20
  =20

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Nils Radtke

iD8DBQFCf4ACX3r3ggYjIRYRAv4lAJ45GJVhrnlu2Qz2Akjc3FRrCrSzRwCfWqoW
JnKIKdxwfzXFm0G0zkx+Jzs=
=b2oZ
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
