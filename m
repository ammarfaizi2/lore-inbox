Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267457AbUIWV5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267457AbUIWV5U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267464AbUIWV5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:57:06 -0400
Received: from zeus.kernel.org ([204.152.189.113]:17401 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S267457AbUIWVyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:54:52 -0400
Date: Thu, 23 Sep 2004 17:54:47 -0400
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Andrew Morton <akpm@osdl.org>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [1/1] connector: Kernel connector - userspace <-> kernelspace "linker".
Message-ID: <20040923215447.GD30131@ruslug.rutgers.edu>
Mail-Followup-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	Andrew Morton <akpm@osdl.org>, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
References: <1095331899.18219.58.camel@uganda> <20040921124623.GA6942@uganda.factory.vocord.ru> <20040924000739.112f07dd@zanzibar.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <20040924000739.112f07dd@zanzibar.2ka.mipt.ru>
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
From: mcgrof@studorgs.rutgers.edu (Luis R. Rodriguez)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


RFC:=20

Can and should we work towards using this as interface for drivers that
need callbacks from an external (closed source) library/HAL?

--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBU0Ynat1JN+IKUl4RAv84AJ48EAwhP4PmmERogfg6cyipV2jYNgCfWMCF
LCot3fpQXCwbd5Y/T+4cJPc=
=4RAE
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
